---
title: run-glnexus-by-chr
script: run_glnexus_by_chr.sh
path: /data1/gh/sy/vcf/run_glnexus_by_chr.sh
language: bash
purpose: GLnexus 按染色体并行 joint calling，逐染色体运行后 bcftools concat 合并
dependencies: [glnexus_cli, bcftools, awk]
project: sy
tags: [glnexus, joint-calling, bash]
date: 2026-06-04
---
# run_glnexus_by_chr.sh

## 功能描述

将 gVCF 列表按染色体拆分，每条染色体独立运行 GLnexus joint calling，最后用 bcftools concat 合并为完整 VCF。核心策略是"分而治之"以降低内存需求。

## 使用方法

```bash
# 默认参数
bash run_glnexus_by_chr.sh

# 自定义线程和内存
THREADS=32 MEM_GB=200 bash run_glnexus_by_chr.sh
```

## 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| THREADS | env | 16 | GLnexus 并行线程数 |
| MEM_GB | env | 120 | GLnexus 内存上限 (GB) |
| prefix | hardcoded | merge_without_1to10_exclude_13_14_70_94 | 数据集名称 |
| chroms | hardcoded | Chromosome_1~9 | 染色体列表 |

## 输入 / 输出

- **输入**：gVCF 列表文件 `glnexus_merge/sample_lists/${prefix}.gvcf.list`
- **输出**：
  - 每染色体 VCF：`glnexus_merge/by_chr/${prefix}/${chr}.vcf.gz`
  - 最终合并：`glnexus_merge/${prefix}.by_chr.vcf.gz`
  - 日志：`glnexus_merge/by_chr/${prefix}/${chr}.log`

## 内部流程

1. 创建输出和临时目录
2. 读取 gVCF 列表，取第一个 gVCF 提取 contig 长度 → 生成 BED
3. 每个染色体：
   - 清理旧输出
   - `glnexus_cli --config DeepVariant_unfiltered --bed chr.bed` → BCF
   - `bcftools view` BCF → VCF.gz + index
4. `bcftools concat` 所有染色体 → 最终 VCF + index

## 使用场景

- [[glnexus-joint-calling]] 的核心执行脚本
- 每次 GLnexus 合并都从修改此脚本的 prefix/list 开始

## 注意事项

- 脚本内路径均为硬编码，换数据集需修改 prefix/list/chroms
- 每条染色体有独立 tmp 目录（时间戳+PID 防冲突）
- 使用 `set -euo pipefail` 严格错误处理

## 相关笔记
- [[run-glnexus-by-chr-include70]] — 含 70 号样本版本
- [[run-glnexus-fast-one]] — 快速单次版本
- [[glnexus-joint-calling]] — 完整流程
- [[glnexus]] — GLnexus 工具笔记
