# 현재 상태 (2026-04-17 기준)

> **현재 상태: Phase 0 완료 / Phase 1 미착수.** 이 파일을 읽으면 클러스터 설치 현황, 미결 사항, 최근 이벤트를 한눈에 파악할 수 있다.

## 클러스터
- OpenShift 버전: 4.20 (stable) ✅
- API endpoint: `https://api.cluster-95w9g.95w9g.sandbox2661.opentlc.com:6443` ✅
- 도메인: `apps.cluster-95w9g.95w9g.sandbox2661.opentlc.com` ✅
- 환경: DEV / Connected (인터넷 연결 가능)
- 인증: htpasswd (`admin` / cluster-admin)

## 설치 상태
- [ ] OpenShift GitOps (ArgoCD)
- [ ] cert-manager Operator
- [ ] ServiceMesh Operator
- [ ] Serverless Operator
- [ ] Pipelines Operator
- [ ] NFD Operator (선택)
- [ ] NVIDIA GPU Operator (선택)
- [ ] OpenShift AI Operator
- [ ] DataScienceCluster 적용
- [ ] 워크벤치 1개 생성

## 최근 이벤트 (최대 3건)
- 2026-04-19: Session 03 — 클러스터 정보 확정 + AEO 원칙 적용 + .env 작성
- 2026-04-18: Session 02 — 듀얼 환경 전략 + Preflight 초안
- 2026-04-17: Session 01 — 방법론 체계(guidelines + README + state.md) 구축

## 미결 사항
- `00-preflight.md` 실행 및 결과 반영 (사람이 실행 필요)
- RHOAI 목표 버전 결정 필요 (호환 매트릭스 참조 후 사람 판단)
- PoC 항목 미정 — Phase 5에서 결정
