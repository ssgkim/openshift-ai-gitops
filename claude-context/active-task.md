# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크
기존 OpenShift 클러스터의 현황을 조사하여 `version-matrix.md` · `constraints.md` · `current-state.md`의 placeholder를 채운다. (Phase 1 kickoff)

## 성공 기준 (Capabilities)
- [ ] `.env` 작성 (`KUBECONFIG`, `CLUSTER_DOMAIN`)
- [ ] `oc version`, `oc get clusterversion` 결과로 OpenShift 버전 확인
- [ ] `oc get csv -A`로 기존 Operator 목록 확인
- [ ] `oc get ns | grep -E "openshift-gitops|argocd"`로 기존 ArgoCD 유무 확인
- [ ] `version-matrix.md`에 OpenShift 버전·주요 Operator 채워짐
- [ ] `constraints.md`에 재사용 클러스터 제약 기록
- [ ] `current-state.md`의 placeholder 3개 (버전·endpoint·도메인) 채워짐
- [ ] `runbooks/00-preflight.md` 초안 작성 (읽기 전용 점검 스크립트)

## 참조 (Required Inputs)
- `state.md` Phase 1 섹션
- `guidelines/02-session-protocol.md` (세션 절차)
- `guidelines/05-state-management.md` (version-matrix는 사람만 갱신)
- `CLAUDE.md` (기존 리소스 변경 금지)

## 블로커 (Constraints)
- `KUBECONFIG` 경로 확정 필요 (사람이 `.env`에 입력)
- RHOAI 목표 버전 결정 필요 (사람 판단 — 호환 매트릭스 참조)
