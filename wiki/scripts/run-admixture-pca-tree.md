---
title: run-admixture-pca-tree
script: run_admixture_pca_tree.sh
path: /data1/gh/sy/vcf/scripts/run_admixture_pca_tree.sh
language: bash
purpose: 一键运行 ADMIXTURE + PCA + IQ-TREE 全套群体遗传学分析
dependencies: [plink, admixture, iqtree, python, R]
project: sy
tags: [population-genetics, admixture, pca, iqtree, bash]
date: 2026-06-04
---
# run_admixture_pca_tree.sh

## 功能描述

从过滤后的 VCF 出发，运行完整的群体结构分析流程：
1. VCF → PLINK 格式转换
2. LD 剪枝
3. ADMIXTURE K=2~10（每个 5 个 seed）
4. PCA
5. IQ-TREE 建树
6. R 可视化

## 使用方法

```bash
bash scripts/run_admixture_pca_tree.sh
```

## 参数说明

| 参数 | 默认值 | 说明 |
|------|--------|------|
| K 范围 | 2-10 | ADMIXTURE 祖源群体数 |
| seed | 1-5 | 每个 K 5 次重复 |
| CV | 10 | 交叉验证 fold 数 |
| LD 窗口 | 50 | LD 剪枝窗口大小 |
| LD 步长 | 10 | LD 剪枝步长 |
| LD r² | 0.2 | LD 剪枝 r² 阈值 |

## 输入 / 输出

- **输入**：过滤后的 VCF（含 MAF 和 maxMissing 过滤）
- **输出**：
  - `admixture_pca_tree/admixture_runs/` — ADMIXTURE 结果
  - `admixture_pca_tree/pca.log` — PCA 日志
  - `admixture_pca_tree/` — IQ-TREE 树文件

## 使用场景

- 过滤完成后，进行群体遗传学分析的标准入口
- 对比不同 maxMissing 阈值的结果（有 maxMissing0.8 版本）

## 注意事项

- 依赖 PLINK 转换后的 bed/bim/fam 文件
- IQ-TREE 自动选择模型（MFP），较大数据可能需要数小时
- 不同过滤参数需要分别运行

## 相关笔记
- [[run-maxMissing08-admixture-pca-tree]] — maxMissing0.8 版本
- [[run-filter-maf005-minAllele2]] — 上游过滤
- [[admixture-pca-tree]] — 完整流程说明
- [[plot-admixture-pca-tree]] — 可视化
