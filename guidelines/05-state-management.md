# 상태 관리 규칙

`claude-context/`의 파일들은 프로젝트의 "유일한 사실"이다. 누가·언제·어떻게 바꾸는지 엄격히 관리.

---

## 파일별 책임

| 파일 | 주 갱신자 | 갱신 시점 | 최대 크기 |
|---|---|---|---|
| `current-state.md` | AI | 매 iteration 끝 | 500줄 |
| `active-task.md` | AI | 태스크 전환 시 | 100줄 |
| `constraints.md` | AI | 새 제약 발견 시에만 | 500줄 |
| `version-matrix.md` | **사람** | 버전 결정 시 | 200줄 |
| `handoff-notes.md` | AI | 세션 종료 시 | 200줄 (이관 후 재설정) |

---

## 갱신 규칙

### `current-state.md`
- 체크박스 전환은 **검증 성공 후에만** (`[ ]` → `[x]`)
- "최근 이벤트"는 **최대 3건** 유지, 초과분은 handoff-notes로 이동
- 실패 상태도 정직하게 기록 (예: `[x] 설치 실패 — 원인 X, runbooks/40 참조`)

### `active-task.md`
- **언제나 단 1개 태스크**
- 태스크 완료 → 다음 태스크로 **덮어쓰기** (append 금지)
- 블로커 발생 → 같은 파일 내 "블로커" 섹션 갱신, 태스크는 유지

### `constraints.md`
- **append only**. 삭제·수정 금지.
- 형식:
  ~~~markdown
  ## YYYY-MM-DD: <제약 요약>
  - 맥락: <언제 발견했나>
  - 내용: <구체적 제약>
  - 영향 범위: <어떤 단계·파일에 영향>
  ~~~
- 중복 의심 시 기존 항목 참조 주석만 추가

### `version-matrix.md`
- **사람이 결정한 값만** 기재 (AI는 제안만)
- 형식:
  ~~~markdown
  | 컴포넌트 | 버전 | 채널 | 출처 |
  |---|---|---|---|
  | OpenShift | 4.16.15 | — | 기존 클러스터 |
  | OpenShift GitOps | 1.13 | gitops-1.13 | RH docs 2026-01 |
  ~~~

### `handoff-notes.md`
- 형식·규칙은 `guidelines/03-handoff-protocol.md`

---

## 충돌 해결

AI 편집과 사람 편집이 같은 파일에 생기면:
1. **사람 편집 우선** (무조건)
2. AI는 사람 편집 이후의 diff만 고려해서 재작성
3. git에 커밋 단위로 흔적을 남긴다 (AI/사람 별도 커밋 권장)

---

## 상태 무결성 검증 (권장)

세션 시작 시 10초 체크:

~~~bash
# 태스크가 정확히 1개인지
grep -c "^## 태스크" claude-context/active-task.md  # 1이어야 함

# constraints 최신 항목 확인
tail -20 claude-context/constraints.md
~~~

불일치 발견 → 수정 전에 handoff-notes에 기록.

---

## 금지

- ❌ AI가 `version-matrix.md`를 임의 수정 (제안만 가능)
- ❌ `constraints.md`의 기존 항목 삭제·수정
- ❌ `active-task.md`에 2개 이상 태스크 나열
- ❌ state 파일을 읽지 않고 다음 작업 결정
