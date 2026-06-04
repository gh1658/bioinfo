---
title: vcf2phylip
script: vcf2phylip.py
path: /data1/gh/sy/vcf/admixture_pca_tree/vcf2phylip.py
language: python
purpose: 将 VCF 文件转换为 PHYLIP 格式，用于 IQ-TREE 系统发育建树
dependencies: []
project: sy
tags: [format-conversion, vcf, phylip, iqtree]
date: 2026-06-04
---
# vcf2phylip.py

## 功能描述

将 VCF 文件中的 SNP 基因型转换为 PHYLIP 序列比对格式，作为 IQ-TREE 的输入。

## 使用方法

```bash
python vcf2phylip.py --input filtered.vcf.gz
```

## 输入 / 输出

- **输入**：VCF 文件（过滤后的 SNP 位点）
- **输出**：PHYLIP 格式序列文件（`.phy`）

## 使用场景

- [[admixture-pca-tree]] — IQ-TREE 建树前的格式转换
- 任何需要从 VCF 生成序列比对用于系统发育分析的场景

## 注意事项

- 仅处理双等位 SNP（biallelic SNPs）
- 输出为 IUPAC 编码的序列
- 缺失基因型编码为 `N`

## 相关笔记
- [[iqtree]] — IQ-TREE 工具笔记
- [[run-iqtree-5k-per-chr]] — 批量建树脚本
- [[admixture-pca-tree]] — 完整流程
