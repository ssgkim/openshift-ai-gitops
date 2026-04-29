# 현재 상태 (2026-04-30 Session 19 기준)

> **현재 상태: 부트스트랩 단계 마무리. RHOAI 기준선 정상 (`default-dsc Ready=True`, drift 0), PoC 스모크 워크벤치 통과, CPU LLM 모델(`smollm2-135m-cpu`) KServe 배포 및 OpenAI-compatible completion 검증 완료. ArgoCD 인계는 Scope 0~5로 분할 진행 중이며, Scope 1(AppProject/repo config/root bootstrap 구조) 로컬 검증까지 완료했다.** 이 파일을 읽으면 클러스터 설치 현황, 미결 사항, 최근 이벤트를 한눈에 파악할 수 있다.

## 클러스터

- OpenShift 버전: **4.21.9** (stable-4.21)
- API endpoint: `https://api.ocp.9qn8g.sandbox805.opentlc.com:6443` ✅
- Console URL: `https://console-openshift-console.apps.ocp.9qn8g.sandbox805.opentlc.com` ✅
- Ingress 도메인: `.env`의 `${OCP_DOMAIN}` 참조 ✅ (`apps.ocp.9qn8g.sandbox805.opentlc.com` 새 survey 확인)
- OS: Red Hat Enterprise Linux CoreOS 9.6.20260401-0 (Plow)
- Kubernetes: v1.34.6
- 환경: BOOTSTRAP 마무리 / OPS 전환 대기 / Connected (인터넷 연결 가능)
- 인증: htpasswd (`admin` / cluster-admin) ✅ — 로그인 확인
- TLS: 자가서명 인증서 ⚠️ — `--insecure-skip-tls-verify` 필요 (`constraints.md` 참조)
- 접근 가능 프로젝트: 96개 (2026-04-29 로그인 확인)

## 노드 구성

| 역할 | 수 | CPU (Allocatable) | Memory (Allocatable) | Max Pods |
|---|---|---|---|---|
| control-plane | 3 | — | — | — |
| worker | 8 | 7500m x8 | ~30 GB x5 / ~60 GB x3 | 250 |
| infra | 0 | — | — | — |

- GPU allocatable 노드: 3개 (`nvidia.com/gpu=1`, L40S 계열 기존 샘플 관측)
- 워커 실사용률: CPU/Memory는 워크로드 변동 큼. CPU LLM Pod는 `rhoai-poc-llm-cpu`에서 500m request / 2 CPU limit / 8Gi limit로 실행.

## 스토리지

| StorageClass | Provisioner | Default | VolumeBinding |
|---|---|---|---|
| gp2-csi | ebs.csi.aws.com | — | WaitForFirstConsumer |
| gp3-csi | ebs.csi.aws.com | ✅ | WaitForFirstConsumer |

## 설치 상태

- [x] cert-manager Operator — **v1.19.0** (새 survey)
- [x] OpenShift GitOps (ArgoCD) — **v1.20.2 / latest** (Route 확인)
- [x] ServiceMesh Operator — **v3.3.2** (stable)
- [ ] Serverless Operator — 미설치 (RHOAI 의존성 여부 확인 필요)
- [x] Pipelines Operator — **v1.22.0 / latest**
- [x] NFD Operator — **4.21.0-202604200440 / stable** (GPU 노드 3개 관측)
- [x] NVIDIA GPU Operator — **v26.3.1 / v26.3** (GPU 노드 3개 관측)
- [x] OpenShift AI Operator (RHOAI) — 목표 **3.4.0**, 관측 CSV **3.4.0-ea.1** / beta (새 survey)
- [x] JobSet Operator — **v1.0.0 / stable-v1.0** (`openshift-jobset-operator`)
- [x] LeaderWorkerSet Operator — **v1.0.0 / stable-v1.0** (`openshift-lws-operator`)
- [x] MaaS Gateway — `openshift-ingress/maas-default-gateway` Programmed=True
- [x] DataScienceCluster 적용 — **default-dsc Ready** (Session 14)
- [x] DataScienceCluster IaC 정합화 — `infra/rhoai/datasciencecluster.yaml` v2, drift 0 (Session 15)
- [x] ArgoCD Application IaC + sync runbook 작성 — `infra/argocd/applications/rhoai.yaml`, `runbooks/30-argocd-app-sync.md` (Session 15)
- [x] ArgoCD Scope 1 관리 뼈대 작성 — `infra/argocd/bootstrap/kustomization.yaml`, AppProject 3개, repo config replacement, dry-run 통과 (Session 19)
- [x] 워크벤치 1개 생성 — `rhoai-poc-smoke/smoke-wb` Pod Running 2/2, Python 셀 스모크 통과 (Session 15)
- [x] CPU LLM 모델 배포 — `rhoai-poc-llm-cpu/smollm2-135m-cpu` Ready=True, `/v1/completions` 응답 확인 (Session 17)

