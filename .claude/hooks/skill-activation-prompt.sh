#!/bin/bash
# UserPromptSubmit 훅: 프롬프트 내용과 guideline-rules.json의 키워드를 매칭해
# 관련 guidelines/work-plans/runbooks 파일을 자동으로 제안한다.
#
# diet103/claude-code-infrastructure-showcase의 TypeScript 버전을 순수 bash로 포팅.
# 의존성: jq 만 필요 (Node.js 불필요).

set -e

RULES_FILE="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/hooks/guideline-rules.json"

# stdin으로 들어온 훅 페이로드(JSON) 읽기
input=$(cat)

# 규칙 파일 또는 프롬프트 없으면 조용히 종료
if [[ ! -f "$RULES_FILE" ]]; then
    exit 0
fi

prompt=$(echo "$input" | jq -r '.prompt // empty' 2>/dev/null || echo "")
if [[ -z "$prompt" ]]; then
    exit 0
fi

# 대소문자 무관 매칭을 위해 소문자화
prompt_lower=$(echo "$prompt" | tr '[:upper:]' '[:lower:]')

# 우선순위별 매칭 결과 수집
critical=()
high=()
medium=()
low=()

# 규칙 이름 목록 순회
while IFS= read -r rule_name; do
    [[ -z "$rule_name" ]] && continue

    priority=$(jq -r --arg n "$rule_name" '.rules[$n].priority // "medium"' "$RULES_FILE")
    suggest=$(jq -r --arg n "$rule_name" '.rules[$n].suggest // ""' "$RULES_FILE")

    # 키워드 중 하나라도 프롬프트에 포함되면 매칭
    matched=0
    while IFS= read -r kw; do
        [[ -z "$kw" ]] && continue
        kw_lower=$(echo "$kw" | tr '[:upper:]' '[:lower:]')
        if [[ "$prompt_lower" == *"$kw_lower"* ]]; then
            matched=1
            break
        fi
    done < <(jq -r --arg n "$rule_name" '.rules[$n].keywords[]? // empty' "$RULES_FILE")

    if [[ $matched -eq 1 ]]; then
        entry="$rule_name → $suggest"
        case "$priority" in
            critical) critical+=("$entry") ;;
            high) high+=("$entry") ;;
            medium) medium+=("$entry") ;;
            low) low+=("$entry") ;;
        esac
    fi
done < <(jq -r '.rules | keys[]' "$RULES_FILE")

total=$((${#critical[@]} + ${#high[@]} + ${#medium[@]} + ${#low[@]}))
if [[ $total -eq 0 ]]; then
    exit 0
fi

# 배너 출력 (stdout → UserPromptSubmit 훅의 경우 모델 컨텍스트로 주입됨)
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "GUIDELINE ACTIVATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [[ ${#critical[@]} -gt 0 ]]; then
    echo "[CRITICAL — 반드시 참조]"
    for s in "${critical[@]}"; do echo "  - $s"; done
    echo ""
fi

if [[ ${#high[@]} -gt 0 ]]; then
    echo "[RECOMMENDED]"
    for s in "${high[@]}"; do echo "  - $s"; done
    echo ""
fi

if [[ ${#medium[@]} -gt 0 ]]; then
    echo "[SUGGESTED]"
    for s in "${medium[@]}"; do echo "  - $s"; done
    echo ""
fi

if [[ ${#low[@]} -gt 0 ]]; then
    echo "[OPTIONAL]"
    for s in "${low[@]}"; do echo "  - $s"; done
    echo ""
fi

echo "ACTION: 응답 전에 위 파일을 Read로 로드하세요."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

exit 0
