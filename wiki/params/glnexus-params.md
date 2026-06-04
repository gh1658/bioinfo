---
title: GLnexus 运行参数记录
type: params
date: 2026-06-04
tags: [glnexus, params, joint-calling]
---
# GLnexus 运行参数记录

## 按染色体并行 (run_glnexus_by_chr.sh)

| 参数 | 值 | 说明 |
|------|-----|------|
| config | DeepVariant_unfiltered | GLnexus 预设配置 |
| threads | 16 (env THREADS) | 每染色体线程数 |
| mem_gb | 120 (env MEM_GB) | 每染色体内存上限 |
| chroms | Chromosome_1~9 | 处理 9 条染色体 |
| 策略 | 逐染色体独立运行 → bcftools concat 合并 | |

路径：`/data1/gh/sy/vcf/run_glnexus_by_chr.sh`

## 快速单次合并 (run_glnexus_fast_one.sh)

| 参数 | 值 | 说明 |
|------|-----|------|
| config | DeepVariant_unfiltered | |
| threads | 48 (env THREADS) | |
| mem_gb | 220 (env MEM_GB) | 更大内存（全基因组一次跑） |
| 输出 | BCF → VCF.gz | |

路径：`/data1/gh/sy/vcf/run_glnexus_fast_one.sh`

## SY-P2 1-10 组 (run_glnexus_SY-P2_1to10.sh)

| 参数 | 值 |
|------|-----|
| threads | 8 (env THREADS) |
| mem_gb | 60 (env MEM_GB) |
| 样本数 | 10 (SY-P2-1~10) |

路径：`/data1/gh/sy/vcf/run_glnexus_SY-P2_1to10.sh`

## 含 70 号的批次 (run_glnexus_by_chr_include70.sh)

| 参数 | 值 |
|------|-----|
| prefix | merge_with_1to10_exclude_13_14_94 |
| threads | 16 |
| mem_gb | 120 |

路径：`/data1/gh/sy/vcf/run_glnexus_by_chr_include70.sh`

## 磁盘空间需求

| 阶段 | 大约空间 |
|------|----------|
| 原始 gVCF × 200 样本 | ~数百 GB |
| 按染色体 BCF (中间) | ~10 GB/染色体 |
| 合并后 VCF.gz | 70-83 GB |
| 过滤后 VCF.gz | 7-72 GB (取决于参数) |
| tmp_glnexus 临时文件 | ~数十 GB |

## 相关笔记
- [[glnexus-joint-calling]] — 完整流程
- [[glnexus]] — GLnexus 工具笔记
- [[filtering-params]] — 过滤参数
