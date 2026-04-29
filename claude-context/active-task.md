# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**GitOps 인계 범위 확정 후 Scope 1부터 순차 진행**

Session 17에서 CPU LLM PoC(`rhoai-poc-llm-cpu/smollm2-135m-cpu`)까지 BOOTSTRAP 직접 적용으로 완료했다. Session 18에서 `ai-accelerator` 참고 패턴을 검토하고, 한 번에 ApplicationSet으로 흡수하지 않도록 `work-plans/002-gitops-handover-scope.md`에 Scope 0~5 단계 계획을 추가했다.

다음 세션은 **Scope 1: ArgoCD 관리 뼈대 정리**만 진행한다. 클러스터 sync나 리소스 적용은 별도 CHECKPOINT 승인 전까지 하지 않는다.

## 성공 기준 (Capabilities)

- [x] `infra/argocd/applications/rhoai.yaml` 의 `spec.source.repoURL` 을 실제 URL로 치환
- [x] CPU LLM PoC IaC 작성 및 적용 — `infra/poc/llm-cpu`
- [x] CPU LLM InferenceService Ready=True
- [x] CPU LLM `/v1/models`, `/v1/completions` smoke 검증 통과
- [x] `ai-accelerator` 참고 항목 검토 — bootstrap/cluster/components 분리, AppProject/ApplicationSet, repoURL replacement 패턴
- [x] GitOps 인계 범위 계획 추가 — `work-plans/002-gitops-handover-scope.md`
- [ ] [CHECKPOINT] Scope 1 진행 승인 확인
- [ ] `.env` 의 `GITHUB_REMOTE` 가 ArgoCD repoURL과 일치하는지 확인
- [ ] (필요 시) ArgoCD에 repository secret 등록 — private repo면 SSH key 또는 token
- [ ] Scope 1: AppProject/repo config/root bootstrap 구조 설계 또는 IaC 작성
- [ ] Scope 1: `kustomize build` 또는 `oc apply --dry-run=client`로 로컬 검증
- [ ] Scope 1 종료 시 다음 Scope 2 체크리스트로 `active-task.md` 갱신

## 범위별 체크리스트

- [x] Scope 0: 계획과 체크리스트 정리. 클러스터 변경 없음.
- [ ] Scope 1: ArgoCD 관리 뼈대 정리. AppProject, repo config, root/bootstrap 구조만 준비.
- [ ] Scope 2: `infra/rhoai` 단일 Application diff/sync 검증. `prune=false`.
- [ ] Scope 3: RHOAI 의존성(JobSet/LWS/MaaS Gateway) Application 편입.
- [ ] Scope 4: PoC(`workbench-smoke`, `llm-cpu`) Application 편입.
- [ ] Scope 5: 전체 Synced/Healthy와 drift 0 확인 후 BOOTSTRAP 완료 판단.

## 후속 태스크 (운영 트리거 완료 이후)

- [ ] ApplicationSet 승격 검토 — Scope 2~4 안정화 이후
- [ ] `automated.prune/selfHeal` 활성화 검토 (drift 안정화 후)
- [ ] PoC 항목 결정 (Phase 5)

## 참조 (Required Inputs)

- `work-plans/002-gitops-handover-scope.md` — GitOps 인계 범위와 단계별 편입 계획
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
- 한 번에 ApplicationSet으로 흡수하지 않는다. Scope 단위 CHECKPOINT와 체크리스트 갱신 후 진행한다.
- sync 후 운영자 자동 주입 필드와의 drift 가능성 — 발생 시 `ignoreDifferences` 적용
- `--prune=false` 보장 필요 — Session 14에서 직접 적용된 의존성(JobSet/LWS/MaaS Gateway)이 IaC에 빠져 있을 경우 자동 삭제 방지
- CPU LLM은 vLLM CPU x86 런타임이며 GPU request 없음. 초기 OOM 방지를 위해 `VLLM_CPU_KVCACHE_SPACE=2`, `--max-model-len=1024`, `Recreate` 전략 사용.
