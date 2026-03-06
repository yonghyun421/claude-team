#!/bin/bash
# Claude Team - 에이전트 제거 스크립트
# 사용법: ./uninstall.sh [--global|--local]

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/agents"
MODE="${1:---global}"

if [ "$MODE" = "--local" ]; then
  TARGET_DIR=".claude/agents"
else
  TARGET_DIR="$HOME/.claude/agents"
fi

echo "=== Claude Team 제거 ==="
echo "대상: $TARGET_DIR"
echo ""

REMOVED=0

for agent_file in "$AGENTS_SRC"/*.md; do
  filename=$(basename "$agent_file")
  target="$TARGET_DIR/$filename"

  if [ -f "$target" ] || [ -L "$target" ]; then
    rm -f "$target"
    echo "  제거: $filename"
    REMOVED=$((REMOVED + 1))
  fi
done

echo ""
echo "제거 완료: ${REMOVED}개 에이전트"
