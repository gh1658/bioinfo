---
title: run-iqtree-5k-per-chr
type: script
date: 2026-06-05
tags: [iqtree, phylogenetics, vcf, bash, sy]
---
# run-iqtree-5k-per-chr

## 功能

`/data1/gh/sy/vcf/scripts/run_iqtree_5k_per_chr.sh` 用于从 VCF 中按染色体抽样位点，并运行 IQ-TREE 构建系统发育树。

## Tajik 公共位点版参数

- 输入 VCF：`/data1/gh/sy/vcf/admixture_pca_tree_tajik/biallelic_snps.renamed.vcf.gz`
- 输出目录：`/data1/gh/sy/vcf/admixture_pca_tree_tajik/iqtree_5k_per_chr`
- VCF2PHYLIP：`/data1/gh/sy/vcf/admixture_pca_tree/vcf2phylip.py`
- IQ-TREE：`/data1/gh/sy/vcf/tools/bin/iqtree3`
- 每条染色体抽样位点数：5000
- 线程：`AUTO`
- bootstrap：1000
- prefix：`tajik_biallelic_snps.5k_per_chr`
- 模型：`GTR+ASC`

## 输出

- `*.treefile`
- `*.contree`
- `*.iqtree`
- `*.log`
- `*.nature_tree.{pdf,png}`
- `*.nature_circular_cladogram.bootstrap.{pdf,png}`

## 注意事项

- 当前结果为 9 条染色体各抽样 5000 位点，总计 45,000 位点。
- Tajik 版 IQ-TREE 日志中出现 all 201 sequences failed composition chi2 test，是组成偏差警告；本次树文件已正常生成。
- 圆形树图优先使用 [[plot-iqtree-tree-nature]] 的 non-ggtree 实现。

## 相关页面

- [[admixture-pca-tree]]
- [[population-structure]]
- [[iqtree]]
- [[ggtree-r-version-conflict]]
