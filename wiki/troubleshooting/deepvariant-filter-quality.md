---
title: DeepVariant 过滤质量标记问题
type: troubleshooting
date: 2026-06-04
tags: [deepvariant, troubleshooting, filter]
---
# DeepVariant 过滤质量标记问题

## 问题描述

DeepVariant 输出的 VCF 中，部分位点的 FILTER 列标记为 `RefCall` 而非 `PASS`。

## 原因

`RefCall` 是 DeepVariant gVCF 模式的特点：
- gVCF 包含非变异区域（RefBlock）
- 这些区域的 FILTER 标记为 `RefCall`，而非 `PASS`
- 在 joint calling 时可能引入

## 解决方案

### 过滤 RefCall 位点

```bash
bcftools view -i 'FILTER="PASS" || FILTER="."' input.vcf.gz -Oz -o filtered.vcf.gz
```

### 检查 RefCall 占比

统计 VCF 中各 FILTER 值的数量：
```bash
bcftools query -f '%FILTER\n' input.vcf.gz | sort | uniq -c | sort -rn
```

## 注意

- `RefCall` 不一定是错误，它是 gVCF 的正常输出
- 在 joint calling 后的 VCF 中，RefCall 位点通常是低质量或非变异区
- 下游分析（尤其是群体遗传学）应该过滤掉 RefCall 位点

## 相关笔记
- [[deepvariant]] — DeepVariant 工具笔记
- [[deepvariant-calling]] — DeepVariant 流程
- [[vcf-filtering]] — VCF 过滤流程
