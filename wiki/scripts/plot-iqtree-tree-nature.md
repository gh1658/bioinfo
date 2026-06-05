---
title: plot-iqtree-tree-nature
type: script
date: 2026-06-05
tags: [iqtree, phylogenetics, visualization, R, sy]
---
# plot-iqtree-tree-nature

## 功能

`/data1/gh/sy/vcf/scripts/plot_iqtree_tree_nature.R` 用于绘制 IQ-TREE 结果，包含 Nature 风格树图和不依赖 ggtree 的圆形 cladogram。

## 使用场景

- IQ-TREE `.treefile` 或 `.contree` 可视化
- 当前 R 环境无法稳定安装 `ggtree` 时的替代圆形树图
- Tajik 公共位点版本树图默认使用该脚本

## Tajik 公共位点版输出

- `admixture_pca_tree_tajik/iqtree_5k_per_chr/tajik_biallelic_snps.5k_per_chr.iqtree.nature_tree.{pdf,png}`
- `admixture_pca_tree_tajik/iqtree_5k_per_chr/tajik_biallelic_snps.5k_per_chr.iqtree.nature_circular_cladogram.bootstrap.{pdf,png}`

## 注意事项

- 该脚本是当前项目的默认圆形树图方案。
- 除非明确需要 ggtree 特有功能，否则不要优先切回 ggtree。

## 相关页面

- [[run-iqtree-5k-per-chr]]
- [[population-structure]]
- [[ggtree-r-version-conflict]]
