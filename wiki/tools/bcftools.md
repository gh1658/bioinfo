---
title: bcftools
type: tool
date: 2026-06-04
tags: [bcftools, vcf, filtering, manipulation]
---
# bcftools

## 概述

samtools 套件中的 VCF/BCF 操作工具。用于查看、过滤、合并、统计 VCF 文件。

## 常用命令

### 查看 VCF

```bash
# 查看 VCF 头
bcftools view -h file.vcf.gz

# 查看前 100 行
bcftools view -h file.vcf.gz | head -100

# 统计位点数
bcftools index --nrecords file.vcf.gz
```

### 过滤

```bash
# 按质量过滤
bcftools view -i 'QUAL>20' input.vcf.gz -Oz -o output.vcf.gz

# 按区域提取
bcftools view -r Chromosome_1 input.vcf.gz -Oz -o chr1.vcf.gz

# 提取特定样本
bcftools view -s SY-P2-1,SY-P2-2 input.vcf.gz -Oz -o subset.vcf.gz

# 复杂过滤（DP + GQ）
bcftools view \
  -i 'FORMAT/DP>=4 && FORMAT/DP<=20 && FORMAT/GQ>=10' \
  input.vcf.gz -Oz -o filtered.vcf.gz
```

### 合并

```bash
# 合并多个 VCF
bcftools concat chr1.vcf.gz chr2.vcf.gz -Oz -o merged.vcf.gz

# 合并后建立索引
bcftools index -t merged.vcf.gz
```

### 统计

```bash
# 基本统计
bcftools stats file.vcf.gz > stats.txt

# 位点数
bcftools index --nrecords file.vcf.gz
```

## 染色体编号

本项目参考基因组染色体命名：
```
Chromosome_1 ~ Chromosome_9
```

## 性能提示

- 始终使用压缩格式 (`.vcf.gz`) 节省空间
- 操作前确保 `.tbi` 索引文件存在
- 大文件过滤时可以按染色体分批处理

## 相关笔记
- [[vcf-filtering]] — VCF 过滤流程
- [[glnexus]] — 上游联合 calling
- [[filtering-params]] — 过滤参数记录
