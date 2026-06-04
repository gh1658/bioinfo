---
title: PLINK
type: tool
date: 2026-06-04
tags: [plink, format-conversion, ld-pruning]
---
# PLINK

## 概述

全基因组关联分析工具集。在本项目中主要用于格式转换和 LD 剪枝。

## 在本项目中的使用

### 格式转换

```bash
# VCF → PLINK binary
plink --vcf input.vcf.gz \
      --make-bed \
      --out output_prefix \
      --double-id \
      --allow-extra-chr
```

### LD 剪枝

```bash
# 去除连锁位点（用于 ADMIXTURE/PCA）
plink --bfile input_prefix \
      --indep-pairwise 50 10 0.2 \
      --out ld_pruned \
      --allow-extra-chr
```

### 关键参数

| 参数 | 常用值 | 说明 |
|------|--------|------|
| `--vcf` | input.vcf.gz | 输入 VCF |
| `--make-bed` | | 输出 PLINK binary 格式 |
| `--indep-pairwise` | 50 10 0.2 | LD 剪枝参数 |
| `--double-id` | | 双 ID 模式 |
| `--allow-extra-chr` | | 允许非标准染色体名 |

### PLINK binary 文件

| 文件 | 说明 |
|------|------|
| `.bed` | 基因型矩阵 (binary) |
| `.bim` | SNP 信息 |
| `.fam` | 样本信息 |

## 相关笔记
- [[admixture-pca-tree]] — 下游群体结构分析
- [[admixture]] — ADMIXTURE 工具
