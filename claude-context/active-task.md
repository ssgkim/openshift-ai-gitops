# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**Phase 2 실행 대기: runbooks/10-argocd-operator-install.md 실행 + 결과 반영**

infra/ YAML과 runbook이 준비됐다. 사람이 runbook을 로컬에서 실행하고 결과를 공유하면 state 파일을 갱신한다.

## 성공 기준 (Capabilities)

- [x] `runbooks/10-argocd-operator-install.md` 작성 완료
- [x] `openshift-gitops-operator` 채널 latest / CSV v1.20.1 확정 → `version-matrix.md` 기록 완료
- [x] `infra/argocd/namespace.yaml` + `infra/argocd/subscription.yaml` 작성 완료
- [x] `infra/rhoai/` 4개 파일 작성 완료 (namespace, operator-group, subscription, datasciencecluster)
- [ ] 사람이 `runbooks/10-argocd-operator-install.md` 실행 → CSV `Succeeded` 확인
- [ ] ArgoCD 기본 인스턴스(`openshift-gitops` 네임스페이스) 정상 동작 확인
- [ ] `current-state.md` — OpenShift GitOps 체크박스 ✅ 갱신

## 참조 (Required Inputs)

- `runbooks/10-argocd-operator-install.md` — 실행할 runbook
- `infra/argocd/namespace.yaml`, `infra/argocd/subscription.yaml` — 적용할 매니페스트
- `.env` — 클러스터 접속 정보

## 블로커 (Constraints)

- 실제 `oc apply` 실행은 사람이 로컬에서 수행 (클러스터 쓰기 권한 필요)
- 실행 결과(CSV 상태·ArgoCD Route URL)를 공유하면 Claude가 state 파일 갱신
