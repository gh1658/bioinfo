---
title: VCF 过滤流程
type: workflow
date: 2026-06-04
status: production
tools: [bcftools, python]
project: sy
tags: [filtering, vcf, qc]
---
# VCF 过滤流程

## 目的

对 GLnexus 联合 calling 后的 VCF 进行多轮过滤，去除不可靠的变异位点，保留高质量位点用于下游分析。

## 过滤层次

### 第一层：基因型级别过滤（per-sample）

对每个样本的基因型进行质量过滤：

| 参数 | 典型值 | 说明 |
|------|--------|------|
| DP | 4-20 / 3-20 | 每个样本的测序深度范围 |
| GQ | ≥10 / ≥5 | 基因型质量阈值 |

### 第二层：位点级别过滤（per-site）

| 参数 | 典型值 | 说明 |
|------|--------|------|
| siteDP | 4-20 / 3-20 | 位点平均深度 |
| siteGQ | 10 / 6 | 位点平均基因型质量 |
| site CV | 控制 | 位点深度变异系数 |

### 第三层：群体级别过滤

| 参数 | 典型值 | 说明 |
|------|--------|------|
| MAF | ≥0.05 | 次等位基因频率 |
| minAllele | ≥2 | 最小等位基因数（AC≥2） |
| maxMissing | ≤0.8 / ≤0.4 | 最大缺失率 |

## 实际使用的过滤组合

### 组合 1：宽松过滤
```
dp4-20.gq13.siteDP3-20.siteGQ6
```
适用于初步探索，保留更多位点。

### 组合 2：中等过滤
```
dp3-20.gq5.siteDP4-20.siteGQ10
```
平衡灵敏度和特异性。

### 组合 3：严格过滤（用于群体遗传学）
```
dp3-20.gq5.siteDP4-20.siteGQ10.maf0.05.minAllele2.maxMissing0.8
```
用于 ADMIXTURE/PCA/系统发育建树。

### 组合 4：极严格过滤
```
dp3-20.gq5.siteDP4-20.siteGQ10.maf0.05.minAllele2.maxMissing0.4
```
极低缺失率，位点数较少。

## 过滤脚本

### bcftools 命令行过滤

在 Shell 脚本中内置 bcftools view 过滤逻辑。

### Python 自定义过滤

| 脚本 | 功能 |
|------|------|
| [[deepvariant-result-stat]] | DP/GQ 统计 + 基于 CV 过滤 |
| [[filter-vcf-maf-min-allele-text]] | MAF + minAllele 文本模式过滤 |
| [[pre-glnexus-local-qc]] | 合并前本地 QC |
| [[count-joint-sites-by-missing-rate]] | 按缺失率统计位点分布 |
| [[extract-joint-sites-by-called-count]] | 按样本检出数提取 |

## 过滤效果追踪

过滤过程中位点数变化：

```
原始 joint VCF (72-83 GB)
    ↓ dp3-20, gq5, siteDP4-20, siteGQ10
过滤后 VCF (~60 GB)
    ↓ maf0.05, minAllele2, maxMissing0.8
群体遗传学用 VCF (~7 GB)
    ↓ maxMissing0.4
极严格 VCF (~15 GB)
```

## 相关脚本文件

- `run_glnexus_by_chr.sh` — 内置 bcftools 过滤
- `filter_without_1to10_core.sh` — 排除 1to10 样本的过滤
- `run_filter_maf0.05_minAllele2.sh` — MAF + minAllele 过滤
- `run_filter_maf0.05_minAllele2_maxMissing0.8.sh` — 加 maxMissing 过滤

## 注意事项

- 过滤参数记录在文件名中（自文档化）
- `.tbi` 索引文件需要与 VCF 同时生成
- 不同过滤组合适用于不同下游分析

## 相关笔记
- [[filtering-params]] — 完整参数记录
- [[glnexus-joint-calling]] — 上游联合 calling
- [[admixture-pca-tree]] — 下游群体分析
- [[vcf-qc-metrics]] — QC 指标
