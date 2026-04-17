# OpenShift AI GitOps

기존 OpenShift 클러스터에 GitOps(ArgoCD) 기반으로 **OpenShift AI 스택**과 **PoC 검증**을 구축하는 프로젝트.

---

## 🎯 목표

- OpenShift AI Operator + DataScienceCluster를 GitOps로 배포
- 주요 PoC 항목 검증 (노트북 / KServe 서빙 / Pipelines / 분산 훈련)
- AI(Claude / Gemini / Codex)를 동료로 활용하되 **안전한 구조** 유지
- 세션이 단절돼도 누구든 이어받을 수 있는 **재현 가능성** 보장

---

## 📐 설계 원칙 — 4계층 문서 체계

본 프로젝트는 [요즘IT: "제한된 DevOps 리소스로 AI와 함께 쿠버네티스 운영하기"](https://yozm.wishket.com/magazine/detail/3710/) 의 4계층 방법론을 채택한다.

```
Layer 1 (work-plans/)       사람이 의사결정 (Why/How/Tradeoffs)
       │  증류
       ▼
Layer 2 (claude-context/)   AI용 최소 컨텍스트
       │  지시
       ▼
Layer 3 (runbooks/)         번호 순서 강제 실행 가이드
       │  참조
       ▼
Layer 4 (infra/)            불변 IaC (YAML)
```

철학·불변 원칙 상세: [`guidelines/00-methodology.md`](guidelines/00-methodology.md)

### 불변 원칙 (요약)

1. **AI는 판단, 실행은 선언형 도구** — ArgoCD가 적용, AI는 매니페스트만
2. **판단의 여지를 줄인다** — 값은 파일로 고정, 추정 금지
3. **상태는 파일에 산다** — cold-start에서 재구성 가능해야 함
4. **번호 순서는 강제력** — `runbooks/`는 건너뛰기 금지
5. **실패는 데이터** — 은폐 금지, `constraints.md`에 누적
6. **계약 위반 시 중단** — 사람 승인 없이 우회 금지

---

## 📂 디렉토리 구조

```
.
├── CLAUDE.md                  AI 진입 프로토콜 (세션마다 로드)
├── README.md                  이 파일 (사람용 진입점)
├── state.md                   전체 진척도 체크리스트
├── .claude/
│   ├── settings.local.json    DEV 환경 권한 (gitignored)
│   └── settings.prod.json     PROD 환경 권한 (읽기 전용)
├── guidelines/                방법론·계약·프로토콜 (6종)
│   ├── 00-methodology.md
│   ├── 01-layer-contracts.md
│   ├── 02-session-protocol.md
│   ├── 03-handoff-protocol.md
│   ├── 04-naming-conventions.md
│   ├── 05-state-management.md
│   └── 06-failure-recovery.md
├── work-plans/                Layer 1 — 의사결정 문서
├── claude-context/            Layer 2 — AI용 증류 컨텍스트
├── runbooks/                  Layer 3 — 실행 가이드
└── infra/                     Layer 4 — IaC (YAML)
    ├── argocd/
    ├── operators/
    ├── openshift-ai/
    └── poc/
```

---

## 🚀 시작하기 (사람)

### 1. 환경 변수 준비
```bash
cp .env.example .env    # 만든 후
# .env 편집
#   KUBECONFIG=/path/to/kubeconfig
#   CLUSTER_DOMAIN=apps.example.com
```

### 2. 현재 진척도 확인
[`state.md`](state.md) — 어느 Phase에 있고 무엇이 남았는지

### 3. 방법론 이해
- [`guidelines/00-methodology.md`](guidelines/00-methodology.md) — 왜 4계층인가
- [`guidelines/01-layer-contracts.md`](guidelines/01-layer-contracts.md) — 각 레이어 규칙
- [`guidelines/02-session-protocol.md`](guidelines/02-session-protocol.md) — 작업 순서

### 4. AI 세션 시작
AI 도구(Claude Code 등)가 이 디렉토리에 진입하면 `CLAUDE.md`를 자동으로 읽는다. AI가 state를 읽고 다음 태스크를 제안한다.

---

## 🤖 AI 도구 지원

| 도구 | 진입 파일 | 권한 제어 | 상태 |
|---|---|---|---|
| Claude Code | `CLAUDE.md` | `.claude/settings.local.json` | ✅ 활성 |
| Gemini CLI | `GEMINI.md` → `CLAUDE.md` (심볼릭) | Gemini 설정 | ✅ 활성 |
| OpenAI Codex | `AGENTS.md` → `CLAUDE.md` (심볼릭) | Codex 설정 | ✅ 활성 |

다중 도구 동시 사용 가능. 모든 도구가 **동일한 진입점**(CLAUDE.md 실체)을 읽고 **동일한 4계층 규칙**을 따른다.

### 진입 파일 변경 시 주의
`CLAUDE.md`가 실체(source), 나머지는 심볼릭 링크. `CLAUDE.md`만 수정하면 3개 도구에 동시 반영.

---

## 🧭 빠른 탐색

- **지금 뭐 하면 되지?** → [`state.md`](state.md) + [`claude-context/active-task.md`](claude-context/active-task.md)
- **왜 이렇게 설계했지?** → [`guidelines/00-methodology.md`](guidelines/00-methodology.md)
- **파일 어떻게 쓰지?** → [`guidelines/01-layer-contracts.md`](guidelines/01-layer-contracts.md)
- **실행 막혔을 때?** → [`guidelines/06-failure-recovery.md`](guidelines/06-failure-recovery.md)
- **최근 뭐 했지?** → [`claude-context/handoff-notes.md`](claude-context/handoff-notes.md)

---

## 🔗 참조

- 원조 방법론: https://yozm.wishket.com/magazine/detail/3710/
- OpenShift AI 호환 매트릭스: https://access.redhat.com/support/policy/updates/rhoai
- OpenShift GitOps: https://docs.openshift.com/gitops/
- ArgoCD: https://argo-cd.readthedocs.io/

---

## 📝 라이선스 / 저작자

내부 PoC 프로젝트. 저작자는 리포 오너.
