#!/usr/bin/env bash
# ~/bioinfo-kb/ingest.sh — 通用知识库摄入脚本
# 用法：
#   echo "..." | bash ingest.sh                    # 标准输入
#   bash ingest.sh -f /path/to/note.md             # 从文件
#   bash ingest.sh -m "跑了XXX分析"                 # 直接消息
#   bash ingest.sh -s /path/to/script.sh           # 摄入脚本
set -euo pipefail

KB_DIR="$(cd "$(dirname "$0")" && pwd)"
INBOX_DIR="$KB_DIR/inbox"
LOG_FILE="$KB_DIR/log.md"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
DATE_STAMP="$(date '+%Y%m%d-%H%M%S')"

mkdir -p "$INBOX_DIR"

# 解析参数
MODE="stdin"
INPUT=""
while getopts "f:m:s:h" opt; do
  case $opt in
    f) MODE="file"; INPUT="$OPTARG" ;;
    m) MODE="message"; INPUT="$OPTARG" ;;
    s) MODE="script"; INPUT="$OPTARG" ;;
    h) echo "用法: ingest.sh [-f file] [-m message] [-s script] 或管道输入"; exit 0 ;;
  esac
done

case $MODE in
  stdin)
    CONTENT=$(cat)
    ;;
  file)
    CONTENT=$(cat "$INPUT")
    ;;
  message)
    CONTENT="$INPUT"
    ;;
  script)
    SCRIPT_PATH="$INPUT"
    SCRIPT_NAME=$(basename "$SCRIPT_PATH")
    CONTENT=$(cat <<EOF
## 脚本摄入: $SCRIPT_NAME

- **路径**: $SCRIPT_PATH
- **时间**: $TIMESTAMP

\`\`\`bash
$(head -50 "$SCRIPT_PATH" 2>/dev/null || echo "# 无法读取脚本内容")
\`\`\`

*完整脚本见: $SCRIPT_PATH*
EOF
)
    ;;
esac

# 写入收件箱
INBOX_FILE="$INBOX_DIR/${DATE_STAMP}.md"
cat > "$INBOX_FILE" <<KBEOF
---
date: $TIMESTAMP
source: ${MODE}
---
$CONTENT
KBEOF

# 追加到日志
cat >> "$LOG_FILE" <<LOGEOF

## [$TIMESTAMP] 自动摄入 ($MODE)

- 文件: \`$INBOX_FILE\`
- 内容预览: $(echo "$CONTENT" | head -3 | tr '\n' ' ')

LOGEOF

# Git 提交（如果在 git 仓库中）
if git -C "$KB_DIR" rev-parse --git-dir >/dev/null 2>&1; then
  git -C "$KB_DIR" add -A >/dev/null 2>&1 || true
  git -C "$KB_DIR" commit -m "auto: ingest $MODE @ $TIMESTAMP" >/dev/null 2>&1 || true
fi

echo "✅ 已摄入到: $INBOX_FILE"
echo "📂 收件箱: $INBOX_DIR (待 Claude Code 整理成 wiki 页面)"
