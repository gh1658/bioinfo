---
title: glnexus-dp-gq-cv-hist
script: glnexus_dp_gq_cv_hist.py
path: /data1/gh/sy/vcf/scripts/glnexus_dp_gq_cv_hist.py
language: python
purpose: GLnexus 合并后 VCF 的 DP/GQ/CV 分布统计和可视化，支持随机抽样加速
dependencies: [numpy, argparse, gzip]
project: sy
tags: [qc, python, visualization, dp, gq]
date: 2026-06-04
---
# glnexus_dp_gq_cv_hist.py

## 功能描述

对 GLnexus 联合 calling 后的 VCF 文件进行 DP（深度）和 GQ（基因型质量）分布统计，计算位点 CV（变异系数），支持随机抽样以加速大文件处理。

## 使用方法

```bash
# 统计模式
python glnexus_dp_gq_cv_hist.py stat \
  --input merge.vcf.gz \
  --prefix output_prefix

# 过滤模式
python glnexus_dp_gq_cv_hist.py filter \
  --input merge.vcf.gz \
  --output filtered.vcf.gz \
  --site-minDP 4 --site-maxDP 20 \
  --site-minGQ 10 \
  --sample-minDP 3 --sample-maxDP 20 \
  --sample-minGQ 5 \
  --CV 1.5
```

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| `stat --input` | path | 输入 VCF |
| `stat --prefix` | string | 输出文件名前缀 |
| `filter --input` | path | 输入 VCF |
| `filter --output` | path | 输出过滤后 VCF |
| `--site-minDP` | int | 位点最小深度 |
| `--site-maxDP` | int | 位点最大深度 |
| `--site-minGQ` | int | 位点最小 GQ |
| `--sample-minDP` | int | 样本最小深度 |
| `--sample-maxDP` | int | 样本最大深度 |
| `--sample-minGQ` | int | 样本最小 GQ |
| `--CV` | float | 位点深度变异系数阈值 |

## 输入 / 输出

- **输入**：VCF/BCF 文件（`.vcf`, `.vcf.gz`, `.bcf`）
- **输出**：
  - 统计模式：`{prefix}_DP.txt`, `{prefix}_GQ.txt`, 统计摘要
  - 过滤模式：过滤后的 VCF 文件

## 使用场景

- [[vcf-qc-metrics]] — QC 指标统计
- [[vcf-filtering]] — VCF 过滤
- 每次 GLnexus 合并后的必要 QC 步骤

## 相关笔记
- [[glnexus-merged-metrics]] — 综合指标统计
- [[deepvariant-result-stat]] — DeepVariant 结果统计
- [[plot-vcf-dp-gq-cv-from-user-stats]] — 可视化
