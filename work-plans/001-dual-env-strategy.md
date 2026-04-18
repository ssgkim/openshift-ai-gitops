# 듀얼 환경(Connected + Air-gap) 전략

- 작성일: 2026-04-17
- 최종 수정: 2026-04-17

## Why (왜 이 결정이 필요한가)

- 본 프로젝트는 **연결망(Connected) 환경에서 1차 PoC**를 수행한 뒤, **향후 별도의 Air-gap 환경**에 동일 구성을 재현해야 한다.
- Air-gap은 외부 registry·Git·OperatorHub 접근 불가. 따라서 **초기 설계부터 이식 가능성**을 고려하지 않으면 재작업 비용이 급격히 커진다.
- 두 환경은 물리적으로 분리되며, 자산(이미지·Git·카탈로그) 이동은 **외장 SSD를 매체로 하는 1회성 부트스트랩**을 전제한다.
- Layer 2/3/4 구조가 환경 전환 시 **분기되지 않고 값만 치환**되도록 공통 뼈대를 먼저 고정해야 한다.

## How (어떤 옵션이 있고, 어떻게 할 것인가)

환경 전환 방식에 대한 4가지 구조 옵션:

### 옵션 A — Git 브랜치 분리
- `main`(Connected) / `airgap`(Air-gap) 브랜치 분리, 사람이 수동 병합
- 장점: 구조 단순, 이해 쉬움
- 단점: Drift 누적, 병합 지옥, 진실 공급원(Single Source of Truth) 상실

### 옵션 B — Kustomize overlay (`base/` + `overlays/{connected,airgap}/`)
- `infra/` 아래 `base/`에 공통, `overlays/`에서 환경 변수·registry·이미지 태그만 patch
- 장점: GitOps 친화, 하나의 리포가 진실, ArgoCD ApplicationSet와 궁합 좋음
- 단점: 초기 overlay 설계 비용, 과도한 patch 시 가독성 저하

### 옵션 C — 멀티 리포 (Connected 리포 + Air-gap 리포)
- 각각 독립 리포, Air-gap 리포는 연결망에서 1회 push → SSD → Gitea push
- 장점: 완전 분리로 보안 경계 명확
- 단점: 공통 업데이트 이중 반영, 본 프로젝트의 작은 규모에 과도

### 옵션 D — 런타임 치환 (단일 브랜치, 환경 변수로만 구분)
- `.env` / ConfigMap으로 registry URL 등을 주입, YAML은 환경 변수 placeholder 사용
- 장점: 리포 하나, 브랜치 하나
- 단점: ArgoCD는 순수 선언형을 선호, 환경 변수 치환 레이어 별도 필요(Helm/envsubst)

**제안 진행 방법**:
- 옵션 B(Kustomize overlay)를 **기본 방향**으로 가정하되, Phase 1에서 클러스터 상태 확인 후 확정
- 환경 간 자산 이동은 아래 **확정된 싱크 방식**으로 고정

### 자산 싱크 방식 (결정됨)

| 대상 | 방법 | 매체 | 주기 |
|---|---|---|---|
| 컨테이너 이미지 + Operator 카탈로그 | `oc-mirror` (v2 권장) | 외장 SSD | **1회성**(초기 부트스트랩) |
| Git 리포 | GitHub → 로컬 clone → 외장 SSD → Gitea push | 외장 SSD | **1회성**(초기 부트스트랩) |
| 업데이트 반영 | 필요 시 **동일 절차 수동 재실행** | 외장 SSD | 수동 |

- `oc-mirror` 선택 이유: Red Hat 공식, OpenShift + Operator 카탈로그를 한 번에, ImageDigestMirrorSet 자동 생성
- 1회성 선택 이유: PoC 범위가 고정적, 지속적 싱크 자동화는 운영 단계에서 재검토

## Tradeoffs (각 옵션의 장단점)

| 옵션 | 유지 비용 | Drift 위험 | GitOps 적합성 | 본 프로젝트 적합도 |
|---|---|---|---|---|
| A 브랜치 분리 | 높음 | **매우 높음** | 중 | 낮음 |
| B Kustomize overlay | 중 | 낮음 | **높음** | **높음** (권장) |
| C 멀티 리포 | 높음 | 중 | 중 | 낮음 (규모 과다) |
| D 런타임 치환 | 낮음 | 낮음 | 낮음 | 중 |

`oc-mirror` vs `skopeo sync`:
- `oc-mirror`: Red Hat 지원, 카탈로그 포함, `ImageDigestMirrorSet` 자동 생성 → **선택**
- `skopeo sync`: 가볍지만 카탈로그 수동 구성 필요

## Decision (무엇을 선택했고 그 이유)

- **구조 옵션: 보류** (Phase 1 클러스터 조사 후 옵션 B 적합성 최종 확인)
- **자산 싱크: 확정**
  - 이미지·카탈로그: `oc-mirror`
  - Git: GitHub 경유 후 외장 SSD로 내부 Gitea push
  - 매체: 외장 SSD
  - 주기: 1회성 초기 부트스트랩 (업데이트는 동일 절차 수동)
- 이유:
  - 구조(옵션 B)는 `infra/` 실제 작성 전에는 과설계 위험. Phase 1 산출물(`version-matrix.md`, `constraints.md`) 확정 이후 판정해도 늦지 않음.
  - 싱크 방식은 반대로, `.env.example`·`constraints.md`·runbook 번호 할당에 즉시 영향이 있어 **지금 고정**해야 이후 파일이 흔들리지 않음.

## Open Questions (미결 사항)

- [ ] Connected 환경의 Git 원격은 GitHub인가 내부 Gitea인가 (`.env`에 `GIT_REMOTE_URL` 확정 필요)
- [ ] Air-gap 환경의 Gitea는 신규 구축인가 기존 재사용인가
- [ ] `oc-mirror` v1/v2 중 선택 (v2는 imageset-config 스펙이 다름, Phase 1에서 OCP 버전 확인 후 결정)
- [ ] ArgoCD ApplicationSet 도입 여부 (환경별 overlay 자동화)
- [ ] OpenShift internal registry vs Quay의 역할 분담 (일반 이미지 / 운영 이미지 구분 기준)
- [ ] 외장 SSD 전달 주체·주기·보안 절차 (조직 정책)

## References

- OpenShift: Mirroring images for a disconnected installation using oc-mirror — https://docs.openshift.com/container-platform/latest/disconnected/mirroring/about-installing-oc-mirror-v2.html
- Red Hat Quay on OpenShift — https://access.redhat.com/documentation/en-us/red_hat_quay/
- OpenShift GitOps (ArgoCD) ApplicationSet — https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/
- Kustomize overlays — https://kubectl.docs.kubernetes.io/guides/config_management/components/
- Gitea air-gap 구축 사례 — (Phase 1에서 확정 링크 추가 예정)
