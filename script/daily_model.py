#!/usr/bin/env python3
"""vibe-foundry daily model idea picker.

Cron(12:00)가 실행: 오늘의 랜덤 모델 아이디어를 JSON 한 줄로 출력한다.
오늘 날짜 디렉터리에 이미 사용된 이름은 제외하고 고른다.
출력 예:
  {"date": "2026-09-08", "name": "Owl", "description": "...",
   "model_prompt": "Generate a complete, single-file OpenSCAD script ...",
   "output_dir": "2026-09-08_Owl"}
"""

import datetime
import json
import random
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent

OBJECT_IDEAS = [
    ("Dog", "A cute, low-poly representation of a dog."),
    ("Cat", "A stylized, low-poly cat silhouette."),
    ("Dragon", "A mythical dragon with wings and a long tail."),
    ("Spaceship", "A futuristic spaceship with sleek lines."),
    ("Coffee Mug", "A simple, cozy coffee mug with a handle."),
    ("Tree", "A stylized pine tree with a textured trunk."),
    ("Castle", "A medieval castle with towers and battlements."),
    ("Robot", "A cute, small robot with antenna and blocky limbs."),
    ("Bird", "A small bird perched on a branch."),
    ("Rocket", "A classic retro-style rocket ship."),
    ("Octopus", "A sea creature with many tentacles."),
    ("Owl", "A wise-looking owl with large eyes."),
    ("Unicorn", "A majestic unicorn with a single horn."),
    ("Dinosaur", "A friendly T-Rex shape."),
    ("Mountain", "A jagged, snowy mountain peak."),
    ("Lighthouse", "A tall striped lighthouse on a small rock."),
    ("Mushroom", "A toadstool mushroom with a spotted cap."),
    ("Sailboat", "A small sailboat with a single triangular sail."),
]


def prompt_for(name: str, desc: str) -> str:
    return (
        f"Generate a complete, single-file OpenSCAD script for a {name}. "
        f"The design should be {desc} Use primitive shapes like sphere, cylinder, "
        f"cube, and basic transformations (translate, rotate, scale) to create a "
        f"recognizable, low-poly 3D model. Ensure the code is valid and produces "
        f"a single connected manifold object. Return ONLY the raw SCAD code, "
        f"no explanations."
    )


def used_names_today(date_str: str) -> set:
    """이미 오늘 날짜로 만들어진 모델 디렉터리의 이름 집합."""
    used = set()
    pattern = re.compile(rf"^{re.escape(date_str)}_(.+)$")
    for entry in REPO_ROOT.iterdir():
        if not entry.is_dir():
            continue
        m = pattern.match(entry.name)
        if m:
            used.add(m.group(1).replace("_", " "))
    return used


def main() -> int:
    date_str = datetime.date.today().strftime("%Y-%m-%d")
    taken = used_names_today(date_str)
    candidates = [idea for idea in OBJECT_IDEAS if idea[0] not in taken]

    if not candidates:
        print(json.dumps({"error": "all ideas already used today", "date": date_str}))
        return 1

    name, desc = random.choice(candidates)
    print(json.dumps({
        "date": date_str,
        "name": name,
        "description": desc,
        "model_prompt": prompt_for(name, desc),
        "output_dir": f"{date_str}_{name.replace(' ', '_')}",
    }, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
