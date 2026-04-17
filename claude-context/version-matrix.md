# 버전 매트릭스

사람이 결정한 값만 기재. AI는 제안만 가능 (`guidelines/05-state-management.md`).

---

## 핵심 컴포넌트

| 컴포넌트 | 버전 | 채널 | 출처 |
|---|---|---|---|
| OpenShift | (미정) | — | 기존 클러스터 `oc get clusterversion` |
| OpenShift GitOps | (미정) | (미정) | OperatorHub 조회 |
| cert-manager | (미정) | (미정) | OperatorHub 조회 |
| ServiceMesh | (미정) | (미정) | OperatorHub 조회 |
| Serverless | (미정) | (미정) | OperatorHub 조회 |
| Pipelines | (미정) | (미정) | OperatorHub 조회 |
| NFD | (미정) | (미정) | OperatorHub 조회 (GPU 필요 시) |
| NVIDIA GPU Operator | (미정) | (미정) | OperatorHub 조회 (GPU 필요 시) |
| OpenShift AI (RHOAI) | (미정) | (미정) | OperatorHub 조회 |

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

- (아직 없음 — Phase 1 완료 후 채움)

---

## 호환성 참고 링크
- Red Hat OpenShift AI 호환 매트릭스: https://access.redhat.com/support/policy/updates/rhoai
- OpenShift Operator 라이프사이클: https://access.redhat.com/support/policy/updates/openshift
