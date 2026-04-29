# 프로젝트 진척도

전체 로드맵의 체크리스트. 세션 단위의 세부 상태는 [`claude-context/current-state.md`](claude-context/current-state.md), 누적 인수인계는 [`claude-context/handoff-notes.md`](claude-context/handoff-notes.md) 참조.

**진척 요약**: 새 샌드박스 기준으로 재정렬 중 · OCP 4.21.9 / RHOAI 목표 3.4.0(관측 CSV 3.4.0-ea.1) 확정 · GitOps 미설치 · DSC NotReady 원인 조사 대기

---

## 📍 현재 Phase

> **새 샌드박스 재정렬 중** — RHOAI 목표는 3.4.0으로 확정. 새 환경에는 OpenShift GitOps가 아직 없고 `default-dsc`가 NotReady라 Phase 2~4를 새 환경 기준으로 재검증해야 한다.

---

## Phase 0 — 방법론 체계 구축

**목표**: AI + 사람이 안전하게 협업할 수 있는 구조·계약·프로토콜 확립.

- [x] git 리포 초기화 + 4계층 디렉토리 뼈대
- [x] `.gitignore`
- [x] `CLAUDE.md` 진입 프로토콜
- [x] `guidelines/00-methodology.md` — 철학·불변 원칙
- [x] `guidelines/01-layer-contracts.md` — 레이어 계약
- [x] `guidelines/02-session-protocol.md` — 세션 프로토콜
- [x] `guidelines/03-handoff-protocol.md` — 인수인계
- [x] `guidelines/04-naming-conventions.md` — 네이밍
- [x] `guidelines/05-state-management.md` — 상태 관리
- [x] `guidelines/06-failure-recovery.md` — 실패 복구
- [x] `README.md` — 사람용 진입점
- [x] `state.md` — 이 파일
- [x] `.claude/settings.local.json` (DEV 환경 권한)
- [x] `.claude/settings.prod.json` (PROD 읽기 전용)
- [x] `claude-context/current-state.md` 초기 스켈레톤
- [x] `claude-context/active-task.md` 초기 태스크
- [x] `claude-context/constraints.md` 초기값
- [x] `claude-context/version-matrix.md` 초기값
- [x] `claude-context/handoff-notes.md` Session 01 엔트리
- [x] `.env.example` 템플릿
- [x] `GEMINI.md` / `AGENTS.md` 심볼릭 링크 (Codex / Gemini CLI 호환)

**완료 기준**: 처음 보는 사람이 `README.md` + `guidelines/` 읽고 작업 이어받을 수 있음.

---

## Phase 1 — 기존 클러스터 조사

**목표**: 재사용할 클러스터의 현황을 파악하고 `version-matrix.md`·`constraints.md`를 채운다.

- [x] `.env` 작성 (Session 03)
- [x] `runbooks/00-preflight.md` 작성 (Session 02)
- [x] `runbooks/01-cluster-survey.md` + `scripts/cluster-survey.sh` (Session 04)
- [x] OpenShift 버전 확인 → `version-matrix.md` (새 샌드박스 4.21.9 / stable-4.21)
- [x] 기존 설치된 Operator 목록 → `version-matrix.md` (cert-manager 1.19.0, ServiceMesh 3.2.0, RHOAI 3.4.0-ea.1 관측, GitOps 미설치)
- [x] 기존 네임스페이스·ArgoCD 유무 → `constraints.md` (새 샌드박스 ArgoCD 미설치, proxy 오브젝트 존재, GPU 없음, 자가서명 TLS)
- [x] RHOAI 호환 매트릭스에서 목표 버전 확정 → `version-matrix.md` (3.4.0 / beta, 관측 CSV 3.4.0-ea.1)
- [ ] `work-plans/001-dual-env-strategy.md` Open Questions 해소 (※ Air-gap 이행 시점까지 보류)
- [ ] `work-plans/002-gitops-boundary.md` — Day-0/1 경계 결정 (※ 듀얼 환경 확정 후 작성)

**완료 기준**: `current-state.md`의 placeholder 3개 (버전·endpoint·도메인) 모두 채워짐 + `version-matrix.md` 주요 행 확정 + `001-dual-env-strategy.md` Decision 확정.

---

## Phase 2 — GitOps 부트스트랩

**목표**: ArgoCD 설치 + App-of-Apps 구조로 이후 자동화의 기반 마련.

- [ ] `work-plans/002-argocd-strategy.md` (AppProject 분리 정책 등) — ※ 직접 `oc apply` 방식 채택으로 보류
- [ ] `infra/argocd/bootstrap/` — App-of-Apps 루트 매니페스트 (※ 미적용)
- [ ] `infra/argocd/applications/` — 각 Application CR (※ 미적용)
- [x] `runbooks/10-argocd-operator-install.md` (Session 07)
- [ ] `runbooks/20-app-of-apps.md` (※ 현재는 단순 `oc apply` 경로, 향후 App-of-Apps 재검토 필요)
- [ ] OpenShift GitOps Operator 설치 성공 — 새 샌드박스 기준 미설치
- [ ] 첫 App-of-Apps sync 성공 (※ 보류)

