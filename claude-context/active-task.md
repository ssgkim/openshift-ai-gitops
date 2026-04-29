# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**운영 모드 전환 트리거 — ArgoCD가 RHOAI IaC를 인계받도록 sync 시작**

Session 15에서 부트스트랩 산출물이 자리잡았다(DSC v2 정합화 drift 0, ArgoCD Application IaC, sync runbook, PoC 스모크 워크벤치). 다음 세션은 사람이 명시적으로 "운영 모드 전환 트리거"를 발동하고, ArgoCD가 `infra/rhoai/`를 sync한 뒤 drift 0를 유지하는지 검증한다.

## 성공 기준 (Capabilities)

- [ ] `.env` 의 `GITHUB_REMOTE` 를 ArgoCD가 접근 가능한 실제 https URL로 교체 (현재 `git@github.com:org/...` placeholder)
- [ ] `infra/argocd/applications/rhoai.yaml` 의 `spec.source.repoURL` 을 실제 URL로 치환 (현재 `REPLACE-ORG`)
- [ ] (필요 시) ArgoCD에 repository secret 등록 — private repo면 SSH key 또는 token
- [ ] `runbooks/30-argocd-app-sync.md` 절차 단계별 실행 — dry-run → 등록 → diff → sync
- [ ] `oc -n openshift-gitops get application rhoai` → `Synced/Healthy`
- [ ] `oc diff -f infra/rhoai/datasciencecluster.yaml` → exit 0 (sync 후에도 drift 0 유지)
- [ ] `oc get datasciencecluster default-dsc` → `Ready=True` 유지
- [ ] PoC 스모크 워크벤치(`rhoai-poc-smoke/smoke-wb`)가 sync 영향 없음 — 별도 Application으로 분리될 때까지 외부 관리

## 후속 태스크 (운영 트리거 완료 이후)

- [ ] App-of-Apps 또는 ApplicationSet으로 의존성(JobSet/LWS/MaaS Gateway/PoC) 흡수
- [ ] `automated.prune/selfHeal` 활성화 검토 (drift 안정화 후)
- [ ] PoC 항목 결정 (Phase 5)

## 참조 (Required Inputs)

- `runbooks/30-argocd-app-sync.md` — ArgoCD Application 등록/diff/sync 표준 절차
- `infra/argocd/applications/rhoai.yaml` — RHOAI Application CR (repoURL placeholder)
- `infra/rhoai/datasciencecluster.yaml` — Session 15에서 v2 live 스펙과 정합화 (drift 0)
- `.env` — `GITHUB_REMOTE` placeholder 교체 대상
- `claude-context/current-state.md` — Session 15 종료 시점 클러스터 상태
- `CLAUDE.md` — 운영 모드 권한 경계

## 블로커 (Constraints)

- ArgoCD가 사용할 Git 원격 URL과 인증 수단 미확정 — 사람 결정 필요
- 운영 모드 전환은 사람만 발동 (트리거 자동화는 별도 검토)
- sync 후 운영자 자동 주입 필드와의 drift 가능성 — 발생 시 `ignoreDifferences` 적용
- `--prune=false` 보장 필요 — Session 14에서 직접 적용된 의존성(JobSet/LWS/MaaS Gateway)이 IaC에 빠져 있을 경우 자동 삭제 방지
