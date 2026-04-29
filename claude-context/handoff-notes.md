# 인수인계 노트

> **이 파일을 읽으면 세션별 완료·진행중·블로커·다음 할 일을 파악할 수 있다.** 형식 및 규칙: `guidelines/03-handoff-protocol.md`. 신규 엔트리는 **파일 하단에 추가**, 기존 엔트리 수정 금지.
> 2026-04-29: 오래된 엔트리는 `claude-context/archive/handoff-2026-Q2.md`로 이관함.

---

## 2026-04-29 Session 10 복구 — 새 샌드박스 survey 발견

- 완료: 중단점 복구 중 `survey-output/survey-20260422-210156.txt` 확인, `current-state.md`/`active-task.md`/`state.md`를 환경 재정렬 대기 상태로 보정
- 진행중: 새 샌드박스를 현재 타깃으로 전환할지 결정 필요
- 블로커: 새 survey는 OCP 4.21.9 / RHOAI 3.4.0-ea.1 / GitOps 미설치 / DSC NotReady이며 기존 version-matrix와 불일치
- 다음 세션이 할 일: 사람이 새 샌드박스 전환 여부와 RHOAI 3.4.0-ea.1 수용 여부 결정
- 발견된 제약: 샌드박스 교체 시 상태 재확정 필요 (`constraints.md` 반영)

---

## 2026-04-29 Session 11 — RHOAI 3.4.0 목표 확정

- 완료: 사용자 결정에 따라 새 샌드박스 RHOAI 목표를 3.4.0으로 확정하고 `version-matrix.md`, `current-state.md`, `active-task.md`, `infra/rhoai/`, `runbooks/20-rhoai-operator-install.md` 반영
- 진행중: 새 샌드박스 Phase 2~4 재검증
- 블로커: survey 기준 GitOps 미설치, `default-dsc NotReady`, 관측 CSV가 `3.4.0-ea.1`
- 다음 세션이 할 일: GitOps 설치 여부 확정 후 `default-dsc NotReady` 원인 조사
- 발견된 제약: RHOAI 3.4.0 목표와 관측 CSV 표기 차이 기록 (`constraints.md` 반영)

---

## 2026-04-29 Session 12 — 클러스터 접근 확인 + DSC 원인 확인

- 완료: 실제 클러스터 로그인, Console/API URL 확인, OpenShift 4.21.9, GitOps 1.20.2, RHOAI 3.4.0-ea.1, Dashboard Route 확인
- 진행중: `default-dsc NotReady` 해소 방향 결정
- 블로커: ModelsAsService는 `maas-default-gateway` 없음, Trainer는 JobSet Operator 없음
- 다음 세션이 할 일: PoC 범위 기준으로 ModelsAsService/Trainer를 Removed 처리할지 의존성 설치할지 결정
- 발견된 제약: DSC NotReady 원인 기록 (`constraints.md` 반영)

---

## 2026-04-29 Session 13 — 운영 유지관리 모드 전환

- 완료: 프로젝트 목적을 부트스트랩 실행에서 운영 유지관리로 재정의하고 `CLAUDE.md`, `README.md`, state/context에 권한 경계 반영
- 진행중: DSC NotReady 해소 방향 결정
- 블로커: 운영 모드에서는 직접 클러스터 변경이 기본 경로가 아니며 Git/IaC + ArgoCD 반영 절차 필요
- 다음 세션이 할 일: ModelsAsService/Trainer 처리 방향을 IaC 변경안으로 정리
- 발견된 제약: 부트스트랩 권한은 예외, 운영 기본 권한은 읽기 진단 중심 (`constraints.md` 반영)
