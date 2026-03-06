#!/bin/bash
# Claude Team - 에이전트 팀 설치 스크립트
# 사용법: ./install.sh [옵션]
#
# 옵션:
#   --global    글로벌 설치 (~/.claude/agents/)
#   --local     로컬 설치 (.claude/agents/) - 현재 프로젝트에만 적용
#   --symlink   복사 대신 심볼릭 링크 생성 (글로벌 전용, 레포 업데이트 자동 반영)
#   --config    OMC 설정도 함께 설치

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENTS_SRC="$SCRIPT_DIR/agents"

# 기본값
MODE="global"
USE_SYMLINK=false
INSTALL_CONFIG=false

# 옵션 파싱
while [[ $# -gt 0 ]]; do
  case $1 in
    --global) MODE="global"; shift ;;
    --local) MODE="local"; shift ;;
    --symlink) USE_SYMLINK=true; shift ;;
    --config) INSTALL_CONFIG=true; shift ;;
    -h|--help)
      echo "사용법: ./install.sh [--global|--local] [--symlink] [--config]"
      echo ""
      echo "옵션:"
      echo "  --global    글로벌 설치 (~/.claude/agents/) [기본값]"
      echo "  --local     로컬 설치 (.claude/agents/)"
      echo "  --symlink   심볼릭 링크로 설치 (레포 업데이트 자동 반영)"
      echo "  --config    OMC 설정도 함께 설치"
      exit 0
      ;;
    *) echo "알 수 없는 옵션: $1"; exit 1 ;;
  esac
done

# 대상 디렉토리 결정
if [ "$MODE" = "global" ]; then
  TARGET_DIR="$HOME/.claude/agents"
else
  TARGET_DIR=".claude/agents"
fi

echo "=== Claude Team 설치 ==="
echo "모드: $MODE"
echo "대상: $TARGET_DIR"
echo "방식: $([ "$USE_SYMLINK" = true ] && echo '심볼릭 링크' || echo '복사')"
echo ""

# 대상 디렉토리 생성
mkdir -p "$TARGET_DIR"

# 에이전트 설치
INSTALLED=0
SKIPPED=0

for agent_file in "$AGENTS_SRC"/*.md; do
  filename=$(basename "$agent_file")
  target="$TARGET_DIR/$filename"

  # 기존 파일 백업
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    backup="${target}.backup.$(date +%Y%m%d)"
    cp "$target" "$backup"
    echo "  백업: $filename → $(basename "$backup")"
  fi

  if [ "$USE_SYMLINK" = true ] && [ "$MODE" = "global" ]; then
    ln -sf "$agent_file" "$target"
  else
    cp "$agent_file" "$target"
  fi

  INSTALLED=$((INSTALLED + 1))
done

echo ""
echo "설치 완료: ${INSTALLED}개 에이전트"

# OMC 설정 설치
if [ "$INSTALL_CONFIG" = true ]; then
  CONFIG_SRC="$SCRIPT_DIR/config/omc-config.json"
  CONFIG_TARGET="$HOME/.claude/.omc-config.json"

  if [ -f "$CONFIG_SRC" ]; then
    if [ -f "$CONFIG_TARGET" ]; then
      cp "$CONFIG_TARGET" "${CONFIG_TARGET}.backup.$(date +%Y%m%d)"
      echo "기존 OMC 설정 백업됨"
    fi
    cp "$CONFIG_SRC" "$CONFIG_TARGET"
    echo "OMC 설정 설치됨"
  fi
fi

echo ""
echo "=== 설치 요약 ==="
echo "에이전트: ${INSTALLED}개 설치됨"
echo "위치: $TARGET_DIR"
echo ""
echo "사용 방법:"
echo "  - 개별 호출: \"frontend 에이전트로 컴포넌트 만들어줘\""
echo "  - 팀 협업:   \"/team 3:executor 태스크 실행\""
echo "  - 전체 목록:  ls $TARGET_DIR"
