# 현재 상태 (2026-04-29 Session 10 복구 기준)

> **현재 상태: 새 샌드박스를 현재 타깃으로 전환하고 RHOAI 목표를 3.4.0으로 확정. survey(`survey-20260422-210156.txt`) 기준 OpenShift 4.21.9, RHOAI 관측 CSV 3.4.0-ea.1, GitOps 미설치, DataScienceCluster NotReady 상태다.** 이 파일을 읽으면 클러스터 설치 현황, 미결 사항, 최근 이벤트를 한눈에 파악할 수 있다.

## 클러스터

- OpenShift 버전: **4.21.9** (stable-4.21)
- API endpoint: `.env`의 `${OCP_API_URL}` 참조 ✅
- Ingress 도메인: `.env`의 `${OCP_DOMAIN}` 참조 ✅ (`apps.ocp.9qn8g.sandbox805.opentlc.com` 새 survey 확인)
- OS: Red Hat Enterprise Linux CoreOS 9.6.20260401-0 (Plow)
- Kubernetes: v1.34.6
- 환경: DEV / Connected (인터넷 연결 가능)
- 인증: htpasswd (`admin` / cluster-admin) ✅ — 로그인 확인
- TLS: 자가서명 인증서 ⚠️ — `--insecure-skip-tls-verify` 필요 (`constraints.md` 참조)
- 접근 가능 프로젝트: 82개 (새 샌드박스 survey)

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
- [ ] OpenShift GitOps (ArgoCD) — 미설치 (새 survey)
- [x] ServiceMesh Operator — **v3.2.0** (새 survey)
- [ ] Serverless Operator — 미설치 (RHOAI 의존성 여부 확인 필요)
- [ ] Pipelines Operator — 미설치 (RHOAI 의존성 여부 확인 필요)
- [ ] NFD Operator — 미설치 (GPU 노드 없음, 현재 불필요)
- [ ] NVIDIA GPU Operator — 미설치 (GPU 노드 없음, 현재 불필요)
- [x] OpenShift AI Operator (RHOAI) — 목표 **3.4.0**, 관측 CSV **3.4.0-ea.1** / beta (새 survey)
- [ ] DataScienceCluster 적용 — **default-dsc NotReady** (새 survey)
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

- 2026-04-29: 사용자 지시로 새 샌드박스 RHOAI 목표를 3.4.0으로 확정. 현재 관측 CSV는 3.4.0-ea.1이며 DSC는 NotReady.
- 2026-04-29 Session 10 복구: 미커밋 중단점 확인 중 새 샌드박스 survey(`survey-20260422-210156.txt`) 발견 — OCP 4.21.9, RHOAI 3.4.0-ea.1, GitOps 미설치, DSC NotReady.
- 2026-04-22 Session 10: `state.md`를 실제 Phase 0~4 진척과 동기화하고 `odh-gitops` 레퍼런스 구조를 분석.

## 미결 사항

- RHOAI 3.4.0 목표 확정. 현재 관측 CSV가 `3.4.0-ea.1`인 표기 차이는 `default-dsc NotReady` 조사 시 함께 확인 필요
- 새 샌드박스의 `default-dsc NotReady` 원인 조사 필요
- 새 샌드박스에 OpenShift GitOps 미설치 — Phase 2 재적용 필요
- PoC 항목 미정 — Phase 5에서 결정 (사람 판단 필요)
