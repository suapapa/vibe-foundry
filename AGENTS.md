# AGENTS.md — vibe-foundry 작업 규칙

이 저장소는 Agent가 매일 3D 모델을 생성해 쌓는 아카이브다. 아래 규칙을 따를 것.

## 매일의 흐름 (12:00 생성 → 13:00 push)

1. `python3 script/daily_model.py` 실행 → JSON 한 줄 출력(`date`, `name`, `description`, `model_prompt`).
2. `model_prompt`를 바탕으로 **단일 파일 OpenSCAD 스크립트**를 작성한다.
   - 프리미티브(`sphere`, `cylinder`, `cube`) + 변환(`translate`, `rotate`, `scale`)만 사용.
   - 알아볼 수 있는 low-poly 형태, 단일 연결 manifold.
   - `$fn = 32;`를 상단에 둔다. 설명 없이 순수 SCAD 코드만.
3. **OpenSCAD MCP로 검증**: `openscad_validate`로 진단, 오류/경고는 수정 후 재검증.
   - 도구가 툴 목록에 없으면 `tool_search`로 "openscad" 검색 후 `tool_describe`/`tool_call`로 로드.
4. `openscad_export_model(format="stl")`로 STL 획득 → 디코딩해 `model.stl` 저장.
5. 저장 경로는 저장소 루트 기준 `{date}_{Name}/` — 이름의 공백은 `_`로 치환
   (예: `2026-07-12_Coffee_Mug/`).
   - 이미 존재하면 다른 이름으로 다시 고른다 (하루 1모델, 이름 충돌 금지).
6. 파일 3개 저장: `model.scad`, `model.stl`, `meta.yaml`.
7. `git add` + `git commit -m "Add {date} {name} model"` — **push는 하지 않는다** (13:00 잡이 담당).

## meta.yaml 규칙

기존 파일과 동일하게 `date`, `name`, `description`, `model_prompt` 4개 필드를
따옴표 있는 문자열로. 필드 이름/순서 변경 금지.

## 금지 사항

- `.gitignore`에 STL 제외 같은 것 하지 말 것 — STL은 커밋 대상.
- 날짜 디렉터리 안의 기존 파일을 수정/삭제하지 말 것 (append-only 아카이브).
- push는 `script/push_repo.sh`(13:00 cron) 또는 명시적 사용자 요청에서만.
