# 인수인계 노트

> **이 파일을 읽으면 세션별 완료·진행중·블로커·다음 할 일을 파악할 수 있다.** 형식 및 규칙: `guidelines/03-handoff-protocol.md`. 신규 엔트리는 **파일 하단에 추가**, 기존 엔트리 수정 금지.
> 2026-04-29: 오래된 엔트리는 `claude-context/archive/handoff-2026-Q2.md`로 이관함.

---

## 2026-04-29 Session 10 복구 — 새 샌드박스 survey 발견

- 완료: 중단점 복구 중 `survey-output/survey-20260422-210156.txt` 확인, `current-state.md`/`active-task.md`/`state.md`를 환경 재정렬 대기 상태로 보정
- 진행중: 새 샌드박스를 현재 타깃으로 전환할지 결정 필요
- 블로커: 새 survey는 OCP 4.21.9 / RHOAI 3.4.0-ea.1 / GitOps 미설치 / DSC NotReady이며 기존 version-matrix와 불일치
- 다음 세션이 할 일: 사람이 새 샌드박스 전환 여부와 RHOAI 3.4.0-ea.1 수용 여부 결정
- 발견된 제약: 샌드박스 교체 시 상태 재확정 필요 (`constraints.md` 반영)

---

## 2026-04-29 Session 11 — RHOAI 3.4.0 목표 확정

- 완료: 사용자 결정에 따라 새 샌드박스 RHOAI 목표를 3.4.0으로 확정하고 `version-matrix.md`, `current-state.md`, `active-task.md`, `infra/rhoai/`, `runbooks/20-rhoai-operator-install.md` 반영
- 진행중: 새 샌드박스 Phase 2~4 재검증
- 블로커: survey 기준 GitOps 미설치, `default-dsc NotReady`, 관측 CSV가 `3.4.0-ea.1`
- 다음 세션이 할 일: GitOps 설치 여부 확정 후 `default-dsc NotReady` 원인 조사
- 발견된 제약: RHOAI 3.4.0 목표와 관측 CSV 표기 차이 기록 (`constraints.md` 반영)

---

## 2026-04-29 Session 12 — 클러스터 접근 확인 + DSC 원인 확인

- 완료: 실제 클러스터 로그인, Console/API URL 확인, OpenShift 4.21.9, GitOps 1.20.2, RHOAI 3.4.0-ea.1, Dashboard Route 확인
- 진행중: `default-dsc NotReady` 해소 방향 결정
- 블로커: ModelsAsService는 `maas-default-gateway` 없음, Trainer는 JobSet Operator 없음
- 다음 세션이 할 일: PoC 범위 기준으로 ModelsAsService/Trainer를 Removed 처리할지 의존성 설치할지 결정
- 발견된 제약: DSC NotReady 원인 기록 (`constraints.md` 반영)

---

## 2026-04-29 Session 13 — 운영 유지관리 모드 전환

- 완료: 프로젝트 목적을 부트스트랩 실행에서 운영 유지관리로 재정의하고 `CLAUDE.md`, `README.md`, state/context에 권한 경계 반영
- 진행중: DSC NotReady 해소 방향 결정
- 블로커: 운영 모드에서는 직접 클러스터 변경이 기본 경로가 아니며 Git/IaC + ArgoCD 반영 절차 필요
- 다음 세션이 할 일: ModelsAsService/Trainer 처리 방향을 IaC 변경안으로 정리
- 발견된 제약: 부트스트랩 권한은 예외, 운영 기본 권한은 읽기 진단 중심 (`constraints.md` 반영)

---

## 2026-04-29 Session 14 — RHOAI 의존성 보강 및 DSC Ready 확보

