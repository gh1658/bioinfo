---
title: VCF 染色体编号不匹配
type: troubleshooting
date: 2026-06-04
tags: [vcf, troubleshooting, chromosome]
---
# VCF 染色体编号不匹配

## 问题描述

VCF 文件中的染色体命名方式不一致，导致工具报错或结果异常。

## 常见场景

### 1. 参考基因组染色体名不一致
- 有的用 `1, 2, 3...`
- 有的用 `chr1, chr2, chr3...`
- 本项目用的 `Chromosome_1, Chromosome_2...`

### 2. bcftools 合并时染色体名不匹配
bcftools concat 需要各文件的 contig 名称完全一致。

### 3. PLINK/ADMIXTURE 不识别非标准染色体名
使用 `--allow-extra-chr` 参数。

## 解决方案

### 统一染色体命名

```bash
# 重命名染色体（替换 VCF 头）
bcftools annotate --rename-chrs chr_map.txt input.vcf.gz -Oz -o output.vcf.gz
```

### PLINK 处理非标准染色体

```bash
plink --vcf input.vcf.gz \
      --allow-extra-chr \   # 必须加此参数
      --make-bed \
      --out output
```

### 查看当前染色体的 contig 名

```bash
bcftools view -h file.vcf.gz | grep "^##contig"
```

### 染色体名映射表（本项目）

| 文件 | 命名方式 |
|------|----------|
| VCF 文件 | Chromosome_1 ~ Chromosome_9 |
| 脚本中 | Chromosome_1 ~ Chromosome_9 |

## 预防

- 处理前检查 VCF 头的 contig 定义
- 脚本中硬编码染色体列表，确保一致性
- 使用 `--allow-extra-chr` 作为 PLINK 安全参数

## 相关笔记
- [[vcf-filtering]] — VCF 过滤流程
- [[bcftools]] — bcftools 工具笔记
