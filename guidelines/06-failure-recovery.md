# 실패 복구 프로토콜

실패는 정상이다. **은폐가 비정상이다**.

---

## 기본 원칙

1. **실패를 조용히 넘기지 않는다** — 반드시 기록
2. **원인 파악 전엔 재시도하지 않는다** — 같은 실패 2회 이상 허용되지 않음
3. **복구 행동은 state에 남긴다** — 다음 세션이 이해할 수 있어야 함

---

## 실패 유형별 절차

### A. 명령 실행 실패 (runbook의 bash 블록)

1. 명령 stderr 전체를 **원문 그대로** 보관 (요약은 나중에)
2. runbook의 "실패 시" 섹션에 **이 증상이 이미 있는지** 확인
3. 있음 → 해당 대응 실행
4. 없음 → **재시도 금지**, 사람에게 보고 + `work-plans/`에 기록

### B. ArgoCD Out-Of-Sync / Degraded

1. 절대 **수동 sync 금지** (원인 파악 전에는)
2. 확인 순서:
   ~~~bash
   argocd app get <name>
   argocd app diff <name>
   oc get events -n <namespace> --sort-by=.lastTimestamp | tail -20
   ~~~
3. 원인이 매니페스트 오류 → `infra/`에서 수정 후 git push → ArgoCD가 재동기화
4. 원인이 클러스터 측 → `constraints.md`에 기록 후 사람 확인

### C. 토큰 상한 임박

1. 현재 iteration을 **안전 지점까지만** 진행
2. `claude-context/active-task.md`에 "중단 원인: 토큰 상한" 기록
3. `git commit -m "[세션 NN] WIP: <현재 상태>"` — 모든 변경을 WIP로 보존
4. 사람에게 보고 후 종료

### D. 예상치 못한 클러스터 상태 발견

예: 기존 네임스페이스가 이미 있다, 다른 팀 Operator가 설치되어 있다 등

1. **수정 금지**. 리소스에 손대지 말 것
2. `work-plans/`에 새 파일 작성: `NNN-unexpected-<kebab>.md`
3. `Open Questions`로 사람에게 판단 이관
4. 현재 태스크 중단, `active-task.md`에 블로커 기록

### E. guideline / contract 위반 유혹

예: "이번만 Layer 4 값을 추정해도 될 것 같다"

1. **중단**
2. `guidelines/01-layer-contracts.md`의 "계약 위반 시 행동" 절차 따르기
3. 사람의 3지선다 선택 대기

---

## 재시도 정책

- **같은 명령 3회 이상 재시도 금지** (지수 백오프 포함)
- Operator reconcile 대기는 **명시적 시간 상한** (`oc wait --timeout=10m`)
- 타임아웃 도달 → 재시도 금지, 원인 파악

---

## 롤백

### Layer 4 (infra) 변경 롤백
~~~bash
git revert <commit>              # 선호
# 또는
git reset --hard <commit>        # 사람 승인 필수
~~~
ArgoCD가 자동으로 이전 상태로 되돌린다.

### 클러스터 상태 롤백
- DEV: teardown runbook (`90-*.md`) 실행 가능
- PROD: **AI 단독 롤백 금지**. 반드시 사람 승인.

---

## 기록 의무

실패 후 세션 종료 시 **반드시**:
1. `constraints.md`에 원인·재발 방지 기록
2. 해당 runbook의 "실패 시" 섹션에 증상·대응 추가
3. `handoff-notes.md`에 "블로커: X" 명시

이 세 가지 없이 세션을 닫으면 실패가 반복된다.
