# 누적 제약 (append only, 삭제 금지)

> **이 파일을 읽으면 프로젝트 전 기간에 걸쳐 누적된 제약·교훈·재발 방지 정보를 파악할 수 있다.** 기존 항목 수정·삭제 금지. 형식은 `guidelines/05-state-management.md` 참조.

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

## 2026-04-19: 자가서명 TLS 인증서 (Session 05 survey 확인)

- 맥락: `bash scripts/cluster-survey.sh --save` 실행, 섹션 1-A 로그인 단계
- 내용: 클러스터 API 서버가 **자가서명 인증서** 사용. `oc login` 시 `WARNING: Using insecure TLS client config` 경고 발생.
  - 모든 `oc` 명령에 `--insecure-skip-tls-verify=true` 옵션 필요 (또는 `.env`의 `OC_INSECURE=true` 활용)
  - ArgoCD가 클러스터 API에 연결할 때도 TLS 검증 비활성화 설정 필요할 수 있음
- 영향 범위:
  - `runbooks/` — `oc` 명령 예시에 insecure 플래그 명시 또는 kubeconfig 활용
  - `infra/argocd/` — ArgoCD cluster secret에 `insecure: true` 또는 CA 번들 주입 고려
  - Air-gap 환경 — 동일 제약 예상

---

## 2026-04-19: survey 스크립트 조기 중단 (Session 05)

- 맥락: `bash scripts/cluster-survey.sh --save` 실행 결과 (`survey-output/survey-20260419-154527.txt`)
- 내용: 스크립트가 **1-B 섹션(OCP 버전) 이후 중단**. 파일 36줄에서 종료. 노드·Operator·StorageClass 정보 미수집.
  - ClusterVersion jsonpath 오류 (`array index out of bounds: index 2, length 1`) — 업데이트 이력이 1건뿐이라 발생. 스크립트 중단 원인은 별도 확인 필요.
  - 다음 재실행 전 `scripts/cluster-survey.sh`의 jsonpath 쿼리 방어 코드 검토 권장
- 영향 범위:
  - Phase 2 시작 전 **survey 재실행 필수** — Operator 설치 여부 미확인 상태
  - `version-matrix.md`의 Operator 버전 항목 아직 미채움

---

## 2026-04-19: Cluster Proxy 설정 존재 (Session 06 survey 확인)

- 맥락: `survey-20260419-155529.txt` 섹션 1-G, `oc get proxy cluster -o json`
- 내용: 클러스터 Proxy 오브젝트(`proxy/cluster`)가 존재. 현재 `httpProxy`/`httpsProxy` 미설정이나 `trustedCA.name`이 빈 값으로 설정된 상태.
  - OpenShift GitOps(ArgoCD) 설치 시: ArgoCD 컨트롤러가 외부 git 레포에 접근할 때 proxy 설정 상속 여부 확인 필요
  - RHOAI 설치 시: `DSCInitialization` CR의 `devFlags.logMode` 및 proxy 설정 반영 여부 확인 필요
  - 향후 `httpProxy`/`httpsProxy` 값이 추가되는 경우, 모든 Operator 설치 runbook에 proxy 환경변수 주입 절차 추가 필요
- 영향 범위:
  - `runbooks/10-argocd-operator-install.md` — ArgoCD CSV 배포 전 proxy 전파 확인 절차 포함
  - `runbooks/20-rhoai-operator-install.md` — DSCInitialization proxy 필드 검토
  - Air-gap 환경 — proxy 설정이 내부 레지스트리와 충돌하지 않도록 `noProxy` 항목 검토 필요

---

## 2026-04-19: GPU 노드 없음 — GPU Workload 불가 (Session 06 survey 확인)

- 맥락: `survey-20260419-155529.txt` 섹션 1-G, GPU 노드 라벨·NFD/GPU Operator CSV 조회
- 내용: GPU 라벨(`nvidia.com/gpu`) 노드 없음. NFD Operator·NVIDIA GPU Operator 미설치.
  - GPU 가속 워크벤치·모델 서빙(KServe GPU backend) 불가
  - Connected PoC 범위에서 GPU 워크로드는 제외
  - 향후 GPU 노드 추가 시 NFD → GPU Operator 순서 설치 필요 (`constraints.md`에 추가 기록)
- 영향 범위:
  - `version-matrix.md` — NFD·GPU Operator 항목 "N/A (GPU 노드 없음)"으로 명시
  - `work-plans/` — PoC 항목에서 GPU 추론·분산 훈련 제외 (Phase 5 검토)
  - `infra/rhoai/datasciencecluster.yaml` — kserve ServingRuntime GPU 설정 비활성화

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
