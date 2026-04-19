# 현재 상태 (2026-04-19 Session 04 기준)

> **현재 상태: Phase 1 진행 중 — survey 스크립트 작성 완료, 실제 클러스터 조사 결과 반영 대기.** 이 파일을 읽으면 클러스터 설치 현황, 미결 사항, 최근 이벤트를 한눈에 파악할 수 있다.

## 클러스터

- OpenShift 버전: 4.20 (stable) ✅
- API endpoint: `https://api.cluster-95w9g.95w9g.sandbox2661.opentlc.com:6443` ✅
- 도메인: `apps.cluster-95w9g.95w9g.sandbox2661.opentlc.com` ✅
- 환경: DEV / Connected (인터넷 연결 가능)
- 인증: htpasswd (`admin` / cluster-admin)

## 설치 상태

> 아래 항목은 `bash scripts/cluster-survey.sh` 실행 결과로 채워질 예정.
> 실행 전: `(미확인)`, 실행 후 체크 또는 버전 기재.

- [ ] OpenShift GitOps (ArgoCD) — (미확인)
- [ ] cert-manager Operator — (미확인)
- [ ] ServiceMesh Operator — (미확인)
- [ ] Serverless Operator — (미확인)
- [ ] Pipelines Operator — (미확인)
- [ ] NFD Operator (선택) — (미확인)
- [ ] NVIDIA GPU Operator (선택) — (미확인)
- [ ] OpenShift AI Operator — (미확인)
- [ ] DataScienceCluster 적용 — (미확인)
- [ ] 워크벤치 1개 생성

## Phase 1 진행 현황

- [x] `.env` 작성 (Session 03)
- [x] `runbooks/01-cluster-survey.md` 작성 (Session 04)
- [x] `scripts/cluster-survey.sh` 작성 (Session 04) — 파라메터화·재사용 가능
- [ ] 실제 클러스터 접속 후 survey 실행 (`bash scripts/cluster-survey.sh --save`)
- [ ] survey 결과를 `version-matrix.md` · `constraints.md`에 반영 (사람)
- [ ] ArgoCD 채널 확정 (survey 결과 기반)
- [ ] RHOAI 3.3 채널 확정 (OperatorHub 조회)

## 최근 이벤트 (최대 3건)

- 2026-04-19 Session 04: Phase 1 survey 인프라 구축 — `scripts/cluster-survey.sh` + `runbooks/01-cluster-survey.md` 완성. 재사용성 원칙 적용 (`.env` 변수 참조, 파라메터화)
- 2026-04-19 Session 03: 클러스터 정보 확정 + AEO 원칙 적용 + `.env` 작성
- 2026-04-18 Session 02: 듀얼 환경 전략 + Preflight 초안

## 미결 사항

- `bash scripts/cluster-survey.sh --save` 실행 필요 (사람이 로컬에서 직접)
- survey 결과 → `version-matrix.md` 갱신 (사람만 가능)
- ArgoCD · RHOAI 채널 확정 (survey 후 결정 가능)
- PoC 항목 미정 — Phase 5에서 결정
