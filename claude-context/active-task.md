# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**새 샌드박스 survey 반영 여부 결정 → 현재 상태 재정렬**

이전 샌드박스는 RHOAI 3.3.2 + DSC Ready까지 완료됐으나, 중단점 복구 중 새 샌드박스 survey(`survey-output/survey-20260422-210156.txt`)가 발견됨. 새 survey는 OCP 4.21.9, RHOAI 3.4.0-ea.1, GitOps 미설치, DSC NotReady 상태이므로 현재 타깃을 새 샌드박스로 전환할지 먼저 확정해야 한다.

## 성공 기준 (Capabilities)

- [x] Phase 3 완료 — RHOAI 3.3.2 CSV Succeeded, DataScienceCluster Ready ✅
- [x] `runbooks/20-rhoai-operator-install.md` 작성 완료 ✅
- [x] RHOAI Dashboard Gateway URL 확인 — `data-science-gateway.apps.cluster-95w9g.95w9g.sandbox2661.opentlc.com` ✅
- [x] 새 샌드박스 survey 결과 파일 확인 — `survey-output/survey-20260422-210156.txt`
- [ ] 새 샌드박스를 현재 타깃으로 전환할지 사람 결정
- [ ] 전환 시 `current-state.md` / `constraints.md` / `version-matrix.md` 재정렬
- [ ] RHOAI 목표 버전 결정 — 기존 3.3.x 유지 vs 새 survey의 3.4.0-ea.1 수용

## 참조 (Required Inputs)

- `.env` — 클러스터 접속 정보
- `claude-context/version-matrix.md` — RHOAI 3.3.2 설치 확인
- `claude-context/handoff-notes.md` — Session 10 중단 지점
- `survey-output/survey-20260422-210156.txt` — 새 샌드박스 survey 결과

## 블로커 (Constraints)

- 현재 프로젝트 상태가 이전 샌드박스 완료 기록과 새 샌드박스 survey 결과를 동시에 포함
- `version-matrix.md`는 사람 결정 파일이므로 RHOAI 3.4.0-ea.1 반영 전 사람 확인 필요
- PoC 항목은 사람이 결정 (Phase 5 계획 필요)
