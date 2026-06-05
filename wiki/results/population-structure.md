---
title: 群体结构分析结果
type: result
date: 2026-06-04
tags: [population-genetics, admixture, pca, iqtree, results]
---
# 群体结构分析结果

## 分析概述

对过滤后的高质量 SNP 位点进行群体结构分析，以了解样本间的遗传关系。

## ADMIXTURE 结果

### 运行配置
- K = 2 到 10
- 每个 K 值 5 个 seed 重复
- 交叉验证 (CV=10)
- LD pruning：`50 10 0.2`

### 结果文件
- 位置：`admixture_pca_tree/admixture_runs/`
- Q 文件：每个个体的 K 个祖源成分比例
- P 文件：每个 SNP 的等位基因频率

### CV Error（最佳 K 值判断）
详见 [[admixture-result-folders]] 和 [[admixture-params]]。

| 版本 | 样本数 | raw SNP | LD-pruned SNP | 最低平均 CV 对应 K | 最低平均 CV |
|------|--------|---------|---------------|--------------------|-------------|
| 标准版 | 191 | 23,090,362 | 1,230,099 | K=5 | 0.36306 |
| maxMissing0.8 版 | 191 | 11,203,190 | 586,998 | K=6 | 0.33089 |
| Tajik 公共位点版 | 201 | 1,000,680 | 51,481 | K=7 | 0.36769 |

### 可视化
- ADMIXTURE bar plot：按群体排序的祖源成分图
- 脚本：[[plot-admixture-pca-tree]]

## PCA 结果

### 运行日志
- 路径：`admixture_pca_tree/pca.log`

### 可视化
- PCA scatter plot（前几个 PCs）
- 脚本：[[plot-admixture-pca-tree]]

## 系统发育树

### IQ-TREE 建树
- 每条染色体抽样 5000 个 SNP
- 当前三个结果目录均为 9 条染色体，共 45,000 个抽样位点
- 1000 次超快 bootstrap

### 结果文件
- 树文件：`admixture_pca_tree/iqtree_5k_per_chr/*.treefile`
- 日志：`admixture_pca_tree/iqtree_5k_per_chr/*.iqtree.log`

### 可视化
- Nature 风格树：[[plot-iqtree-tree-nature]]
- 环状树：[[plot-iqtree-tree-ggtree-circular]]

## maxMissing 0.8 版本结果

使用 maxMissing ≤ 0.8 过滤后的单独分析：
- 位置：`admixture_pca_tree_maxMissing0.8/`
- 同样包含 ADMIXTURE/PCA/IQ-TREE 全套分析

## Tajik 公共位点版本结果

使用 P2 与其余样本公共位点 VCF 的单独分析：
- 位置：`admixture_pca_tree_tajik/`
- 输入过滤结果：`tajik.maf0.05.minAllele2.maxAllele2.vcf.gz`
- 过滤后位点数：1,034,322
- 样本数：201
- 同样包含 ADMIXTURE/PCA/IQ-TREE 全套分析
- `ggtree` 圆形树图在当前 R 环境存在版本冲突；已使用 [[plot-iqtree-tree-nature]] 的 non-ggtree 圆形 cladogram 输出。

## 相关笔记
- [[admixture-result-folders]] — 三个结果目录统一汇总
- [[admixture-pca-tree]] — 完整分析流程
- [[admixture-params]] — ADMIXTURE 参数
- [[admixture]] — ADMIXTURE 工具笔记
- [[iqtree]] — IQ-TREE 工具笔记
