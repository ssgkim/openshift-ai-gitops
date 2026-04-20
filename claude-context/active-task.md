# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

**Phase 3: OpenShift AI (RHOAI) Operator 설치**

`runbooks/20-rhoai-operator-install.md`를 작성하고, RHOAI Operator + DataScienceCluster를 클러스터에 설치한다.

## 성공 기준 (Capabilities)

- [x] Phase 2 완료 — ArgoCD v1.20.1 설치 완료, CSV Succeeded, 전체 Pod Running ✅
- [ ] `runbooks/20-rhoai-operator-install.md` 작성
- [ ] `oc apply -f infra/rhoai/` 실행 → CSV Succeeded 확인
- [ ] DataScienceCluster `default-dsc` 적용 → `Ready` 확인
- [ ] RHOAI Dashboard Route URL 확인
- [ ] `current-state.md` — RHOAI 체크박스 ✅ 갱신
- [ ] `version-matrix.md` — RHOAI 설치 상태 갱신

## 참조 (Required Inputs)

- `infra/rhoai/` — namespace, operator-group, subscription, datasciencecluster YAML
- `.env` — 클러스터 접속 정보
- `claude-context/constraints.md` — TLS·proxy 제약

## 블로커 (Constraints)

- 없음 (infra/rhoai/ YAML 이미 작성 완료)
