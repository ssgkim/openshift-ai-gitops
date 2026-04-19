# 버전 매트릭스

> **이 파일을 읽으면 프로젝트에서 사용하는 모든 컴포넌트의 확정 버전·채널·출처를 파악할 수 있다.** 사람이 결정한 값만 기재. AI는 제안만 가능 (`guidelines/05-state-management.md`).

---

## 핵심 컴포넌트

| 컴포넌트 | 버전 | 채널 | 출처 |
|---|---|---|---|
| OpenShift | **4.20.18** | **stable-4.20** | survey 실행 확인 (2026-04-19) |
| OpenShift GitOps | (미정) | (미정) | OperatorHub 조회 |
| cert-manager | (미정) | (미정) | OperatorHub 조회 |
| ServiceMesh | (미정) | (미정) | OperatorHub 조회 |
| Serverless | (미정) | (미정) | OperatorHub 조회 |
| Pipelines | (미정) | (미정) | OperatorHub 조회 |
| NFD | (미정) | (미정) | OperatorHub 조회 (GPU 필요 시) |
| NVIDIA GPU Operator | (미정) | (미정) | OperatorHub 조회 (GPU 필요 시) |
| OpenShift AI (RHOAI) | **3.3** | (미정 — OperatorHub 확인 필요) | 사용자 확인 (2026-04-19) |

---

## RHOAI 컴포넌트 활성화 계획

| 컴포넌트 | 상태 | 비고 |
|---|---|---|
| dashboard | Managed | 기본 활성 |
| workbenches | Managed | 기본 활성 |
| kserve | (미정) | PoC에 따라 |
| datasciencepipelines | (미정) | PoC에 따라 |
| ray | (미정) | 분산 훈련 PoC 시 |
| kueue | (미정) | Ray와 함께 |
| modelregistry | (미정) | PoC에 따라 |

---

## 결정 기록

- 2026-04-19: OpenShift 4.20 (stable) 확정 — 사용자 제공 정보
- 2026-04-19: RHOAI 3.3 확정 — 사용자 제공 정보

---

## 호환성 참고 링크
- Red Hat OpenShift AI 호환 매트릭스: https://access.redhat.com/support/policy/updates/rhoai
- OpenShift Operator 라이프사이클: https://access.redhat.com/support/policy/updates/openshift
