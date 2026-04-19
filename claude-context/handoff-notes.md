# 인수인계 노트

> **이 파일을 읽으면 세션별 완료·진행중·블로커·다음 할 일을 파악할 수 있다.** 형식 및 규칙: `guidelines/03-handoff-protocol.md`. 신규 엔트리는 **파일 하단에 추가**, 기존 엔트리 수정 금지.

---

## 2026-04-17 Session 01 — 프로젝트 초기화 + 방법론 체계 구축

- 완료: git 리포 초기화, 4계층 디렉토리 뼈대, `CLAUDE.md` + `guidelines/` 6종, `README.md`, `state.md`, `.claude/settings.{local,prod}.json`, `claude-context/` 초기 5종, `.env.example`
- 진행중: 없음 (초기화 세션 완료)
- 블로커: Phase 1 착수 전 사람이 `.env` 작성 + RHOAI 목표 버전 결정 필요
- 다음 세션이 할 일:
  1. `active-task.md` 따라 기존 클러스터 조사 (`oc version`, `oc get csv -A`)
  2. `version-matrix.md` · `constraints.md` · `current-state.md` placeholder 채움
  3. `runbooks/00-preflight.md` 초안 작성
- 발견된 제약: 기존 클러스터 재사용 전제 + AI 도구 중립성 요구 (`constraints.md` 반영됨)

---

## 2026-04-19 Session 03 — AEO 적용 + 클러스터 정보 확정 + .env 작성

- 완료:
  - `claude-context/` 5종 파일에 AEO outcome 앞머리 추가 (current-state, active-task, constraints, handoff-notes, version-matrix)
  - `claude-context/active-task.md` capabilities → required inputs → constraints 순서로 재구조화
  - 토큰 수 측정 — CLAUDE.md + guidelines/ + claude-context/ 합계 ~8,456 토큰 (30,000 미초과)
  - `.env` 작성 — 클러스터 API/도메인/OCP 4.20/admin 인증 정보 반영 (gitignored)
  - `current-state.md` 클러스터 placeholder 3개 해소 (버전·API·도메인)
  - `version-matrix.md` OpenShift 4.20 확정 기록
- 진행중: 없음
- 블로커: `00-preflight.md` 실행은 사람이 직접 (KUBECONFIG 경로 확정 필요) / RHOAI 버전 미정
- 다음 세션이 할 일:
  1. 사람이 `oc login` 후 KUBECONFIG 경로를 `.env`에 반영
  2. `runbooks/00-preflight.md` 실행 → `version-matrix.md`·`constraints.md` 실제 Operator 목록 채움
  3. `work-plans/002-gitops-boundary.md` 초안 작성

---

## 2026-04-18 Session 02 — 듀얼 환경 전략 + Preflight 초안

- 완료:
  - `work-plans/001-dual-env-strategy.md` (Layer 1) — 구조 옵션 4안 비교(보류), 싱크 방식 확정(`oc-mirror` / GitHub 경유 외장 SSD / 1회성)
  - `claude-context/constraints.md` append — 듀얼 환경 요구사항
  - `.env.example` 확장 — `OCP_AI_ENV_MODE`, `GITHUB_REMOTE`/`GITEA_REMOTE`, `QUAY_REGISTRY`, `OPENSHIFT_INTERNAL_REGISTRY`, `AIRGAP_MIRROR_REGISTRY`, `OC_MIRROR_WORKSPACE`
  - `state.md` Phase 1 갱신 (001 Open Questions 해소 태스크 추가)
  - `runbooks/00-preflight.md` (Layer 3) — 읽기 전용 8개 블록
- 진행중: 없음
- 블로커: 여전히 사람이 `.env` 작성 + 클러스터에 `00-preflight.md` 실행 필요
- 다음 세션이 할 일:
  1. 사람이 `.env` 채우고 `runbooks/00-preflight.md` 실행
  2. 결과를 `version-matrix.md`·`constraints.md`·`current-state.md`에 수기 반영
  3. `work-plans/001-dual-env-strategy.md` Open Questions 중 클러스터 확인으로 결정되는 항목 결론 기록
  4. 이후 `work-plans/002-gitops-boundary.md` 초안
- 발견된 제약: 싱크 방식 확정(oc-mirror/GitHub/SSD/1회성)으로 air-gap runbook이 Phase 2 이후 구체화 가능해짐
