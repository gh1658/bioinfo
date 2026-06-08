# CLAUDE.md — 生信分析知识库规则

## 知识库概述

这是一个生信分析知识库，采用 Karpathy LLM Wiki 模式。知识库由 Claude Code 维护，用户通过 Obsidian 浏览。所有文件为纯 Markdown，用 Git 做版本控制。

## 目录结构

```
/data1/gh/bioinfo-kb/
├── CLAUDE.md           # 本文件——规则与约定
├── index.md            # 内容目录（每次操作后自动更新）
├── log.md              # 操作日志（追加写入）
├── raw/                # 原始材料，只读，不可修改
│   ├── scripts/        # 脚本副本/软链接
│   ├── logs/           # 运行日志副本
│   └── results/        # 关键结果文件
├── wiki/               # LLM 维护的知识页面
│   ├── workflows/      # 分析流程
│   ├── scripts/        # 脚本说明
│   ├── params/         # 参数记录
│   ├── results/        # 结果总结
│   ├── tools/          # 工具使用笔记
│   └── troubleshooting/# 踩坑/问题记录
└── templates/          # Obsidian 模板
```

## 页面命名规范

- 使用英文小写 + 连字符：`glnexus-joint-calling.md`
- 流程页：`workflows/<流程名>.md`
- 脚本页：`scripts/<脚本名>.md`
- 参数页：`params/<主题>-params.md`
- 工具页：`tools/<工具名>.md`
- 问题页：`troubleshooting/<问题描述>.md`

## Frontmatter 规范

每个 wiki 页面必须包含以下 YAML frontmatter：

```yaml
---
title: <页面标题>
type: workflow | script | params | result | tool | troubleshooting
date: YYYY-MM-DD
tags: [tag1, tag2]
---
```

## 标签体系

### 分析类型
- `variant-calling` — 变异检测（DeepVariant 等）
- `joint-calling` — 联合 calling（GLnexus 等）
- `filtering` — VCF 过滤
- `qc` — 质量控制
- `population-genetics` — 群体遗传学（ADMIXTURE, PCA）
- `phylogenetics` — 系统发育（IQ-TREE）

### 工具
- `deepvariant` `glnexus` `bcftools` `admixture` `plink` `iqtree` `vcftools`

### 状态
- `draft` — 草稿
- `tested` — 已测试
- `production` — 生产使用

### 项目
- `sy` — SY 项目

## 更新策略

### Codex 任务记录规则

在 `/data1/gh 项目中，每完成一项分析、任务或流程后，都要把以下信息写入知识库：
- 所用脚本及路径
- 确定使用的参数和版本
- 运行中遇到的主要问题及解决方法
- 关键输出路径和结果摘要

优先用 `ingest.sh` 写入收件箱；当用户要求“整理知识库”或“处理收件箱”时，再整理为正式 wiki 页面。

### Ingest（摄入新内容）
1. 读取原始材料（脚本、日志）
2. 理解做了什么
3. 创建新的 wiki 页面或更新已有页面
4. 更新 `index.md` 中的条目
5. 在 `log.md` 末尾追加操作记录

### Query（查询）
1. 先读 `index.md` 定位相关页面
2. 读取相关页面
3. 给出答案并附上原始文件路径

### Lint（健康检查）
扫描检查：
- 孤页（无入链的页面）→ 添加链接或标记为 orphan
- 断链（指向不存在页面的链接）
- 矛盾信息（同一参数在不同页面记录不一致）
- 过时信息（结果路径已失效）

## 项目源目录

生信分析项目位于 `/data1/gh/sy/vcf`，其结构：
- `scripts/` — Python 和 Shell 脚本
- `glnexus_merge/` — GLnexus 合并结果和中间文件
- `reports/` — 统计报告
- `logs_reseq/` — DeepVariant 重测序日志
- `admixture_pca_tree/` — 群体结构分析结果
- `tools/` — 第三方工具（IQ-TREE 等）

## 收件箱机制（Codex 等其他工具集成）

其他工具（如 Codex）可以通过 `ingest.sh` 脚本写入知识库收件箱：

```bash
# 从 Codex 或其他工具写入
echo "分析内容..." | bash /data1/gh/bioinfo-kb/ingest.sh

# 摄入脚本
bash /data1/gh/bioinfo-kb/ingest.sh -s /path/to/script.sh

# 摄入消息
bash /data1/gh/bioinfo-kb/ingest.sh -m "跑了 XXX 分析，参数是..."
```

`ingest.sh` 会将内容写入 `inbox/` 目录并自动 git commit。

### 处理收件箱

当用户说 **"整理知识库"** 或 **"处理收件箱"** 时：
1. 读取 `inbox/` 下所有 `.md` 文件
2. 将每条记录整理成正式的 wiki 页面
3. 更新 `index.md`
4. 将已处理的 inbox 文件移到 `inbox/archive/`
5. Git commit

## 注意事项

- 不要修改 `raw/` 目录下的文件，它们是原始材料的副本
- 每次 ingest 后运行 `git add -A && git commit` 保存变更
- 双向链接用 Obsidian 语法 `[[页面名]]`
- 参数记录要包含日期和版本，因为参数会随时间迭代
- `ingest.sh` 可供任何工具调用，不限于 Claude Code
