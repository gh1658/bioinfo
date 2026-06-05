---
title: plot-admixture-pca-tree
type: script
date: 2026-06-05
tags: [population-genetics, admixture, pca, visualization, R, sy]
---
# plot-admixture-pca-tree

## 功能

`/data1/gh/sy/vcf/scripts/plot_admixture_pca_tree.R` 用于绘制 ADMIXTURE/PCA 结果图：

- ADMIXTURE K2-K10 祖源成分图
- ADMIXTURE CV error 图
- PCA PC1/PC2 主图
- Tajik 公共位点版四亚群 PCA 主图和局部放大图

## 常用命令

```bash
Rscript scripts/plot_admixture_pca_tree.R \
  --outdir admixture_pca_tree_tajik \
  --sample-map sampleName_clientId.txt
```

## 四亚群 PCA

Tajik 公共位点版默认读取 `/data1/gh/sy/vcf/分组样品/` 下的四亚群文件：

- `TAJ.txt`
- `xj.txt`
- `GNN.txt`
- `NM.txt`

固定配色见 [[subpopulation-groups-colors]]。

输出文件：

- `pca_PC1_PC2_subgroups_nature.{pdf,png}`
- `pca_PC1_PC2_TAJ_zoom_nature.{pdf,png}`
- `pca_PC1_PC2_XJ_zoom_nature.{pdf,png}`
- `pca_PC1_PC2_GNN_zoom_nature.{pdf,png}`
- `pca_PC1_PC2_NM_zoom_nature.{pdf,png}`
- `pca_subgroup_counts.tsv`

## 注意事项

- PCA 样本以当前结果目录中的 `ld_pruned.fam` 为准。
- 分组文件与当前样本集必须取交集，不能把当前 VCF 中不存在的样本画进图。
- 四亚群分组目前按 Tajik 公共位点版 201 样本维护。

## 相关页面

- [[admixture-pca-tree]]
- [[population-structure]]
- [[subpopulation-groups-colors]]
