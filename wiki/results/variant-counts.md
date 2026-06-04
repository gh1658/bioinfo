---
title: 变异位点数量变化追踪
type: result
date: 2026-06-04
tags: [variant-counts, qc, filtering]
---
# 变异位点数量变化追踪

## 各阶段位点数

| 阶段 | 样本组 | 位点数 | 文件大小 |
|------|--------|--------|----------|
| GLnexus joint calling | without 1to10 | (待填充) | ~72 GB |
| GLnexus joint calling | with 1to10 | (待填充) | ~83 GB |
| dp3-20.gq5.siteDP4-20.siteGQ10 | without 1to10 | (待填充) | ~60 GB |
| + maf0.05.minAllele2.maxMissing0.8 | without 1to10 | (待填充) | ~7 GB |
| + maf0.05.minAllele2.maxMissing0.4 | without 1to10 | (待填充) | ~15 GB |
| dp4-20.gq13.siteDP3-20.siteGQ6 | with 1to10 | (待填充) | ~72 GB |

## 单样本变异数

每个样本每条染色体的变异位点数：
- 统计脚本：`count_single_sample_chr_rows.sh`
- 结果文件：`single_sample_chr_row_counts.tsv`
- 分析脚本：`analyze_chr_row_counts.sh`

## 各染色体位点数

见 `chr_count_qc/` 和 `chr_count_qc_fai/`
- `chr_lengths.from_vcf_header.fai` — 染色体长度
- `sample_qc_summary.tsv` — 样本 QC 汇总

## 统计脚本

| 脚本 | 功能 |
|------|------|
| [[count-single-sample-chr-rows]] | 按染色体统计位点数 |
| [[analyze-chr-row-counts]] | 分析位点分布 |
| [[count-joint-sites-by-missing-rate]] | 按缺失率统计 |
| [[count-joint-called-sites-between-vcfs]] | VCF 间交集统计 |
| [[count-p2-joint-call-sites]] | P2 样本位点统计 |
| [[extract-joint-sites-by-called-count]] | 按检出数提取 |

## 相关笔记
- [[vcf-filtering]] — 过滤流程
- [[filtering-params]] — 过滤参数
- [[qc-metrics]] — QC 指标
