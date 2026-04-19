# 다음 태스크

> **이 파일을 읽으면 현재 세션에서 실행할 태스크, 성공 기준, 필요한 입력, 블로커를 한 번에 파악할 수 있다.**

## 태스크

`bash scripts/cluster-survey.sh --save` 실행 결과를 기반으로 Phase 1 조사 데이터를 확정하고, `version-matrix.md`·`constraints.md`를 갱신한다.

## 성공 기준 (Capabilities)

- [ ] `scripts/cluster-survey.sh --save` 실행 완료 → `survey-output/` 파일 생성
- [ ] `version-matrix.md` — OpenShift 채널, 기존 Operator 버전·채널 채워짐 (사람이 갱신)
- [ ] `constraints.md` — ArgoCD·RHOAI 설치 유무, StorageClass, Proxy 여부 기록
- [ ] `current-state.md` 설치 상태 체크박스 업데이트
- [ ] ArgoCD · RHOAI 3.3 구독 채널 확정 → `version-matrix.md`에 기록

## 참조 (Required Inputs)

- `scripts/cluster-survey.sh` 실행 결과 (`survey-output/` 최신 파일)
- `claude-context/version-matrix.md` (Operator 버전 기록 위치)
- `claude-context/constraints.md` (제약 기록 위치)
- `guidelines/05-state-management.md` (version-matrix는 사람만 갱신)

## 블로커 (Constraints)

- **사람이 로컬에서 `bash scripts/cluster-survey.sh --save` 실행 필요**
  - `oc` CLI 설치 및 클러스터 네트워크 접근 가능한 환경에서 실행
  - 결과 파일(`survey-output/*.txt`) 또는 출력 내용을 Claude에게 공유
- 결과 공유 후 Claude가 `constraints.md` 갱신 + 사람이 `version-matrix.md` 갱신