**완료 기준**: ArgoCD 웹콘솔 접속 + App-of-Apps가 `Synced & Healthy`.

---

## Phase 3 — 플랫폼 Operator

**목표**: RHOAI 선행 조건 Operator를 GitOps로 설치.

- [ ] `work-plans/003-operator-dependency.md` — 의존성·설치 순서 (※ OLM 의존성 자동 해결로 보류)
- [ ] `infra/operators/subscriptions/` — 각 Subscription YAML (※ RHOAI가 ServiceMesh 자동 설치)
- [ ] `runbooks/30-platform-operators.md` (※ 개별 runbook 불필요)
- [x] cert-manager Operator — 새 샌드박스 기존 설치 (v1.19.0)
- [x] ServiceMesh Operator — 새 샌드박스 설치됨 (servicemeshoperator3.v3.2.0)
- [ ] Serverless Operator — RHOAI 3.4.0 PoC 구성에 따라 재검토
- [ ] Pipelines Operator — RHOAI 내장 `datasciencepipelines` 사용 (별도 설치 불필요)
- ⛔ NFD + NVIDIA GPU Operator — GPU 노드 없음 (N/A)

**완료 기준**: 모든 Operator CSV가 `Succeeded`, ArgoCD에서 모두 Healthy.

---

## Phase 4 — OpenShift AI

**목표**: RHOAI Operator + DataScienceCluster 적용, 워크벤치까지 생성.

- [ ] `work-plans/004-openshift-ai-topology.md` — 컴포넌트 선택 근거 (※ 사후 문서화 필요)
- [x] `infra/rhoai/subscription.yaml` — RHOAI Operator (Session 07, 실제 경로 `infra/rhoai/`)
- [x] `infra/rhoai/datasciencecluster.yaml` — `default-dsc` 구성 (Session 07)
- [x] `runbooks/20-rhoai-operator-install.md` (Session 09) — ※ 번호는 `guidelines/01-layer-contracts.md` 할당(50)과 상이. 재정렬 여부 별도 결정.
- [ ] DSC 상태 `Ready` — 새 샌드박스 `default-dsc NotReady`
- [ ] 웹콘솔 RHOAI 대시보드 접근 — 새 샌드박스 기준 재확인 필요
- [ ] 워크벤치 1개 생성 성공

**완료 기준**: 워크벤치에서 Python 셀 실행 성공.

---

## Phase 5 — PoC 검증

**목표**: 선정된 PoC 항목 N개를 독립 검증.

- [ ] `work-plans/005-poc-success-criteria.md` — 항목·합격 기준 정의
- [ ] PoC 항목 선정 (2–4개, 예: 노트북 / KServe / Pipelines / Ray)
- [ ] 항목별 `runbooks/60-a-*`, `60-b-*`, ... 작성
- [ ] 항목별 `infra/poc/<item>/` 매니페스트
- [ ] 서브에이전트 + worktree로 **병렬 검증**
- [ ] `runbooks/70-validate-all.md` — 종합 스모크
- [ ] 종합 리포트 작성

**완료 기준**: 선정 항목 전부 합격 + teardown 후 재실행 시 재현.

---

## 🗂 세션 히스토리 요약

상세는 [`claude-context/handoff-notes.md`](claude-context/handoff-notes.md). 여기는 Phase 전환·큰 마일스톤만.

- **2026-04-17** Session 01 — Phase 0 시작 및 완료 (방법론 체계 구축)
- **2026-04-18** Session 02 — 듀얼 환경 전략 초안 + Preflight 런북
- **2026-04-19** Session 03~06 — Phase 1 완료 (cluster survey, `.env`, constraints 확정)
- **2026-04-19** Session 07 — Phase 2 IaC 준비 (GitOps 채널 확정 · `infra/` · runbook 작성)
- **2026-04-20** Session 08 — Phase 2 완료 (GitOps v1.20.1 설치)
- **2026-04-20** Session 09 — Phase 3 완료 (RHOAI 3.3.2 설치, DSC Ready, ServiceMesh 자동 설치)
- **2026-04-22** Session 10 — `state.md` 동기화 + `odh-gitops` 레퍼런스 분석 (향후 Phase 5 참조용)
- **2026-04-29** Session 10 복구 — 새 샌드박스 survey 발견(OCP 4.21.9, RHOAI 3.4.0-ea.1, GitOps 미설치, DSC NotReady) → 현재 타깃 재확정 필요
- **2026-04-29** — 사용자 결정: 새 샌드박스 RHOAI 목표를 3.4.0으로 확정

---

## 📎 범례

- `[x]` 완료
- `[ ]` 미완료
- `[~]` 진행 중 (해당 시 각주로 진행 상태 명시)

---

## 🔄 갱신 규칙

- 체크박스 전환은 **검증 성공 후에만**
- Phase 전환 시 이 파일 상단 "현재 Phase" 업데이트
- 새 Phase 항목 추가는 사람 승인 후
- 본 파일은 **사람/AI 모두** 수정 가능 (git 커밋으로 추적)
