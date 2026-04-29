# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**RHOAI 3.4.0 타깃 확정 → 새 샌드박스 상태 재정렬**

사용자가 새 샌드박스의 RHOAI 목표를 3.4.0으로 확정함. survey(`survey-output/survey-20260422-210156.txt`) 기준 관측 CSV는 `rhods-operator.3.4.0-ea.1`, Subscription 채널은 `beta`, GitOps는 미설치, `default-dsc`는 NotReady 상태다.

## 성공 기준 (Capabilities)

- [x] 이전 샌드박스 Phase 3 완료 기록 보존 — RHOAI 3.3.2 / DataScienceCluster Ready
- [x] 새 샌드박스 survey 확인 — OCP 4.21.9 / RHOAI 관측 CSV 3.4.0-ea.1 / DSC NotReady
- [x] 새 샌드박스 survey 결과 파일 확인 — `survey-output/survey-20260422-210156.txt`
- [x] 새 샌드박스 RHOAI 목표 버전 결정 — 3.4.0
- [ ] 새 샌드박스에 OpenShift GitOps 설치 여부 결정 및 Phase 2 재적용
- [ ] `default-dsc NotReady` 원인 조사
- [ ] `runbooks/20-rhoai-operator-install.md`를 3.4.0 계열 검증에 맞게 실행/보정

## 참조 (Required Inputs)

- `.env` — 클러스터 접속 정보
- `claude-context/version-matrix.md` — RHOAI 3.4.0 목표 확정
- `claude-context/handoff-notes.md` — Session 10 중단 지점
- `survey-output/survey-20260422-210156.txt` — 새 샌드박스 survey 결과

## 블로커 (Constraints)

- 새 survey의 실제 CSV는 `3.4.0-ea.1`로, 사용자 목표 `3.4.0`과 표기 차이가 있음
- 새 샌드박스에는 OpenShift GitOps가 미설치
- `default-dsc`가 NotReady
- PoC 항목은 사람이 결정 (Phase 5 계획 필요)
