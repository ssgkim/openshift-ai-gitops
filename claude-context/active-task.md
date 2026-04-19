# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

수정된 `cluster-survey.sh`로 survey를 재실행하여 노드·Operator·StorageClass 정보를 수집한 후, Phase 1 조사를 완료하고 Phase 2 시작 여부를 결정한다.

## 성공 기준 (Capabilities)

- [ ] `bash scripts/cluster-survey.sh --save` **재실행** → 전체 섹션(1-A ~ 1-G) 정상 완료
- [ ] `current-state.md` — Operator 설치 체크박스 실제 값으로 업데이트
- [ ] `version-matrix.md` — 설치된 Operator 버전·채널 기재 (survey 결과 기반)
- [ ] ArgoCD 설치 여부 확정 → 미설치 시 `runbooks/10-argocd-operator-install.md` 진입
- [ ] RHOAI 3.3 구독 채널 확정 → `version-matrix.md`에 기록

## 배경 (Session 05 완료 사항)

- OCP **4.20.18 / stable-4.20** 확정 ✅
- 자가서명 TLS 인증서 확인 → `constraints.md` 기록 ✅
- `scripts/cluster-survey.sh` jsonpath 버그 수정 (`history[0:3]` → `history[*]` + head -3) ✅

## 참조 (Required Inputs)

- `scripts/cluster-survey.sh` (수정 완료) — 재실행 가능
- `claude-context/version-matrix.md` (Operator 버전 기록 위치)
- `claude-context/constraints.md` (제약 기록 위치)

## 블로커 (Constraints)

- **사람이 로컬에서 `bash scripts/cluster-survey.sh --save` 재실행 필요**
  - `oc` CLI 설치 및 클러스터 네트워크 접근 가능한 환경에서 실행
  - 결과 파일(`survey-output/*.txt`)을 Claude에게 공유하면 나머지는 Claude가 처리
