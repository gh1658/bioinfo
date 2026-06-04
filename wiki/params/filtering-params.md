---
title: VCF 过滤参数记录
type: params
date: 2026-06-04
tags: [filtering, params, vcf]
---
# VCF 过滤参数记录

## 过滤参数命名约定

文件名即参数记录，格式：
```
merge_{样本组}.by_chr.filtered.{过滤参数}.vcf.gz
```

## 历史过滤组合

### 2026-05-27: 中等过滤 (不含 1to10)
```
merge_without_1to10_exclude_13_14_70_94.by_chr.filtered.dp3-20.gq5.siteDP4-20.siteGQ10
```
| 参数 | 值 | 说明 |
|------|-----|------|
| DP | 3-20 | per-sample 深度 |
| GQ | ≥5 | per-sample 基因型质量 |
| siteDP | 4-20 | per-site 深度 |
| siteGQ | ≥10 | per-site 基因型质量 |
| 输出大小 | ~60 GB | |

### 2026-05-27: + MAF + minAllele + maxMissing 0.4
```
merge_without_1to10_exclude_13_14_70_94.by_chr.filtered.dp3-20.gq5.siteDP4-20.siteGQ10.maf0.05.minAllele2maxmissing0.4
```
| 参数 | 值 | 说明 |
|------|-----|------|
| 基础过滤 | 同上 | |
| MAF | ≥0.05 | 次等位基因频率 |
| minAllele | ≥2 | 最小等位基因数 |
| maxMissing | ≤0.4 | 最大缺失率 |
| 输出大小 | ~15 GB | |

### 2026-06-01: + maxMissing 0.8 (用于群体遗传学)
```
merge_without_1to10_exclude_13_14_70_94.by_chr.filtered.dp3-20.gq5.siteDP4-20.siteGQ10.maf0.05.minAllele2.maxMissing0.8
```
| 参数 | 值 | 说明 |
|------|-----|------|
| maxMissing | ≤0.8 | 较宽松缺失率 |
| 输出大小 | ~7 GB | |

### 2026-06-03: 含 1to10 组 (宽松过滤)
```
merge_with_1to10_exclude_13_14_94.by_chr.filtered.dp4-20.gq13.siteDP3-20.siteGQ6
```
| 参数 | 值 | 说明 |
|------|-----|------|
| DP | 4-20 | |
| GQ | ≥13 | |
| siteDP | 3-20 | |
| siteGQ | ≥6 | |
| 输出大小 | ~72 GB | |

## 参数选择原则

| 分析目的 | 推荐 maxMissing | 推荐 MAF |
|----------|----------------|----------|
| 群体结构 (ADMIXTURE/PCA) | ≤0.8 | ≥0.05 |
| 系统发育树 (IQ-TREE) | ≤0.2 (严格) | ≥0.05 |
| 位点探索/初步 QC | ≤0.4 | 不做 |

## 相关笔记
- [[vcf-filtering]] — 过滤流程
- [[admixture-params]] — ADMIXTURE 参数
- [[glnexus-params]] — GLnexus 参数
