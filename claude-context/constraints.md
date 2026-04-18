# 누적 제약 (append only, 삭제 금지)

이 파일은 프로젝트 진행 중 발견된 제약·교훈·재발 방지 정보를 누적한다. 기존 항목 수정·삭제 금지. 형식은 `guidelines/05-state-management.md` 참조.

---

## 2026-04-17: 기존 클러스터 재사용 전제

- 맥락: 프로젝트 초기화, Phase 0
- 내용: 신규 클러스터 설치가 아닌 **기존 OpenShift 클러스터 재사용**. 기존 네임스페이스·Operator·ArgoCD 유무는 아직 미파악.
- 영향 범위: 모든 Phase
  - Phase 1에서 사전 조사 필수
  - 기존 리소스에 대한 쓰기 작업은 사람 승인 필요 (`CLAUDE.md` 금지 사항)
  - `90-teardown.md`는 DEV 전용 + 신규 생성 리소스에만 적용

---

## 2026-04-17: AI 도구 중립성 요구

- 맥락: 사용자가 Claude 외 Gemini/Codex도 고려
- 내용: 4계층 문서 구조는 tool-agnostic으로 유지. 플랫폼 의존 설정은 `.claude/` 아래로만 격리.
- 영향 범위: `guidelines/` · `work-plans/` · `runbooks/` · `infra/`는 Claude 특화 표현 금지

---

## 2026-04-17: 듀얼 환경(Connected + Air-gap) 요구

- 맥락: Connected에서 1차 PoC 완료 후, **별도 Air-gap 환경**에서 동일 구성 재현 필요
- 내용:
  - Git 원격은 초기 GitHub, 향후 내부 **Gitea** 병행. Connected→Air-gap 이동은 **외장 SSD** 매체 **1회성** 수작업
  - 이미지·Operator 카탈로그는 **`oc-mirror`**로 미러링. 레지스트리는 **Quay + OpenShift internal registry**
  - AI 도구(Claude/Gemini/Codex)는 **연결망에서만** 사용. Air-gap 환경에서는 사람이 runbook만 따라 실행(AI 호출 없음)
- 영향 범위:
  - Layer 4 `infra/`는 환경 공통 + 환경별 overlay(잠정: Kustomize) 구조를 염두에 둘 것
  - Layer 3 `runbooks/`의 이미지·registry URL은 **하드코딩 금지**, `.env` 또는 `infra/` 값 참조
  - `guidelines/`는 "AI 필수 전제" 표현 금지 (Air-gap에서는 사람만 실행)
- 참조: `work-plans/001-dual-env-strategy.md`
