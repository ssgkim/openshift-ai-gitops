# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**Phase 2: OpenShift GitOps (ArgoCD) Operator 설치**

`runbooks/10-argocd-operator-install.md`를 작성하고, ArgoCD Operator를 클러스터에 설치한다. 설치 완료 후 ArgoCD 채널·버전을 `version-matrix.md`에 확정 기록한다.

## 성공 기준 (Capabilities)

- [ ] `runbooks/10-argocd-operator-install.md` 작성 — `.env` 변수 참조, 재사용 가능
- [ ] OperatorHub에서 `openshift-gitops-operator` 채널 조회 → `version-matrix.md`에 채널 기록
- [ ] `oc apply` 로 Subscription + OperatorGroup 생성 → CSV `Succeeded` 확인
- [ ] ArgoCD 기본 인스턴스(`openshift-gitops` 네임스페이스) 정상 동작 확인
- [ ] `current-state.md` — OpenShift GitOps 체크박스 ✅ 갱신
- [ ] `version-matrix.md` — GitOps 채널·버전 확정 기록

## 배경 (Phase 1 완료 사항)

- OCP **4.20.18 / stable-4.20** ✅
- cert-manager **1.18.1 / stable-v1** 이미 설치 ✅
- RHOAI·ArgoCD 미설치 확인 ✅
- Proxy 오브젝트 존재 (httpProxy 미설정, trustedCA 빈 값) → runbook에서 proxy 전파 확인 절차 포함 필요
- GPU 노드 없음 → NFD/GPU Operator 설치 불필요

## 참조 (Required Inputs)

- `.env` — `${OCP_API_URL}`, `${OCP_TOKEN}`, `${OCP_INSECURE}` 등 변수
- `claude-context/constraints.md` — TLS·proxy 제약
- `claude-context/version-matrix.md` — 채널 기록 위치
- `guidelines/01-layer-contracts.md` — runbook 작성 규칙

## 블로커 (Constraints)

- `runbooks/10-argocd-operator-install.md`는 AI가 초안 작성 가능 (Layer 3)
- 실제 `oc apply` 실행은 사람이 로컬에서 수행
  - 클러스터 쓰기 권한 필요 (`admin` 계정)
  - 실행 결과(CSV 상태·ArgoCD Route URL)를 공유하면 Claude가 state 파일 갱신
