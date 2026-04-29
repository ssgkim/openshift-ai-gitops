# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**PoC/의존성 ApplicationSet 편입 후 OPS 전환 트리거**

Session 17에서 CPU LLM PoC(`rhoai-poc-llm-cpu/smollm2-135m-cpu`)까지 BOOTSTRAP 직접 적용으로 완료했다. 다음 세션은 `infra/rhoai/`, RHOAI 의존성(JobSet/LWS/MaaS Gateway), PoC(`workbench-smoke`, `llm-cpu`)를 ArgoCD Application/ApplicationSet에 편입할 범위를 결정한 뒤, OPS 전환 트리거를 실행한다.

## 성공 기준 (Capabilities)

- [x] `infra/argocd/applications/rhoai.yaml` 의 `spec.source.repoURL` 을 실제 URL로 치환
- [x] CPU LLM PoC IaC 작성 및 적용 — `infra/poc/llm-cpu`
- [x] CPU LLM InferenceService Ready=True
- [x] CPU LLM `/v1/models`, `/v1/completions` smoke 검증 통과
- [ ] `.env` 의 `GITHUB_REMOTE` 가 ArgoCD repoURL과 일치하는지 확인
- [ ] (필요 시) ArgoCD에 repository secret 등록 — private repo면 SSH key 또는 token
- [ ] PoC/의존성 리소스의 ArgoCD 편입 방식 결정 — 개별 Application vs ApplicationSet
- [ ] `runbooks/30-argocd-app-sync.md` 절차 단계별 실행 — dry-run → 등록 → diff → sync
- [ ] `oc -n openshift-gitops get application rhoai` → `Synced/Healthy`
- [ ] `oc diff -f infra/rhoai/datasciencecluster.yaml` → exit 0 (sync 후에도 drift 0 유지)
- [ ] `oc get datasciencecluster default-dsc` → `Ready=True` 유지
- [ ] PoC 스모크 워크벤치(`rhoai-poc-smoke/smoke-wb`)가 sync 영향 없음 — 별도 Application으로 분리될 때까지 외부 관리
- [ ] CPU LLM(`rhoai-poc-llm-cpu/smollm2-135m-cpu`)가 sync 영향 없음 — 별도 Application으로 분리될 때까지 외부 관리

## 후속 태스크 (운영 트리거 완료 이후)

- [ ] App-of-Apps 또는 ApplicationSet으로 의존성(JobSet/LWS/MaaS Gateway/PoC) 흡수
- [ ] `automated.prune/selfHeal` 활성화 검토 (drift 안정화 후)
- [ ] PoC 항목 결정 (Phase 5)

## 참조 (Required Inputs)

- `runbooks/30-argocd-app-sync.md` — ArgoCD Application 등록/diff/sync 표준 절차
- `infra/argocd/applications/rhoai.yaml` — RHOAI Application CR (repoURL 치환 완료)
- `infra/rhoai/datasciencecluster.yaml` — Session 15에서 v2 live 스펙과 정합화 (drift 0)
- `infra/poc/llm-cpu/` — CPU LLM PoC IaC
- `runbooks/60-a-llm-cpu.md` — CPU LLM 검증 절차
- `.env` — `GITHUB_REMOTE` 확인 대상
- `claude-context/current-state.md` — Session 15 종료 시점 클러스터 상태
- `CLAUDE.md` — BOOTSTRAP/OPS 단계별 권한 경계

## 블로커 (Constraints)

- ArgoCD가 사용할 Git 원격 인증 수단 확인 필요 — public repo면 별도 secret 불필요
- OPS 전환은 사람만 발동하며, 초기 구축 완료 선언도 사람 판단
- sync 후 운영자 자동 주입 필드와의 drift 가능성 — 발생 시 `ignoreDifferences` 적용
- `--prune=false` 보장 필요 — Session 14에서 직접 적용된 의존성(JobSet/LWS/MaaS Gateway)이 IaC에 빠져 있을 경우 자동 삭제 방지
- CPU LLM은 vLLM CPU x86 런타임이며 GPU request 없음. 초기 OOM 방지를 위해 `VLLM_CPU_KVCACHE_SPACE=2`, `--max-model-len=1024`, `Recreate` 전략 사용.
