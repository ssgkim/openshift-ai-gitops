# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**Phase 3 완료 → 다음: Dashboard Route URL 확인 + PoC 항목 결정**

RHOAI 3.3.2 설치 완료. Dashboard Pod Running이나 Route URL 미확인. PoC 항목 결정 후 워크벤치 생성으로 진행.

## 성공 기준 (Capabilities)

- [x] Phase 3 완료 — RHOAI 3.3.2 CSV Succeeded, DataScienceCluster Ready ✅
- [x] `runbooks/20-rhoai-operator-install.md` 작성 완료 ✅
- [ ] RHOAI Dashboard Route URL 확인 — `oc get routes -n redhat-ods-applications`
- [ ] PoC 항목 결정 (사람 결정 필요)
- [ ] `runbooks/60-a-notebook.md` 작성 — 워크벤치 생성 절차

## 참조 (Required Inputs)

- `.env` — 클러스터 접속 정보
- `claude-context/version-matrix.md` — RHOAI 3.3.2 설치 확인

## 블로커 (Constraints)

- PoC 항목은 사람이 결정 (Phase 5 계획 필요)
