---
title: ADMIXTURE
type: tool
date: 2026-06-04
tags: [admixture, population-genetics, ancestry]
---
# ADMIXTURE

## 概述

群体遗传学工具，用于估计个体的祖源成分比例。基于最大似然估计，将每个个体的基因组分解为 K 个假定祖源群体的混合。

## 在本项目中的使用

### 输入准备

1. VCF → PLINK bed/bim/fam（用 PLINK 转换）
2. LD 剪枝（去除连锁位点）
3. 随机抽样（如每条染色体取 5k 位点，共 ~45k 位点）

### 运行参数

```bash
# ADMIXTURE 运行
admixture \
  --cv=10 \
  -j16 \
  input.bed \
  <K> \
  > admixture_k<K>.log
```

### K 值范围

本项目运行了 K=2 到 K=10：
```
K2, K3, K4, K5, K6, K7, K8, K9, K10
```
每个 K 值 5 个 seed 重复（seed=1~5），确保结果稳定。

目录结构：
```
admixture_pca_tree/admixture_runs/
├── K2_seed1/
├── K2_seed2/
├── ...
└── K10_seed5/
```

### 关键参数

| 参数 | 值 | 说明 |
|------|-----|------|
| `--cv` | 10 | 10-fold 交叉验证 |
| `-j` | 16 | 线程数 |
| K 范围 | 2-10 | 假定祖源群体数 |
| seed | 1-5 | 每个 K 5 个重复 |

### 输出文件

| 文件 | 说明 |
|------|------|
| `*.Q` | 每个个体的祖源成分比例矩阵 |
| `*.P` | 每个 SNP 的等位基因频率 |
| `*.log` | 运行日志，含 CV error |

### 选择最佳 K 值

通常选择 CV error 最低或达到平台的 K 值。

## 相关笔记
- [[admixture-pca-tree]] — 完整群体结构分析流程
- [[admixture-params]] — 参数记录
- [[plot-admixture-pca-tree]] — 可视化 R 脚本
- [[iqtree]] — 系统发育建树
