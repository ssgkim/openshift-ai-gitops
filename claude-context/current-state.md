# 현재 상태 (2026-04-19 Session 06 기준)

> **현재 상태: Phase 2 진행 중 — infra/argocd/ + infra/rhoai/ YAML 작성 완료, runbooks/10 작성 완료. 채널 확정(GitOps: latest/v1.20.1, RHOAI: stable-3.3/3.3.2). 사람이 `runbooks/10-argocd-operator-install.md` 실행 후 CSV Succeeded 결과 공유 필요.** 이 파일을 읽으면 클러스터 설치 현황, 미결 사항, 최근 이벤트를 한눈에 파악할 수 있다.

## 클러스터

- OpenShift 버전: **4.20.18** (stable-4.20 채널) ✅
- API endpoint: `.env`의 `${OCP_API_URL}` 참조 ✅
- Ingress 도메인: `.env`의 `${OCP_DOMAIN}` 참조 ✅
- OS: Red Hat Enterprise Linux CoreOS 9.6.20260401-0 (Plow)
- Kubernetes: v1.33.9
- 환경: DEV / Connected (인터넷 연결 가능)
- 인증: htpasswd (`admin` / cluster-admin) ✅ — 로그인 확인
- TLS: 자가서명 인증서 ⚠️ — `--insecure-skip-tls-verify` 필요 (`constraints.md` 참조)
- 설치 완료 일시: 2026-04-18T15:44:30Z
- 접근 가능 프로젝트: 75개 (기존 활성 클러스터)

## 노드 구성

| 역할 | 수 | CPU (Allocatable) | Memory (Allocatable) | Max Pods |
|---|---|---|---|---|
| control-plane | 3 | — | — | — |
| worker | 3 | 15500m (16 core) | ~62 GB | 250 |
| infra | 0 | — | — | — |

- 워커 실사용률: CPU 0~4%, Memory 2~7% (survey 기준 — 여유 충분)

## 스토리지

| StorageClass | Provisioner | Default | VolumeBinding |
|---|---|---|---|
| gp2-csi | ebs.csi.aws.com | — | WaitForFirstConsumer |
| gp3-csi | ebs.csi.aws.com | ✅ | WaitForFirstConsumer |

## 설치 상태

- [x] cert-manager Operator — **v1.18.1** (stable-v1, redhat-operators) ✅
- [ ] OpenShift GitOps (ArgoCD) — **미설치** → Phase 2에서 설치 예정
- [ ] ServiceMesh Operator — 미설치 (RHOAI 의존성 여부 확인 필요)
- [ ] Serverless Operator — 미설치 (RHOAI 의존성 여부 확인 필요)
- [ ] Pipelines Operator — 미설치 (RHOAI 의존성 여부 확인 필요)
- [ ] NFD Operator — 미설치 (GPU 노드 없음, 현재 불필요)
- [ ] NVIDIA GPU Operator — 미설치 (GPU 노드 없음, 현재 불필요)
- [ ] OpenShift AI Operator (RHOAI) — **미설치** → Phase 3에서 설치 예정
- [ ] DataScienceCluster 적용 — (RHOAI 설치 후)
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
- [x] survey 전체 실행 완료 — 전 섹션(1-A~1-G) 정상 수집 (Session 06)
- [x] 노드·Operator·StorageClass·Proxy·GPU 현황 반영 (Session 06)
- [x] `version-matrix.md` · `constraints.md` 갱신 (Session 06)
- **Phase 1 완료 ✅**

## 최근 이벤트 (최대 3건)

- 2026-04-19 Session 07: GitOps 채널 latest(v1.20.1) + RHOAI 채널 stable-3.3(3.3.2) 확정. infra/argocd/ 2개 + infra/rhoai/ 4개 YAML 작성. runbooks/10-argocd-operator-install.md 작성. version-matrix.md 갱신.
- 2026-04-19 Session 06: survey 전체 완료 — 노드 3+3, cert-manager v1.18.1 확인, RHOAI·ArgoCD 미설치, proxy 설정 존재, GPU 없음. Phase 1 완전 종료. Phase 2 진입.
- 2026-04-19 Session 05: survey 부분 완료 — OCP **4.20.18 / stable-4.20** 확정. 스크립트 jsonpath 버그 수정.

## 미결 사항

- runbooks/10 실행 결과 공유 필요 — 사람이 로컬에서 실행 후 CSV 버전·ArgoCD Route URL을 공유하면 current-state.md 체크박스 갱신
- PoC 항목 미정 — Phase 5에서 결정
