# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**RHOAI 정상 상태 기준선 확정 및 PoC 워크벤치 검증**

새 샌드박스 접근 확인 완료. GitOps 1.20.2와 RHOAI 3.4.0-ea.1은 설치되어 있고 Dashboard/GitOps Route도 존재한다. 사용자 승인 하에 JobSet Operator, LeaderWorkerSet Operator, MaaS Gateway 의존성을 보강해 `default-dsc`는 Ready 상태가 됐다. 다음 세션은 이 Ready 기준선을 GitOps 운영 경계에 맞춰 정리하고 첫 워크벤치/PoC 검증으로 넘어간다.

## 성공 기준 (Capabilities)

- [x] 이전 샌드박스 Phase 3 완료 기록 보존 — RHOAI 3.3.2 / DataScienceCluster Ready
- [x] 새 샌드박스 survey 확인 — OCP 4.21.9 / RHOAI 관측 CSV 3.4.0-ea.1 / DSC NotReady
- [x] 새 샌드박스 survey 결과 파일 확인 — `survey-output/survey-20260422-210156.txt`
- [x] 새 샌드박스 RHOAI 목표 버전 결정 — 3.4.0
- [x] 실제 클러스터 접근 확인 — API/Console URL, admin 로그인, OpenShift 4.21.9
- [x] GitOps 설치 확인 — openshift-gitops-operator v1.20.2, Route 존재
- [x] `default-dsc NotReady` 원인 확인 — ModelsAsService Gateway 없음, Trainer JobSet 없음
- [x] 프로젝트 목적 재정의 — 초기 구축/부트스트랩 권한과 운영 유지관리 권한 분리
- [x] DSC NotReady 해소 방향 결정 — 의존성 설치
- [x] JobSet Operator 설치 — `openshift-jobset-operator`, CSV `jobset-operator.v1.0.0`
- [x] LeaderWorkerSet Operator 설치 — `openshift-lws-operator`, CSV `leader-worker-set.v1.0.0`
- [x] MaaS Gateway 생성 — `openshift-ingress/maas-default-gateway`, Programmed=True
- [x] `default-dsc` Ready 확인
- [ ] `infra/rhoai/datasciencecluster.yaml`를 live v2 의도 스펙과 정합화
- [ ] ArgoCD diff/sync 절차를 runbook에 맞춰 확인
- [ ] 워크벤치 1개 생성 및 Python 셀 스모크 테스트

## 참조 (Required Inputs)

- `.env` — 클러스터 접속 정보
- `claude-context/version-matrix.md` — RHOAI 3.4.0 목표 확정
- `claude-context/current-state.md` — 2026-04-29 실제 접근 확인 결과
- `CLAUDE.md` — 운영 유지관리 모드 권한 원칙
- `infra/operators/job-set/` — Trainer 의존성 IaC
- `infra/operators/leader-worker-set/` — KServe LLMInferenceService Wide Expert Parallelism 의존성 IaC
- `infra/rhoai/gateway/` — ModelsAsService Gateway IaC

## 블로커 (Constraints)

- 운영 모드에서는 직접 클러스터 변경이 기본 경로가 아님
- 새 survey의 실제 CSV는 `3.4.0-ea.1`로, 사용자 목표 `3.4.0`과 표기 차이가 있음
- `infra/rhoai/datasciencecluster.yaml`는 live v2 DSC와 차이가 있으므로 정합화 전 직접 적용 금지
- PoC 항목은 사람이 결정 (Phase 5 계획 필요)
