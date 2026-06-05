---
title: 三个 ADMIXTURE/PCA/IQ-TREE 结果目录汇总
type: result
date: 2026-06-05
tags: [population-genetics, admixture, pca, iqtree, results, sy]
---
# 三个 ADMIXTURE/PCA/IQ-TREE 结果目录汇总

## 目录概览

| 版本 | 结果目录 | 样本数 | raw SNP | LD-pruned SNP | ADMIXTURE Q 文件 | IQ-TREE 抽点 |
|------|----------|--------|---------|---------------|------------------|--------------|
| 标准版 | `/data1/gh/sy/vcf/admixture_pca_tree` | 191 | 23,090,362 | 1,230,099 | 45 | 45,000 |
| maxMissing0.8 版 | `/data1/gh/sy/vcf/admixture_pca_tree_maxMissing0.8` | 191 | 11,203,190 | 586,998 | 45 | 45,000 |
| Tajik 公共位点版 | `/data1/gh/sy/vcf/admixture_pca_tree_tajik` | 201 | 1,000,680 | 51,481 | 45 | 45,000 |

三个版本均使用相同的群体结构主流程：

- PLINK 转换时保留 `--vcf-half-call missing`
- LD pruning：`--indep-pairwise 50 10 0.2`
- ADMIXTURE：`K=2..10`，每个 K `seed=1..5`，`--cv=10`
- 每个 K 选择 `cv_summary.tsv` 中 CV error 最小的 Q 文件，即 `selected=TRUE`
- IQ-TREE：每条染色体抽 `5000` 位点，共 9 条染色体 `45,000` 位点

## CV Error 对比

### 标准版

| K | 平均 CV | selected seed | selected CV |
|---|---------|---------------|-------------|
| 2 | 0.48216 | 5 | 0.48203 |
| 3 | 0.36554 | 2 | 0.36538 |
| 4 | 0.36353 | 1 | 0.36023 |
| 5 | 0.36306 | 1 | 0.35895 |
| 6 | 0.36399 | 2 | 0.36149 |
| 7 | 0.37012 | 3 | 0.36562 |
| 8 | 0.37843 | 4 | 0.37341 |
| 9 | 0.38839 | 5 | 0.38357 |
| 10 | 0.39702 | 1 | 0.39496 |

最低平均 CV：`K=5`，平均 CV `0.36306`。

### maxMissing0.8 版

| K | 平均 CV | selected seed | selected CV |
|---|---------|---------------|-------------|
| 2 | 0.46467 | 3 | 0.46450 |
| 3 | 0.34834 | 2 | 0.34821 |
| 4 | 0.33483 | 3 | 0.33472 |
| 5 | 0.33458 | 3 | 0.32990 |
| 6 | 0.33089 | 3 | 0.32663 |
| 7 | 0.33415 | 4 | 0.32768 |
| 8 | 0.33199 | 4 | 0.33024 |
| 9 | 0.33838 | 1 | 0.33656 |
| 10 | 0.34322 | 2 | 0.33902 |

最低平均 CV：`K=6`，平均 CV `0.33089`。

### Tajik 公共位点版

| K | 平均 CV | selected seed | selected CV |
|---|---------|---------------|-------------|
| 2 | 0.60854 | 1 | 0.59349 |
| 3 | 0.45078 | 3 | 0.45064 |
| 4 | 0.38411 | 3 | 0.38398 |
| 5 | 0.37319 | 4 | 0.37112 |
| 6 | 0.37518 | 2 | 0.36766 |
| 7 | 0.36769 | 3 | 0.36439 |
| 8 | 0.37249 | 4 | 0.36501 |
| 9 | 0.37279 | 4 | 0.36863 |
| 10 | 0.37695 | 5 | 0.37393 |

最低平均 CV：`K=7`，平均 CV `0.36769`。

## 标准版结果文件

目录：`/data1/gh/sy/vcf/admixture_pca_tree`

关键文件：

