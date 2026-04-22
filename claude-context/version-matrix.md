# 버전 매트릭스

> **이 파일을 읽으면 프로젝트에서 사용하는 모든 컴포넌트의 확정 버전·채널·출처를 파악할 수 있다.** 사람이 결정한 값만 기재. AI는 제안만 가능 (`guidelines/05-state-management.md`).

---

## 핵심 컴포넌트

| 컴포넌트 | 버전 | 채널 | 소스 | 상태 |
|---|---|---|---|---|
| OpenShift | **4.20.18** | **stable-4.20** | — | ✅ 설치됨 |
| cert-manager | **1.18.1** | **stable-v1** | redhat-operators | ✅ 설치됨 (Succeeded) |
| OpenShift GitOps | **1.20.1** | **latest** | redhat-operators | ✅ 설치됨 (2026-04-20) |
| OpenShift AI (RHOAI) | **3.3.2** | **stable-3.3** | redhat-operators | ✅ 설치됨 (2026-04-20) |
| ServiceMesh | (미정) | (미정) | redhat-operators | ❌ 미설치 |
| Serverless | (미정) | (미정) | redhat-operators | ❌ 미설치 |
| Pipelines | (미정) | (미정) | redhat-operators | ❌ 미설치 |
| NFD | N/A | N/A | — | ⛔ 해당 없음 (GPU 노드 없음) |
| NVIDIA GPU Operator | N/A | N/A | — | ⛔ 해당 없음 (GPU 노드 없음) |

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
- 2026-04-19: cert-manager 1.18.1 / stable-v1 확정 — survey-20260419-155529.txt CSV 조회 (Session 06)
- 2026-04-19: OpenShift GitOps 미설치 확인 — survey-20260419-155529.txt GitOps CSV 없음 (Session 06)
- 2026-04-19: NFD·GPU Operator N/A 확정 — GPU 노드 없음, 현 PoC 범위 외 (Session 06)
- 2026-04-19: OpenShift GitOps 채널 latest / CSV v1.20.1 확정 — oc get packagemanifest 실행 결과 (Session 07)
- 2026-04-19: RHOAI 채널 stable-3.3 / CSV rhods-operator.3.3.2 확정 — oc get packagemanifest 실행 결과 (Session 07)

---

## 호환성 참고 링크
- Red Hat OpenShift AI 호환 매트릭스: https://access.redhat.com/support/policy/updates/rhoai
- OpenShift Operator 라이프사이클: https://access.redhat.com/support/policy/updates/openshift