## OperatorHub 카탈로그 상태

| 카탈로그 | 상태 |
|---|---|
| redhat-operators | READY ✅ |
| certified-operators | READY ✅ |
| community-operators | READY ✅ |
| redhat-marketplace | READY ✅ |

## Phase 1 진행 현황

- [x] `.env` 작성 (Session 03)
- [x] `runbooks/01-cluster-survey.md` 작성 (Session 04)
- [x] `scripts/cluster-survey.sh` 작성 (Session 04) — 파라메터화·재사용 가능
- [x] survey 전체 실행 완료 — 전 섹션(1-A~1-G) 정상 수집 (새 샌드박스: 2026-04-22)
- [x] 노드·Operator·StorageClass·Proxy·GPU 현황 반영 (새 샌드박스: 2026-04-29)
- [x] `version-matrix.md` · `constraints.md` 갱신 (RHOAI 3.4.0 목표 확정)
- **Phase 1 완료 ✅**

## 최근 이벤트 (최대 3건)

- 2026-04-30 Session 19: Scope 1 완료 — `infra/argocd`에 AppProject 3개, applications/bootstrap kustomization, repo config replacement를 추가하고 `rhoai` Application을 `rhoai-core` 프로젝트로 편입. `kubectl kustomize`, `oc apply --dry-run=client -k infra/argocd/bootstrap`, `git ls-remote` 검증 통과.
- 2026-04-30 Session 18: `ai-accelerator` 참고 패턴을 검토하고 GitOps 인계 범위를 `work-plans/002-gitops-handover-scope.md`로 분리. Scope 0~5 체크리스트를 `active-task.md`에 반영했으며 클러스터/infra 변경은 하지 않음.
- 2026-04-29 Session 17: 초기 PoC 프로젝트 세팅 및 CPU LLM 배포 — `rhoai-poc-llm-cpu` 네임스페이스, vLLM CPU x86 ServingRuntime, `SmolLM2-135M-Instruct` InferenceService 적용. `/v1/models`, `/v1/completions` 검증 통과.

## 미결 사항

- ArgoCD App-of-Apps/ApplicationSet 구조 미완성 — Scope 1 완료. 다음은 Scope 2(`rhoai` 단일 Application 등록/diff/sync)만 진행.
- 운영 모드 전환 트리거 미실행 — `infra/argocd/bootstrap/kustomization.yaml` dry-run 통과. 다음은 CHECKPOINT 후 server dry-run → apply → diff → sync 검증 필요.
- 로컬 커밋이 GitHub `main`에 push되어야 ArgoCD가 최신 IaC를 읽을 수 있다.
- CPU LLM PoC는 직접 적용 상태다. OPS 전환 전 `infra/poc/llm-cpu`를 별도 ArgoCD Application 또는 ApplicationSet에 편입 필요.
- PoC 항목(스모크/CPU LLM 외) 미정 — Phase 5에서 결정 (사람 판단 필요).
