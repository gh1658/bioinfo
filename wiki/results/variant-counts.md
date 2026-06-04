---
title: 变异位点数量变化追踪
type: result
date: 2026-06-04
tags: [variant-counts, qc, filtering]
---
# 变异位点数量变化追踪

## 各阶段位点数（2026-06-04 实测）

### 不含 1to10 样本组 (191 个样本)

| 过滤阶段 | 位点数 | 文件大小 | 过滤率 |
|----------|--------|----------|--------|
| GLnexus 原始 joint calling | **172,795,734** | 73 GB | — |
| dp3-20.gq5.siteDP4-20.siteGQ10 | ~160M (估) | 61 GB | ~7% |
| + maf0.05.minAllele2.maxMissing0.8 | **11,770,807** | 7.2 GB | 93.2% |
| + maf0.05.minAllele2.maxMissing0.4 | **24,216,624** | 15 GB | 86.0% |

### 含 1to10 样本组 (含 SY-P2-1~10 等)

| 过滤阶段 | 位点数 | 文件大小 | 过滤率 |
|----------|--------|----------|--------|
| GLnexus 原始 joint calling | **194,154,942** | 84 GB | — |
| dp4-20.gq13.siteDP3-20.siteGQ6 | **157,993,400** | 73 GB | 18.6% |

## 位点数变化趋势

```
172,795,734  ← GLnexus raw (不含1to10)
      ↓ dp3-20, gq5, siteDP4-20, siteGQ10
 ~160,000,000  ← 基础过滤
      ↓ maf0.05, minAllele2, maxMissing0.8
 11,770,807  ← 群体遗传学用 (保留 6.8%)
      ↓ maxMissing 更严格 0.4
 24,216,624  ← 注意：maxMissing0.4 比 0.8 位数更多
                 (0.4 要求每个位点更少的缺失样本 = 更多低覆盖位点被保留)
```

> **注意**：maxMissing0.4 位点数 (24M) > maxMissing0.8 (11.7M)，这是因为 maxMissing 是上限值，0.4 的要求比 0.8 更严格（允许更少的缺失），但 MAF 和 minAllele 过滤逻辑导致了非单调变化。

## GLnexus 运行信息

| 指标 | 值 |
|------|-----|
| 运行时间 | 2026-05-15 18:32 ~ 21:52 (~3h20m bulk load) |
| 样本数 | 191 |
| 线程 | 24 |
| 内存 | 150 GB |
| GLnexus 版本 | v1.4.1 |
| 配置 | DeepVariant_unfiltered |
| BCF 记录数 | 22,595,845,860 |
| 染色体 | Chromosome_1 ~ 9 |

## 单样本变异数（DeepVariant 各样本输出）

来源：`single_sample_chr_row_counts.tsv`（206 个样本）

| 统计 | 值 |
|------|-----|
| 样本总数 | 206 |
| 有效样本 | ~190（部分样本为 0） |
| 最高单样本 | ~30.6M |
| 最低有效单样本 | ~11.7M |
| 典型范围 | 12M ~ 28M |

染色体分布（以 Unknown_BR060-001R0001 为例）：
| Chr1 | Chr2 | Chr3 | Chr4 | Chr5 | Chr6 | Chr7 | Chr8 | Chr9 |
|------|------|------|------|------|------|------|------|------|
| 3.17M | 2.97M | 3.10M | 3.12M | 2.85M | 2.88M | 2.78M | 2.58M | 2.55M |

## 各染色体位点数

见 `chr_count_qc/` 和 `chr_count_qc_fai/`
- `sample_qc_summary.tsv` — 样本 QC 汇总（含 total_count, genome_length, z-score）
- `chr_rate_ranked.tsv` — 染色体异常率排名
- `chr_sample_outliers.tsv` — 异常样本标记

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
