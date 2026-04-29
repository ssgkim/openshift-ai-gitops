# 현재 상태 (2026-04-29 Session 15 기준)

> **현재 상태: 부트스트랩 단계 마무리. RHOAI 기준선 정상 (`default-dsc Ready=True`, drift 0), `infra/rhoai/datasciencecluster.yaml` 가 live v2 스펙과 정합화됨. ArgoCD Application IaC + sync runbook 작성으로 운영 모드 전환 준비 완료. PoC 스모크 워크벤치(`rhoai-poc-smoke/smoke-wb`) 생성 + Python 셀 스모크 통과.** 이 파일을 읽으면 클러스터 설치 현황, 미결 사항, 최근 이벤트를 한눈에 파악할 수 있다.

## 클러스터

- OpenShift 버전: **4.21.9** (stable-4.21)
- API endpoint: `https://api.ocp.9qn8g.sandbox805.opentlc.com:6443` ✅
- Console URL: `https://console-openshift-console.apps.ocp.9qn8g.sandbox805.opentlc.com` ✅
- Ingress 도메인: `.env`의 `${OCP_DOMAIN}` 참조 ✅ (`apps.ocp.9qn8g.sandbox805.opentlc.com` 새 survey 확인)
- OS: Red Hat Enterprise Linux CoreOS 9.6.20260401-0 (Plow)
- Kubernetes: v1.34.6
- 환경: OPS 유지관리 / Connected (인터넷 연결 가능)
- 인증: htpasswd (`admin` / cluster-admin) ✅ — 로그인 확인
- TLS: 자가서명 인증서 ⚠️ — `--insecure-skip-tls-verify` 필요 (`constraints.md` 참조)
- 접근 가능 프로젝트: 96개 (2026-04-29 로그인 확인)

## 노드 구성

| 역할 | 수 | CPU (Allocatable) | Memory (Allocatable) | Max Pods |
|---|---|---|---|---|
| control-plane | 3 | — | — | — |
| worker | 5 | 7500m x5 | ~30 GB x5 | 250 |
| infra | 0 | — | — | — |

- 워커 실사용률: CPU 2~20%, Memory 10~45% (새 survey 기준)

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
- [x] NFD Operator — **4.21.0-202604200440 / stable** (GPU 노드 없음)
- [x] NVIDIA GPU Operator — **v26.3.1 / v26.3** (GPU 노드 없음)
- [x] OpenShift AI Operator (RHOAI) — 목표 **3.4.0**, 관측 CSV **3.4.0-ea.1** / beta (새 survey)
- [x] JobSet Operator — **v1.0.0 / stable-v1.0** (`openshift-jobset-operator`)
- [x] LeaderWorkerSet Operator — **v1.0.0 / stable-v1.0** (`openshift-lws-operator`)
- [x] MaaS Gateway — `openshift-ingress/maas-default-gateway` Programmed=True
- [x] DataScienceCluster 적용 — **default-dsc Ready** (Session 14)
- [x] DataScienceCluster IaC 정합화 — `infra/rhoai/datasciencecluster.yaml` v2, drift 0 (Session 15)
- [x] ArgoCD Application IaC + sync runbook 작성 — `infra/argocd/applications/rhoai.yaml`, `runbooks/30-argocd-app-sync.md` (Session 15)
- [x] 워크벤치 1개 생성 — `rhoai-poc-smoke/smoke-wb` Pod Running 2/2, Python 셀 스모크 통과 (Session 15)

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

- 2026-04-29 Session 15: 부트스트랩 마무리 — DSC IaC를 v2 live 스펙과 정합화(drift 0), ArgoCD `rhoai` Application IaC + `runbooks/30-argocd-app-sync.md` 작성, PoC 스모크 워크벤치(`rhoai-poc-smoke/smoke-wb`) 생성 및 Python 셀 스모크 통과.
- 2026-04-29 Session 14: 사용자 승인 하에 RHOAI 의존성 보강 — JobSet Operator, LeaderWorkerSet Operator, `maas-default-gateway` 생성, `default-dsc` Ready 확인.
- 2026-04-29 Session 12: 실제 클러스터 접근 확인 — 로그인 성공(admin), API/Console URL 확인, OpenShift 4.21.9, GitOps 1.20.2 Route 확인, DSC NotReady 원인 확인.

## 미결 사항

- ArgoCD App-of-Apps/ApplicationSet 구조 미완성 — Session 15에서 RHOAI 단일 Application IaC만 작성, 의존성(JobSet/LWS/MaaS Gateway/PoC)은 운영 모드 트리거 시 ApplicationSet으로 흡수 필요.
- 운영 모드 전환 트리거 미실행 — `.env`의 `GITHUB_REMOTE`(현재 placeholder)를 실제 https URL로 치환하고 `infra/argocd/applications/rhoai.yaml`의 repoURL 갱신 후 `runbooks/30-argocd-app-sync.md` 절차 실행 필요.
- GPU Operator/NFD는 설치됐지만 GPU allocatable 노드는 없음.
- PoC 항목(스모크 외) 미정 — Phase 5에서 결정 (사람 판단 필요).
