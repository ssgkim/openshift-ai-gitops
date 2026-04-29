# 현재 상태 (2026-04-29 Session 14 기준)

> **현재 상태: 새 샌드박스 접근 확인 완료. OpenShift 4.21.9, Console/API URL 확인, GitOps 1.20.2 설치됨, RHOAI 3.4.0-ea.1 설치됨. JobSet Operator, LeaderWorkerSet Operator, MaaS Gateway 의존성을 보강해 `default-dsc`가 Ready 상태로 수렴했다.** 이 파일을 읽으면 클러스터 설치 현황, 미결 사항, 최근 이벤트를 한눈에 파악할 수 있다.

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
- [x] DataScienceCluster 적용 — **default-dsc Ready**
- [ ] 워크벤치 1개 생성

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

- 2026-04-29 Session 14: 사용자 승인 하에 RHOAI 의존성 보강 — JobSet Operator, LeaderWorkerSet Operator, `maas-default-gateway` 생성, `default-dsc` Ready 확인.
- 2026-04-29 Session 12: 실제 클러스터 접근 확인 — 로그인 성공(admin), API/Console URL 확인, OpenShift 4.21.9, GitOps 1.20.2 Route 확인, DSC NotReady 원인 확인.
- 2026-04-29: 사용자 지시로 새 샌드박스 RHOAI 목표를 3.4.0으로 확정. 관측 CSV는 3.4.0-ea.1이며 Session 14에서 DSC Ready로 수렴.

## 미결 사항

- `infra/rhoai/datasciencecluster.yaml`는 live `default-dsc` v2 스펙과 차이가 있어 바로 적용하면 운영 drift/축소 위험이 있다. 별도 정합화 필요.
- App-of-Apps/ArgoCD 소유권 구조는 아직 미완성이다. 이번 변경은 의존성 IaC를 추가하고 승인된 직접 적용으로 클러스터 정상화를 먼저 완료했다.
- GPU Operator/NFD는 설치됐지만 GPU allocatable 노드는 없음
- 프로젝트 운영 모드 전환 반영: 부트스트랩 권한은 예외, 기본은 읽기 진단 + Git/IaC 변경안 + ArgoCD 기반 반영
- PoC 항목 미정 — Phase 5에서 결정 (사람 판단 필요)
