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

---

## 2026-04-19 Session 05 — Survey 실행 + 부분 결과 반영 + 스크립트 수정

- 완료:
  - `survey-output/survey-20260419-154527.txt` 분석 — OCP **4.20.18 / stable-4.20** 채널 확정
  - `claude-context/current-state.md` 갱신 — 패치 버전·TLS 경고·survey 중단 상황 반영
  - `claude-context/constraints.md` append — 자가서명 인증서 / survey 조기 중단 사유 기록
  - `claude-context/version-matrix.md` 갱신 — OCP 4.20.18 / stable-4.20 확정
  - `scripts/cluster-survey.sh` 버그 수정 — `history[0:3]` jsonpath → `history[*]` + `head -3` (array index OOB 방지)
  - `claude-context/active-task.md` 갱신 — 재실행 태스크로 교체
- 블로커: survey가 1-B 이후 중단되어 노드·Operator·StorageClass 미수집 → 스크립트 수정 완료, 재실행 필요
- 다음 세션이 할 일:
  1. `bash scripts/cluster-survey.sh --save` 재실행 (수정 완료, 전체 섹션 정상 동작 예상)
  2. 결과 파일 공유 → Claude가 Operator 체크박스·version-matrix 채움
  3. ArgoCD 설치 여부 확정 후 Phase 2(`runbooks/10-argocd-operator-install.md`) 진입 결정

---

## 2026-04-19 Session 06 — Phase 1 완료 + 클러스터 현황 전면 문서화

- 완료:
  - `survey-20260419-155529.txt` 전체 섹션(1-A~1-G) 분석 반영
  - `claude-context/current-state.md` — 노드(3+3), 스토리지(gp3-csi default), Operator 실제 설치 상태 전면 갱신. Phase 1 완료 선언.
  - `claude-context/constraints.md` — proxy 오브젝트 존재 + GPU 없음 제약 신규 append
  - `claude-context/version-matrix.md` — cert-manager 1.18.1/stable-v1 확정, GitOps/RHOAI 미설치 명시, NFD/GPU N/A 기록
  - `claude-context/active-task.md` — Phase 2(OpenShift GitOps 설치)로 교체
- 블로커: 없음 (Phase 1 정보 수집 완전 종료)
- 다음 세션이 할 일:
  1. `runbooks/10-argocd-operator-install.md` 작성 (AI 초안 가능)
  2. OperatorHub에서 `openshift-gitops-operator` 최신 채널 조회 → `version-matrix.md` 기록
  3. 사람이 Subscription + OperatorGroup 적용 → CSV Succeeded 확인 후 공유

---

## 2026-04-20 Session 08 — Phase 2 완료 (ArgoCD v1.20.1 설치 완료)

- 완료:
  - `runbooks/10-argocd-operator-install.md` 순서대로 실행 — CSV Succeeded, 전체 Pod Running
  - CSV: `openshift-gitops-operator.v1.20.1` / 상태: `Succeeded`
  - ArgoCD Route: `openshift-gitops-server-openshift-gitops.apps.cluster-95w9g.95w9g.sandbox2661.opentlc.com`
  - Proxy: httpProxy/httpsProxy 미설정 — 추가 조치 불필요
  - `claude-context/current-state.md` GitOps 체크박스 ✅ 갱신
  - `claude-context/active-task.md` Phase 3으로 교체
- 블로커: 없음
- 다음 세션이 할 일:
  1. `runbooks/20-rhoai-operator-install.md` 작성
  2. `oc apply -f infra/rhoai/` 실행 → CSV Succeeded 확인
  3. DataScienceCluster `default-dsc` 적용 → Ready 확인
  4. RHOAI Dashboard Route URL 확인 후 state 갱신

---

## 2026-04-19 Session 07 — Phase 2 IaC 준비 완료 (채널 확정 + infra/ + runbook)

- 완료:
  - `oc get packagemanifest` 실행 — GitOps: `latest`/v1.20.1, RHOAI: `stable-3.3`/3.3.2 확정
  - `claude-context/version-matrix.md` 갱신 — 두 채널 확정 기록
  - `infra/argocd/namespace.yaml` + `infra/argocd/subscription.yaml` 작성
  - `infra/rhoai/namespace.yaml` + `operator-group.yaml` + `subscription.yaml` + `datasciencecluster.yaml` 작성
  - `runbooks/10-argocd-operator-install.md` 작성 — `.env` 변수 참조, proxy 확인 절차 포함
  - `claude-context/current-state.md` + `active-task.md` 갱신
- 진행중: 없음 (AI 할 일 완료)
- 블로커: 사람이 `runbooks/10-argocd-operator-install.md` 로컬 실행 후 결과 공유 필요
- 다음 세션이 할 일:
  1. 사람이 runbook 실행 → CSV Succeeded + ArgoCD Route URL 공유
  2. Claude가 `current-state.md` GitOps 체크박스 ✅ 갱신
  3. Phase 3 (`runbooks/20-rhoai-operator-install.md`) 시작

---

## 2026-04-19 Session 04 — Phase 1 Survey 인프라 구축

- 완료:
  - `scripts/cluster-survey.sh` 작성 — `.env` 변수 참조, 파라메터화, idempotent, OCP 4.x 범용, `--save` 옵션으로 결과 파일 저장
  - `runbooks/01-cluster-survey.md` 작성 — 스크립트 사용법·기대 출력·결과 기록 위치·실패 대응 포함
  - `claude-context/current-state.md` 갱신 — Phase 1 진행 현황 반영, 미확인 항목 명시
  - `claude-context/active-task.md` 갱신 — 다음 세션 태스크(survey 실행·결과 반영) 명시
  - 재사용성 원칙 적용: 클러스터 하드코딩 없음, `.env` 변수만 참조
- 블로커: 샌드박스에서 클러스터 DNS 미해석 (프록시 allowlist 차단) → 실제 survey는 사람이 로컬에서 실행 필요
- 다음 세션이 할 일:
  1. `bash scripts/cluster-survey.sh --save` 로컬 실행 후 출력 공유
  2. Claude가 `constraints.md` 갱신, 사람이 `version-matrix.md` 갱신
  3. ArgoCD · RHOAI 채널 확정 → Phase 2(`runbooks/10-argocd-operator-install.md`) 시작
