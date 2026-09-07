#!/usr/bin/env bash
# vibe-foundry 자동 push (cron 13:00)
# 남은 변경분이 있으면 커밋한 뒤 main을 push한다. push할 게 없으면 조용히 종료.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO"

if ! git diff --quiet || ! git status --porcelain --untracked-files=all | grep -q '^$'; then
    git add -A
    if ! git diff --cached --quiet; then
        git commit -m "Daily sync $(date +%F)"
    fi
fi

# 로컬이 원격보다 앞서 있으면 push
behind_ahead=$(git rev-list --left-right --count origin/main...HEAD 2>/dev/null || echo "0 1")
ahead=$(echo "$behind_ahead" | awk '{print $2}')

if [ "${ahead:-0}" -gt 0 ]; then
    git push origin main
    echo "vibe-foundry: pushed ${ahead} commit(s) to origin/main"
fi
