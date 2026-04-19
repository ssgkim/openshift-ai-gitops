# 현재 상태 (2026-04-19 Session 05 기준)

> **현재 상태: Phase 1 진행 중 — survey 실행 완료(부분). OCP 버전·채널 확정. 노드/Operator 조사는 survey 중단으로 미완.** 이 파일을 읽으면 클러스터 설치 현황, 미결 사항, 최근 이벤트를 한눈에 파악할 수 있다.

## 클러스터

- OpenShift 버전: **4.20.18** (stable-4.20 채널) ✅ — survey 실행으로 패치 버전 확정
- API endpoint: `https://api.cluster-95w9g.95w9g.sandbox2661.opentlc.com:6443` ✅
- 도메인: `apps.cluster-95w9g.95w9g.sandbox2661.opentlc.com` ✅
- 환경: DEV / Connected (인터넷 연결 가능)
- 인증: htpasswd (`admin` / cluster-admin) ✅ — 로그인 확인
- TLS: 자가서명 인증서 ⚠️ — `--insecure-skip-tls-verify` 필요 (`constraints.md` 참조)
- 설치 완료 일시: 2026-04-18T15:44:30Z
- 접근 가능 프로젝트: 75개 (기존 활성 클러스터)

## 설치 상태

> survey 스크립트가 ClusterVersion 섹션 이후 중단됨 (jsonpath 오류 아님, 스크립트 출력 36줄에서 종료).
> 노드·Operator 정보는 재실행 또는 수동 확인 필요.

- [ ] OpenShift GitOps (ArgoCD) — **미확인** (survey 미완)
- [ ] cert-manager Operator — **미확인** (survey 미완)
- [ ] ServiceMesh Operator — **미확인** (survey 미완)
- [ ] Serverless Operator — **미확인** (survey 미완)
- [ ] Pipelines Operator — **미확인** (survey 미완)
- [ ] NFD Operator (선택) — **미확인** (survey 미완)
- [ ] NVIDIA GPU Operator (선택) — **미확인** (survey 미완)
- [ ] OpenShift AI Operator — **미확인** (survey 미완)
- [ ] DataScienceCluster 적용 — (미확인)
- [ ] 워크벤치 1개 생성

## Phase 1 진행 현황

- [x] `.env` 작성 (Session 03)
- [x] `runbooks/01-cluster-survey.md` 작성 (Session 04)
- [x] `scripts/cluster-survey.sh` 작성 (Session 04) — 파라메터화·재사용 가능
- [x] `bash scripts/cluster-survey.sh --save` 실행 — OCP 버전 확정 (Session 05)
- [ ] **survey 재실행 필요** — 노드·Operator·StorageClass 섹션 미수집 (스크립트 중단)
- [ ] survey 완전한 결과 → `version-matrix.md` · `constraints.md` 추가 반영
- [ ] ArgoCD 채널 확정 (survey 재실행 후 결정 가능)
- [ ] RHOAI 3.3 채널 확정 (OperatorHub 조회)

## 최근 이벤트 (최대 3건)

- 2026-04-19 Session 05: survey 실행 완료 — OCP **4.20.18 / stable-4.20** 확정. 자가서명 인증서 확인. 단, 스크립트가 36줄에서 중단되어 노드·Operator·StorageClass 미수집. 재실행 필요.
- 2026-04-19 Session 04: Phase 1 survey 인프라 구축 — `scripts/cluster-survey.sh` + `runbooks/01-cluster-survey.md` 완성. 재사용성 원칙 적용 (`.env` 변수 참조, 파라메터화)
- 2026-04-19 Session 03: 클러스터 정보 확정 + AEO 원칙 적용 + `.env` 작성

## 미결 사항

- **survey 재실행** — 노드 구성·Operator 목록·StorageClass 미수집 (우선순위 높음)
  - 중단 원인 파악 후 `scripts/cluster-survey.sh --save` 재실행
- ArgoCD · RHOAI 채널 확정 (survey 완료 후 결정 가능)
- PoC 항목 미정 — Phase 5에서 결정