- `cv_summary.tsv`
- `raw.{bed,bim,fam}`
- `ld_pruned.{bed,bim,fam}`
- `pca.eigenvec`
- `pca.eigenval`
- `admixture_runs/K*_seed*/K*.seed*.Q`
- `admixture_K2_K10_nature.png`
- `admixture_K2_K10_nature_clustered.png`
- `admixture_K2_K10_nature_sample_order.png`
- `admixture_cv_nature.png`
- `pca_PC1_PC2_nature.png`
- `iqtree_5k_per_chr/biallelic_snps.5k_per_chr.iqtree.treefile`
- `iqtree_5k_per_chr/biallelic_snps.5k_per_chr.iqtree.nature_tree.png`
- `iqtree_5k_per_chr/biallelic_snps.5k_per_chr.iqtree.ggtree_circular.bootstrap.png`

## maxMissing0.8 版结果文件

目录：`/data1/gh/sy/vcf/admixture_pca_tree_maxMissing0.8`

关键文件：

- `cv_summary.tsv`
- `raw.{bed,bim,fam}`
- `ld_pruned.{bed,bim,fam}`
- `pca.eigenvec`
- `pca.eigenval`
- `admixture_runs/K*_seed*/K*.seed*.Q`
- `admixture_K2_K10_nature.png`
- `admixture_K2_K10_nature_clustered.png`
- `admixture_K2_K10_nature_sample_order.png`
- `admixture_cv_nature.png`
- `pca_PC1_PC2_nature.png`
- `iqtree_5k_per_chr/biallelic_snps.maxMissing0.8.5k_per_chr.iqtree.treefile`
- `iqtree_5k_per_chr/biallelic_snps.maxMissing0.8.5k_per_chr.iqtree.nature_tree.png`
- `iqtree_5k_per_chr/biallelic_snps.maxMissing0.8.5k_per_chr.iqtree.nature_circular_cladogram.bootstrap.png`

## Tajik 公共位点版结果文件

目录：`/data1/gh/sy/vcf/admixture_pca_tree_tajik`

输入过滤结果：

- `tajik.maf0.05.minAllele2.maxAllele2.vcf.gz`
- `tajik.maf0.05.minAllele2.maxAllele2.vcf.gz.tbi`

关键文件：

- `cv_summary.tsv`
- `raw.{bed,bim,fam}`
- `ld_pruned.{bed,bim,fam}`
- `pca.eigenvec`
- `pca.eigenval`
- `admixture_runs/K*_seed*/K*.seed*.Q`
- `admixture_K2_K10_nature.png`
- `admixture_K2_K10_nature_clustered.png`
- `admixture_K2_K10_nature_sample_order.png`
- `admixture_cv_nature.png`
- `pca_PC1_PC2_nature.png`
- `pca_PC1_PC2_subgroups_nature.png`
- `pca_PC1_PC2_TAJ_zoom_nature.png`
- `pca_PC1_PC2_XJ_zoom_nature.png`
- `pca_PC1_PC2_GNN_zoom_nature.png`
- `pca_PC1_PC2_NM_zoom_nature.png`
- `pca_subgroup_counts.tsv`
- `iqtree_5k_per_chr/tajik_biallelic_snps.5k_per_chr.iqtree.treefile`
- `iqtree_5k_per_chr/tajik_biallelic_snps.5k_per_chr.iqtree.nature_tree.png`
- `iqtree_5k_per_chr/tajik_biallelic_snps.5k_per_chr.iqtree.nature_circular_cladogram.bootstrap.png`

## 注意事项

- 标准版曾成功生成 `ggtree_circular.bootstrap.png`。
- maxMissing0.8 版和 Tajik 版使用 `plot_iqtree_tree_nature.R` 中不依赖 ggtree 的圆形 cladogram 输出。
- Tajik 版中尝试安装 `ggtree` 时发现当前 `R 4.1.2 / Bioconductor 3.14 / ggplot2` 版本链不兼容，后续同类任务除非明确需要 ggtree，否则优先使用 non-ggtree 圆形树图；详见 [[ggtree-r-version-conflict]]。

## 相关页面

- [[population-structure]]
- [[admixture-pca-tree]]
- [[admixture-params]]
- [[run-admixture-pca-tree]]
- [[run-iqtree-5k-per-chr]]
- [[plot-iqtree-tree-nature]]
- [[ggtree-r-version-conflict]]
