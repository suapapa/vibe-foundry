# vibe-foundry 🗿

매일 OpenSCAD MCP로 생성한 **무작위 저폴리곤 3D 모델 아카이브**.

하루에 한 번, Agent가 OpenSCAD MCP를 사용해 랜덤한 물체(용, 성, 로켓, 올빼미...)의
SCAD 코드를 생성·검증하고, STL로 내보낸 뒤 날짜별 디렉터리에 저장합니다.

## 저장 구조

```
vibe-foundry/
├── README.md
├── AGENTS.md                  # Agent용 규칙
├── script/
│   ├── daily_model.py         # 오늘의 랜덤 아이디어 선택기
│   └── push_repo.sh           # 자동 커밋 & push
└── YYYY-MM-DD_<Name>/         # 날짜별 모델 디렉터리
    ├── model.scad             # OpenSCAD 소스
    ├── model.stl              # STL 메시 (3D 프린팅 가능)
    └── meta.yaml              # 메타데이터
```

## meta.yaml 형식

```yaml
date: "2026-07-27"
name: "Castle"
description: "A medieval castle with towers and battlements."
model_prompt: "Generate a complete, single-file OpenSCAD script for a Castle. ..."
```

## 자동화 (Hermes cron)

| 시간 (KST) | 작업 |
|---|---|
| 매일 12:00 | `script/daily_model.py`로 아이디어 선택 → OpenSCAD MCP로 SCAD 생성/검증 → STL export → `{날짜}_{이름}/` 저장 → git commit |
| 매일 13:00 | `script/push_repo.sh`로 남은 변경분 커밋 후 GitHub push |

## 수동 실행

```bash
python3 script/daily_model.py     # 오늘의 아이디어 확인 (JSON 출력)
bash    script/push_repo.sh       # 지금 push
```