- 완료: JobSet(v1.0.0), LeaderWorkerSet(v1.0.0), `openshift-ingress/maas-default-gateway`를 설치/생성해 `default-dsc` Ready 확인
- 진행중: live DSC v2 스펙과 `infra/rhoai/datasciencecluster.yaml` 정합화 필요
- 블로커: App-of-Apps/ArgoCD 소유권 구조 미완성, PoC 항목 미정
- 다음 세션이 할 일: DSC IaC 정합화 후 워크벤치 1개 생성 및 Python 셀 스모크 검증
- 발견된 제약: JobSet은 `openshift-jobset-operator`, LWS는 `openshift-lws-operator`, MaaS는 `maas-default-gateway` 필요

---

## 2026-04-29 Session 15 — RHOAI IaC 정합화 + PoC 워크벤치 스모크

- 완료: `infra/rhoai/datasciencecluster.yaml`를 live v2 스펙과 정합화(`oc diff` exit 0), `infra/argocd/applications/rhoai.yaml` + `runbooks/30-argocd-app-sync.md` 작성, `infra/poc/workbench-smoke/{namespace,pvc,notebook}.yaml` 작성·적용 후 `smoke-wb-0` 2/2 Running 및 `python -c 'print(1+1)'` 검증 통과
- 진행중: 부트스트랩 단계 종료, 운영 모드 전환 트리거 대기
- 블로커: `.env`의 `GITHUB_REMOTE`가 placeholder, ArgoCD repository 인증 수단 미확정
- 다음 세션이 할 일: `runbooks/30-argocd-app-sync.md` 따라 RHOAI Application 등록 → diff → sync 후 drift 0 유지 확인
- 발견된 제약: RHOAI 3.4의 워크벤치 인증 사이드카는 `oauth-proxy`가 아니라 `kube-rbac-proxy`로 자동 주입됨 (ArgoCD `ignoreDifferences` 후보)

---

## 2026-04-29 Session 16 — 프레임워크 정합화

- 완료: `CLAUDE.md`/`README.md`/state/context를 BOOTSTRAP → 완료 선언 → OPS 단계 모델로 정리하고 runbook 번호·infra 구조·PoC 네이밍 계약을 실제 구조에 맞춤
- 진행중: OPS 전환 트리거 대기
- 블로커: ArgoCD Application sync 검증과 사람의 초기 구축 완료 선언 필요
- 다음 세션이 할 일: `runbooks/30-argocd-app-sync.md`로 `rhoai` Application 등록/diff/sync 검증
- 발견된 제약: 단계 모델 정정은 `constraints.md`에 append-only로 기록

---

## 2026-04-29 Session 17 — CPU LLM PoC 배포

- 완료: `rhoai-poc-llm-cpu` 프로젝트, vLLM CPU x86 ServingRuntime, `smollm2-135m-cpu` InferenceService 적용 및 `/v1/completions` 검증 통과
- 진행중: BOOTSTRAP 산출물의 ArgoCD Application/ApplicationSet 편입
- 블로커: OPS 전환 전 PoC/의존성 리소스 관리 범위 결정 필요
- 다음 세션이 할 일: `rhoai`, JobSet/LWS/MaaS Gateway, PoC 리소스를 ArgoCD 관리 범위에 편입 후 sync 검증
- 발견된 제약: CPU vLLM은 KV cache/model length 튜닝과 Recreate rollout 필요 (`constraints.md` 반영)

---

## 2026-04-30 Session 18 — GitOps 인계 범위 분할

- 완료: `ai-accelerator` installation/overview 패턴을 참고해 `work-plans/002-gitops-handover-scope.md` 작성
- 진행중: BOOTSTRAP 산출물의 ArgoCD 인계를 Scope 1~5로 순차 진행
- 블로커: Git remote 공개/비공개 여부와 ArgoCD repository secret 필요 여부 미확정
- 다음 세션이 할 일: [CHECKPOINT] 후 Scope 1(AppProject/repo config/root bootstrap 구조)만 진행
- 발견된 제약: 한 번에 ApplicationSet 흡수 금지, Scope 단위 체크리스트 갱신 후 다음 단계 진행
