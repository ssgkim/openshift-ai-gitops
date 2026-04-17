# 프로젝트 진척도

전체 로드맵의 체크리스트. 세션 단위의 세부 상태는 [`claude-context/current-state.md`](claude-context/current-state.md), 누적 인수인계는 [`claude-context/handoff-notes.md`](claude-context/handoff-notes.md) 참조.

**진척 요약**: Phase 0 완료 ✅ · Phase 1 준비 (사람 입력 대기)

---

## 📍 현재 Phase

> **Phase 0 완료 → Phase 1 착수 준비 중** (`.env` 작성 및 RHOAI 목표 버전 결정 대기)

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

- [ ] `.env` 작성 (`KUBECONFIG`, `CLUSTER_DOMAIN` 등)
- [ ] `runbooks/00-preflight.md` 작성 (읽기 전용 점검 스크립트)
- [ ] OpenShift 버전 확인 → `version-matrix.md`
- [ ] 기존 설치된 Operator 목록 → `version-matrix.md`
- [ ] 기존 네임스페이스·ArgoCD 유무 → `constraints.md`
- [ ] RHOAI 호환 매트릭스에서 목표 버전 확정 → `version-matrix.md`
- [ ] `work-plans/001-gitops-boundary.md` — Day-0/1 경계 결정

**완료 기준**: `current-state.md`의 placeholder 3개 (버전·endpoint·도메인) 모두 채워짐 + `version-matrix.md` 주요 행 확정.

---

## Phase 2 — GitOps 부트스트랩

**목표**: ArgoCD 설치 + App-of-Apps 구조로 이후 자동화의 기반 마련.

- [ ] `work-plans/002-argocd-strategy.md` (AppProject 분리 정책 등)
- [ ] `infra/argocd/bootstrap/` — App-of-Apps 루트 매니페스트
- [ ] `infra/argocd/applications/` — 각 Application CR
- [ ] `runbooks/10-argocd-operator-install.md`
- [ ] `runbooks/20-app-of-apps.md`
- [ ] OpenShift GitOps Operator 설치 성공
- [ ] 첫 App-of-Apps sync 성공

**완료 기준**: ArgoCD 웹콘솔 접속 + App-of-Apps가 `Synced & Healthy`.

---

## Phase 3 — 플랫폼 Operator

**목표**: RHOAI 선행 조건 Operator를 GitOps로 설치.

- [ ] `work-plans/003-operator-dependency.md` — 의존성·설치 순서
- [ ] `infra/operators/subscriptions/` — 각 Subscription YAML
- [ ] `runbooks/30-platform-operators.md`
- [ ] cert-manager Operator
- [ ] ServiceMesh Operator
- [ ] Serverless Operator
- [ ] Pipelines Operator
- [ ] (선택) NFD + NVIDIA GPU Operator → `runbooks/45-gpu-stack.md`

**완료 기준**: 모든 Operator CSV가 `Succeeded`, ArgoCD에서 모두 Healthy.

---

## Phase 4 — OpenShift AI

**목표**: RHOAI Operator + DataScienceCluster 적용, 워크벤치까지 생성.

- [ ] `work-plans/004-openshift-ai-topology.md` — 컴포넌트 선택 근거
- [ ] `infra/openshift-ai/subscription.yaml` — RHOAI Operator
- [ ] `infra/openshift-ai/datasciencecluster.yaml` — 최소 컴포넌트 구성
- [ ] `runbooks/50-openshift-ai-install.md`
- [ ] DSC 상태 `Ready`
- [ ] 웹콘솔 RHOAI 대시보드 접근
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
