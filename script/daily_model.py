#!/usr/bin/env python3
"""vibe-foundry daily model idea picker.

Cron(12:00)가 실행: 오늘의 모델 아이디어를 JSON 한 줄로 출력한다.
저장소 전체의 생성 이력(YYYY-MM-DD_<Name>)을 분석하여:
1. 오늘 이미 생성된 이름은 절대 중복 선택하지 않는다.
2. 지금까지 저장소에 한 번도 생성되지 않은 새로운 아이디어를 최우선으로 선택한다.
3. 모든 아이디어가 소진된 경우에만 가장 오래전에 생성된 아이디어(LRU) 중에서 순환 선택한다.

출력 예:
  {"date": "2026-09-17", "name": "Windmill", "description": "...",
   "model_prompt": "Generate a complete, single-file OpenSCAD script ...",
   "output_dir": "2026-09-17_Windmill"}
"""

import argparse
import datetime
import json
import random
import re
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple

REPO_ROOT = Path(__file__).resolve().parent.parent

# 160개 이상의 풍부한 저폴리곤 OpenSCAD 적합 오브젝트 풀
# (기본 프리미티브 sphere, cylinder, cube 및 CSG 연산으로 구현하기 쉬운 사물들)
OBJECT_IDEAS: List[Tuple[str, str]] = [
    # ---- Architecture & Monuments ----
    ("Castle", "A medieval castle with towers and battlements."),
    ("Lighthouse", "A tall striped lighthouse on a small rock."),
    ("Windmill", "A rustic Dutch windmill with four large sails."),
    ("Pagoda", "A multi-tiered Asian pagoda with curved eaves."),
    ("Pyramids", "Ancient desert pyramids with stepped slopes."),
    ("Water Tower", "A classic spherical water tower on metal stilts."),
    ("Suspension Bridge", "A miniature suspension bridge with twin pylons."),
    ("Arch of Triumph", "A classical triumphal arch monument with detailed cornice."),
    ("Torii Gate", "A traditional Japanese Shinto torii gate with dual crossbeams."),
    ("Clock Tower", "A tall standalone clock tower with four clock faces."),
    ("Igloo", "A domed ice igloo with a tunnel entrance."),
    ("Camping Tent", "A triangular A-frame camping tent with guy lines."),
    ("Log Cabin", "A cozy rustic log cabin with a chimney."),
    ("Red Barn", "A classic countryside red barn with a gambrel roof."),
    ("Gazebo", "An octagonal garden gazebo with decorative pillars."),

    # ---- Furniture & Interior ----
    ("Desk Lamp", "An adjustable anglepoise desk lamp with a conical shade."),
    ("Coffee Mug", "A simple, cozy coffee mug with a handle."),
    ("Wooden Chair", "A clean modern dining chair with four tapered legs."),
    ("Dining Table", "A minimalist wooden dining table with a thick tabletop."),
    ("Bookshelf", "A tall bookshelf filled with colorful blocky books."),
    ("Bed", "A neat bed with pillows and a folded blanket."),
    ("Sofa", "A comfortable three-seater couch with armrests."),
    ("Wardrobe", "A classic double-door wooden wardrobe with handles."),
    ("Wall Clock", "A circular wall clock with hour tick marks."),
    ("Stool", "A round three-legged wooden stool."),
    ("Floor Lamp", "A tall modern floor lamp with a drum shade."),
    ("Bathtub", "A vintage clawfoot bathtub."),
    ("Refrigerator", "A tall retro refrigerator with chrome handles."),
    ("Fireplace", "A cozy stone fireplace with burning logs inside."),
    ("Rocking Chair", "A classic wooden rocking chair with curved runners."),

    # ---- Retro & Electronics ----
    ("Retro Computer", "A vintage 1980s beige desktop computer with CRT monitor and keyboard."),
    ("Cassette Tape", "A 1990s audio cassette tape with two winding spools."),
    ("Game Boy", "A classic handheld gaming console with a D-pad and two action buttons."),
    ("Arcade Cabinet", "A classic retro arcade machine with a marquee and joystick."),
    ("Vinyl Player", "A turntable vinyl record player with a tonearm and platter."),
    ("Vintage Radio", "A retro wooden radio with tuning knobs and speaker grill."),
    ("Headphones", "A pair of over-ear studio headphones with padded cushions."),
    ("Floppy Disk", "A 3.5-inch floppy disk with a sliding metal shutter."),
    ("Rotary Telephone", "A vintage rotary dial telephone with a handset cradle."),
    ("Instant Camera", "A retro boxy instant camera with a lens and viewfinder."),
    ("Game Controller", "A console gamepad with thumbsticks and shoulder buttons."),
    ("Vintage Microphone", "A 1950s style chrome broadcast microphone on a stand."),
    ("Quadcopter Drone", "A modern quadcopter drone with four rotors and landing skids."),
    ("Robot", "A cute, small robot with antenna and blocky limbs."),
    ("Television", "A chunky vintage cathode-ray television with antenna bunny ears."),
    ("Walkie Talkie", "A rugged handheld walkie-talkie with an antenna and speaker."),

    # ---- Vehicles & Transportation ----
    ("Spaceship", "A futuristic spaceship with sleek lines."),
    ("Rocket", "A classic retro-style rocket ship."),
    ("Sailboat", "A small sailboat with a single triangular sail."),
    ("Submarine", "A yellow research submarine with a periscope and propeller."),
    ("Helicopter", "A small scout helicopter with main and tail rotors."),
    ("Hot Air Balloon", "A colorful hot air balloon with a woven passenger basket."),
    ("Biplane", "An early 20th-century biplane with dual wings and a front propeller."),
    ("Steam Locomotive", "A vintage steam train engine with a smokestack and cowcatcher."),
    ("Cargo Truck", "A heavy-duty cargo semi-truck with a boxy trailer."),
    ("Classic Car", "A vintage sedan automobile with round headlights and bumpers."),
    ("Scooter", "A cute Italian-style motor scooter with round mirror and seat."),
    ("Bicycle", "A minimalist low-poly bicycle with wheels, frame, and handlebar."),
    ("UFO", "A flying saucer alien craft with a glass cockpit dome."),
    ("Mars Rover", "A planetary exploration rover with six wheels and camera mast."),
    ("Tugboat", "A sturdy harbor tugboat with a smokestack and cabin."),
    ("Hovercraft", "An amphibious hovercraft with a large rear propulsion fan."),

    # ---- Tools & Everyday Gear ----
    ("Hammer", "A claw hammer with a wooden handle and steel head."),
    ("Wrench", "An adjustable crescent wrench with a gripping jaw."),
    ("Screwdriver", "A classic flathead screwdriver with a ribbed handle."),
    ("Anvil", "A heavy blacksmith's anvil on a sturdy pedestal."),
    ("Pickaxe", "A mining pickaxe with a pointed steel pick."),
    ("Shovel", "A spade shovel with a long handle and D-grip."),
    ("Telescope", "An astronomical telescope on a tripod mount."),
    ("Compass", "A brass pocket compass with a directional needle."),
    ("Pocket Knife", "A folded Swiss-style multi-tool pocket knife."),
    ("Lantern", "A rustic kerosene storm lantern with a glass globe."),
    ("Flashlight", "A heavy-duty cylindrical flashlight with a bezel."),
    ("Padlock", "A brass padlock with a curved steel shackle."),
    ("Key", "An antique ornate skeleton key."),
    ("Scissors", "A pair of craft scissors with round finger loops."),
    ("Hourglass", "An antique wooden hourglass with sand trickling through."),
    ("Magnifying Glass", "A handheld magnifying glass with a round brass rim."),
    ("Backpack", "A hiking backpack with side pockets and buckles."),
    ("Umbrella", "A folded umbrella with a curved J-handle."),
    ("Wristwatch", "A classic analog wristwatch with a buckle strap."),
    ("Eyeglasses", "A pair of round frame spectacles with temples."),

    # ---- Fantasy, Magic & Mystery ----
    ("Dragon", "A mythical dragon with wings and a long tail."),
    ("Unicorn", "A majestic unicorn with a single horn."),
    ("Phoenix", "A mythical firebird with flaming wings and crest."),
    ("Stone Golem", "A blocky stone golem composed of rugged boulders."),
    ("Magic Wand", "A wizard wand with a glowing crystal tip."),
    ("Spellbook", "A thick leatherbound grimoire with a metal latch."),
    ("Potion Bottle", "A spherical glass alchemy flask with a cork stopper."),
    ("Treasure Chest", "A wooden pirate treasure chest with an arched lid and brass trim."),
    ("Crystal Ball", "A mystical scrying orb mounted on an ornate three-legged stand."),
    ("Obelisk", "A tall four-sided stone obelisk tapering to a pyramidion top."),
    ("Rune Stone", "A standing megalith slab inscribed with ancient markings."),
    ("Sword", "A medieval knight longsword with a crossguard and pommel."),
    ("Shield", "A medieval kite shield with a central boss."),
    ("Wizard Hat", "A conical wizard hat with a bent peak and wide brim."),
    ("Crown", "A royal golden crown with jewels and velvet lining."),

    # ---- Nature, Plants & Terrain ----
    ("Tree", "A stylized pine tree with a textured trunk."),
    ("Mountain", "A jagged, snowy mountain peak."),
    ("Mushroom", "A toadstool mushroom with a spotted cap."),
    ("Saguaro Cactus", "A desert saguaro cactus with two upturned arms."),
    ("Palm Tree", "A tropical palm tree with a curved trunk and coconut fronds."),
    ("Sunflower", "A bright sunflower with a central seed disc and petals."),
    ("Bonsai Tree", "A potted miniature bonsai tree with a twisted gnarled trunk."),
    ("Volcano", "A volcanic cone mountain with a crater basin at the summit."),
    ("Desert Island", "A tiny sandy desert island with a single palm tree."),
    ("Crystal Cluster", "A cluster of geometric quartz crystal prisms."),
    ("Meteorite", "A pitted, faceted cosmic meteorite chunk."),
    ("Iceberg", "A floating geometric iceberg with visible underwater mass."),
    ("Campfire", "A campfire with stacked logs and flickering flame shapes."),
    ("Bamboo Stalks", "A small cluster of segmented bamboo stalks with shoots."),
    ("Acorn", "An autumn acorn with a textured cross-hatched cap."),

    # ---- Animals & Living Creatures ----
    ("Dog", "A cute, low-poly representation of a dog."),
    ("Cat", "A stylized, low-poly cat silhouette."),
    ("Owl", "A wise-looking owl with large eyes."),
    ("Bird", "A small bird perched on a branch."),
    ("Octopus", "A sea creature with many tentacles."),
    ("Dinosaur", "A friendly T-Rex shape."),
    ("Penguin", "An emperor penguin standing upright with flippers."),
    ("Sea Turtle", "A marine turtle with a patterned carapace and flippers."),
    ("Whale", "A humpback whale surfacing with a tail fluke."),
    ("Duck", "A swimming duck with a flat bill."),
    ("Snail", "A garden snail with a coiled spiral shell."),
    ("Crab", "A seashore crab with two prominent pincers."),
    ("Tree Frog", "A tiny tree frog perched with wide webbed feet."),
    ("Brown Bear", "A bulky low-poly bear standing on all fours."),
    ("Fox", "A cunning fox with pointed ears and a bushy tail."),
    ("Bunny Rabbit", "A cute rabbit sitting with tall ears."),
    ("Elephant", "An elephant with large ears and a curved trunk."),
    ("Giraffe", "A tall giraffe with a long neck and ossicones."),
    ("Great White Shark", "A streamlined shark with a dorsal fin."),
    ("Honeybee", "A striped honeybee with wings and antennae."),
    ("Seahorse", "A seahorse with a coronet and curled tail."),
    ("Koala", "A cute koala clutching a tree branch."),
    ("Flamingo", "A graceful flamingo standing on one slender leg."),
    ("Hedgehog", "A little hedgehog with rounded spines on its back."),

    # ---- Food & Treats ----
    ("Apple", "A crisp round apple with an indentation and a small leaf stem."),
    ("Cheese Wedge", "A Swiss cheese wedge with circular holes."),
    ("Pizza Slice", "A triangular pizza slice with crust and pepperoni rounds."),
    ("Ice Cream Cone", "A waffle cone topped with a spherical ice cream scoop."),
    ("Donut", "A glazed torus donut with scattered sprinkles."),
    ("Cupcake", "A sweet cupcake with swirled frosting and a cherry on top."),
    ("Hamburger", "A stacked burger with buns, patty, cheese, and lettuce."),
    ("Sushi Roll", "A maki sushi roll with rice, nori wrap, and a fish core."),
    ("Coffee Cup", "A disposable takeout coffee cup with a sipping lid and sleeve."),
    ("Birthday Cake", "A two-tiered celebratory cake with a single burning candle."),
    ("Croissant", "A curved crescent pastry with buttery layered ridges."),
    ("Teapot", "A ceramic teapot with a spout, lid knob, and arched handle."),
    ("Wine Glass", "A long-stemmed wine goblet with a flared bowl."),
    ("Popcorn Bucket", "A striped cinema popcorn bucket overflowing with kernels."),
    ("Lollipop", "A spiral swirl candy lollipop on a white stick."),

    # ---- Music & Instruments ----
    ("Acoustic Guitar", "A classic acoustic guitar with a curved body, neck, and sound hole."),
    ("Grand Piano", "A miniature grand piano with an open lid and legs."),
    ("Drum Kit", "A snare drum with drumsticks resting across the rim."),
    ("Saxophone", "A curved jazz saxophone with a flared bell and keys."),
    ("Trumpet", "A brass trumpet with three piston valves and a flared horn."),
    ("Violin", "A classical violin with F-holes and a slender neck."),
    ("Harp", "A triangular concert harp with vertical string pillars."),
    ("Metronome", "A pyramidal wooden metronome with a weighted pendulum arm."),

    # ---- Sports, Toys & Games ----
    ("Rubiks Cube", "A 3x3 twisty puzzle cube with distinct face segments."),
    ("Six Sided Dice", "A pair of gambling dice with recessed pip dots."),
    ("Bowling Pin", "A glossy bowling pin with neck stripes."),
    ("Chess Knight", "A carved chess knight piece shaped like a horse head."),
    ("Chess King", "A regal chess king piece crowned with a small cross."),
    ("Rubber Duck", "A classic bath rubber duck with a bright bill."),
    ("Wind Up Key", "An oversized brass wind-up key for mechanical toys."),
    ("YoYo", "A dual-disc yoyo with a center axle groove."),
    ("Trophy Cup", "A champion victory trophy cup with two side handles on a plinth."),
    ("Spinning Top", "A classic pointed spinning top toy."),
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


def scan_repo_history() -> Dict[str, List[str]]:
    """저장소 내 모든 YYYY-MM-DD_<Name> 디렉터리를 스캔하여 각 모델별 생성 날짜 목록을 반환한다."""
    history: Dict[str, List[str]] = {}
    pattern = re.compile(r"^(\d{4}-\d{2}-\d{2})_(.+)$")

    if not REPO_ROOT.exists():
        return history

    for entry in REPO_ROOT.iterdir():
        if not entry.is_dir():
            continue
        m = pattern.match(entry.name)
        if m:
            date_str, raw_name = m.group(1), m.group(2)
            name = raw_name.replace("_", " ")
            history.setdefault(name, []).append(date_str)

    # 날짜 정렬
    for name in history:
        history[name].sort()

    return history


def pick_next_idea(target_date: str) -> Tuple[str, str]:
    """이력 기반 지능형 아이디어 선택.

    규칙:
    1. 오늘(target_date) 이미 생성된 이름은 절대 제외.
    2. 저장소 전체에서 단 한 번도 생성되지 않은 신규 아이디어가 있다면 그 중에서 랜덤 선택 (최우선).
    3. 모든 아이디어가 1번 이상 사용된 경우, 가장 오래전에 생성된 모델들(LRU) 중에서 랜덤 선택.
    """
    history = scan_repo_history()
    used_today: Set[str] = {
        name for name, dates in history.items() if target_date in dates
    }

    # 오늘 생성된 모델 제외
    valid_ideas = [idea for idea in OBJECT_IDEAS if idea[0] not in used_today]
    if not valid_ideas:
        raise RuntimeError(f"All ideas have already been created on {target_date}")

    # 1단계: 지금까지 한 번도 만들어진 적 없는 아이디어 탐색
    never_used = [idea for idea in valid_ideas if idea[0] not in history]
    if never_used:
        return random.choice(never_used)

    # 2단계: 모든 아이디어가 쓰인 경우, 가장 최근 생성일 기준으로 정렬하여 가장 오래된 풀에서 선택
    # idea별 가장 최근 생성 날짜 (last_used_date)
    def last_used(idea: Tuple[str, str]) -> str:
        dates = history.get(idea[0], [])
        return dates[-1] if dates else "1970-01-01"

    # 오래전에 생성된 순으로 정렬
    sorted_ideas = sorted(valid_ideas, key=last_used)

    # 가장 오래전에 생성된 하위 25% 풀 중에서 랜덤 선택하여 순환
    pool_size = max(1, len(sorted_ideas) // 4)
    lru_pool = sorted_ideas[:pool_size]
    return random.choice(lru_pool)


def print_stats() -> None:
    history = scan_repo_history()
    total_ideas = len(OBJECT_IDEAS)
    used_names = set(history.keys())
    known_names = {idea[0] for idea in OBJECT_IDEAS}

    unused_known = known_names - used_names
    print(f"Total catalog ideas: {total_ideas}")
    print(f"Unique models generated so far: {len(used_names)}")
    print(f"Unused catalog ideas: {len(unused_known)} ({len(unused_known)/total_ideas*100:.1f}%)")
    print("\n--- Most Frequently Generated ---")
    for name, dates in sorted(history.items(), key=lambda x: len(x[1]), reverse=True)[:10]:
        print(f"  {name:20}: {len(dates)} times (Last: {dates[-1]})")


def print_unused() -> None:
    history = scan_repo_history()
    unused = [idea for idea in OBJECT_IDEAS if idea[0] not in history]
    print(f"Unused ideas ({len(unused)} remaining):")
    for name, desc in unused:
        print(f"  - {name}: {desc}")


def main() -> int:
    parser = argparse.ArgumentParser(description="vibe-foundry daily model idea picker.")
    parser.add_argument("--date", help="Target date in YYYY-MM-DD format (default: today)")
    parser.add_argument("--stats", action="store_true", help="Print repository generation statistics")
    parser.add_argument("--list-unused", action="store_true", help="List all unused ideas in catalog")
    parser.add_argument("--dry-run", action="store_true", help="Preview selected idea without committing")

    args = parser.parse_args()

    if args.stats:
        print_stats()
        return 0

    if args.list_unused:
        print_unused()
        return 0

    date_str = args.date or datetime.date.today().strftime("%Y-%m-%d")

    try:
        name, desc = pick_next_idea(date_str)
    except RuntimeError as e:
        print(json.dumps({"error": str(e), "date": date_str}), file=sys.stderr)
        return 1

    result = {
        "date": date_str,
        "name": name,
        "description": desc,
        "model_prompt": prompt_for(name, desc),
        "output_dir": f"{date_str}_{name.replace(' ', '_')}",
    }

    print(json.dumps(result, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
