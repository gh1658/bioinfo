---
title: ggtree 与当前 R 版本链不兼容
type: troubleshooting
date: 2026-06-05
tags: [R, ggplot2, ggtree, iqtree, phylogenetics, troubleshooting, sy]
---
# ggtree 与当前 R 版本链不兼容

## 问题

在 Tajik 公共位点版 IQ-TREE 树图绘制过程中，尝试运行：

```bash
Rscript scripts/plot_iqtree_tree_ggtree_circular.R
```

失败原因是当前环境 `R 4.1.2 / Bioconductor 3.14 / ggplot2` 与 `ggtree 3.2.1` 版本链不兼容。

## 尝试过的处理

- 安装 `yulab.utils 0.1.9`
- 安装 `ggfun 0.1.4`
- 在项目专用 R 库 `/data1/gh/sy/vcf/admixture_pca_tree_tajik/r_libs/R-4.1` 中测试 `ggplot2 3.4.4`、`3.3.6`、`3.4.0`

失败表现：

- 新版 `ggplot2` 缺 `warning_wrap`
- `ggplot2 3.3.6` 有 `warning_wrap` 但缺 `is_ggplot`
- `ggtree 3.2.1` 无法干净安装或加载

## 当前解决方案

使用 `/data1/gh/sy/vcf/scripts/plot_iqtree_tree_nature.R` 中不依赖 ggtree 的圆形 cladogram 实现。

Tajik 公共位点版已成功输出：

- `admixture_pca_tree_tajik/iqtree_5k_per_chr/tajik_biallelic_snps.5k_per_chr.iqtree.nature_tree.png`
- `admixture_pca_tree_tajik/iqtree_5k_per_chr/tajik_biallelic_snps.5k_per_chr.iqtree.nature_circular_cladogram.bootstrap.png`

## 后续规则

后续同类 IQ-TREE 树图任务，除非明确需要 ggtree 特有功能，否则优先使用 [[plot-iqtree-tree-nature]] 的 non-ggtree 圆形树图。

## 相关页面

- [[iqtree]]
- [[plot-iqtree-tree-nature]]
- [[run-iqtree-5k-per-chr]]
