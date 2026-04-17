# 세션 프로토콜

모든 Claude 세션은 아래 절차를 따른다. 예외 없음.

---

## 세션 시작 (순서 고정)

### 1. 환경 확인
~~~bash
git status                          # 미커밋 변경 있으면 원인 파악
git log --oneline -5                # 최근 세션 흐름 파악
ls .claude/settings*.json           # 현재 환경 권한 확인
~~~

미커밋 변경이 있고 출처가 불명이면 **중단하고 사람에게 확인**.

### 2. 진입 문서 순서대로 읽기
1. `CLAUDE.md`
2. `guidelines/00-methodology.md` (첫 세션만 필수, 이후는 diff로 변경 여부만)
3. `guidelines/02-session-protocol.md` (이 파일)
4. `claude-context/current-state.md`
5. `claude-context/active-task.md`
6. `claude-context/handoff-notes.md` (최근 3개 엔트리만)

### 3. 태스크 확정
- `active-task.md`의 태스크가 명확 → 진행
- 블로커 있음 → 사람에게 보고, 대안 제시
- 비어 있음 → 사람에게 다음 태스크 요청

### 4. [CHECKPOINT] 사람에게 확인
"오늘 세션의 태스크는 X. 진행해도 될까요?"

사람의 명시적 승인 전에는 **어떤 쓰기 작업도 시작하지 않는다**.

---

## 세션 진행 중

- 각 iteration 끝에 `claude-context/current-state.md`의 최소 필드 갱신
- 예상치 못한 상태 발견 시 `constraints.md`에 즉시 기록
- 긴 대기는 `oc wait --timeout=...`로 블로킹
- 로그는 grep/jq로 축소 후 읽기 (원문 통째로 읽지 말 것)

---

## 세션 종료 (순서 고정, 건너뛰기 금지)

### 1. state 갱신
- `current-state.md` → 완료된 항목 체크, 최근 이벤트 최대 3건
- `active-task.md` → 다음 세션이 할 태스크 1개로 덮어쓰기

### 2. handoff-notes.md 한 문단
`guidelines/03-handoff-protocol.md` 형식 준수. 최대 10줄.

### 3. 커밋
~~~bash
git add claude-context/ work-plans/ runbooks/ infra/ guidelines/
git commit -m "[세션 NN] <한 줄 요약>"
~~~

세션 번호는 기존 커밋의 최대 NN + 1.

### 4. 최종 보고
- 오늘 완료한 것 (bullet)
- 남은 블로커 (있으면)
- 다음 세션의 첫 태스크

---

## 비상 종료 (토큰 상한, 크래시 등)

최소 2단계만 수행:
1. `active-task.md`에 "중단 원인" 기록
2. `git commit -m "[세션 NN] WIP: <상태>"` — 모든 변경을 WIP로 보존

그 외 정리는 다음 세션이 복구한다.
