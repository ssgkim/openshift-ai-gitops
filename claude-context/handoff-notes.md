# 인수인계 노트

형식 및 규칙: `guidelines/03-handoff-protocol.md`. 신규 엔트리는 **파일 하단에 추가**, 기존 엔트리 수정 금지.

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
