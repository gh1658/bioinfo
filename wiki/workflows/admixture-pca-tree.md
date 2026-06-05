---
title: 群体结构分析流程 (ADMIXTURE + PCA + IQ-TREE)
type: workflow
date: 2026-06-04
status: production
tools: [plink, admixture, iqtree, R, python]
project: sy
tags: [population-genetics, admixture, pca, phylogenetics]
---
# 群体结构分析流程 (ADMIXTURE + PCA + IQ-TREE)

## 目的

基于过滤后的高质量 SNP 位点，进行群体遗传学分析：
1. **ADMIXTURE** — 祖源成分分析
2. **PCA** — 主成分分析
3. **IQ-TREE** — 系统发育树构建

## 输入数据

- 过滤后的 VCF（如 `merge_*.filtered.*.maf0.05.minAllele2.maxMissing0.8.vcf.gz`）

### Tajik 公共位点标准版本

后续松叶猪毛菜群体结构解释默认使用带 Tajik 的公共位点版本：

- 输入 VCF：`/data1/gh/sy/vcf/glnexus_merge/P2_with_others_missing70_50_joint/P2_plus_others.P2min7.othermin96.merged.vcf.gz`
- 过滤输出：`/data1/gh/sy/vcf/admixture_pca_tree_tajik/tajik.maf0.05.minAllele2.maxAllele2.vcf.gz`
- 结果目录：`/data1/gh/sy/vcf/admixture_pca_tree_tajik`
- 样本数：201
- 过滤后位点数：1,034,322
- 四亚群解释标准：[[subpopulation-groups-colors]]

过滤参数：

```bash
vcftools \
  --gzvcf input.vcf.gz \
  --maf 0.05 \
  --min-alleles 2 \
  --max-alleles 2 \
  --recode \
  --stdout
```

## 分析步骤

### 1. 位点抽样

由于全基因组 SNP 位点太多，需要抽样：

```bash
# 随机抽样 VCF 位点（用于 ADMIXTURE/PCA）
bash scripts/shuf_vcf_sites.sh

# 每条染色体 5000 位点（用于 IQ-TREE）
bash scripts/run_iqtree_5k_per_chr.sh
```

### 2. VCF → PLINK 格式转换

```bash
plink --vcf input.vcf.gz \
      --make-bed \
      --out plink_input \
      --double-id \
      --allow-extra-chr
```

### 3. LD 剪枝

```bash
plink --bfile plink_input \
      --indep-pairwise 50 10 0.2 \
      --out ld_pruned \
      --allow-extra-chr

plink --bfile plink_input \
      --extract ld_pruned.prune.in \
      --make-bed \
      --out plink_ld_pruned \
      --allow-extra-chr
```

### 4. ADMIXTURE 祖源分析

```bash
# 脚本：scripts/run_admixture_pca_tree.sh
# 或：scripts/run_maxMissing0.8_admixture_pca_tree.sh

for K in {2..10}; do
  for seed in {1..5}; do
    admixture --cv=10 -j16 plink_ld_pruned.bed $K \
      > admixture_runs/K${K}_seed${seed}/run.log
  done
done
```

### 5. 结果可视化

```bash
# R 脚本：scripts/plot_admixture_pca_tree.R
# 绘制：
#   - ADMIXTURE bar plot（每个K值一张）
#   - PCA scatter plot
#   - CV error vs K 图
```

### 6. 系统发育树

```bash
# VCF → PHYLIP（Python 脚本）
python admixture_pca_tree/vcf2phylip.py \
  --input input.vcf.gz

# IQ-TREE 建树
bash scripts/run_iqtree_5k_per_chr.sh

# 可视化
Rscript scripts/plot_iqtree_tree_nature.R
Rscript scripts/plot_iqtree_tree_ggtree_circular.R
```

Tajik 公共位点版本的 IQ-TREE 使用：

- 每条染色体抽样 `5000` 个 SNP，总计 45,000 位点
- `GTR+ASC`
- ultrafast bootstrap `1000`
- `plot_iqtree_tree_nature.R` 的 non-ggtree 圆形 cladogram 作为默认圆形树图

## 参数汇总

| 步骤 | 参数 | 值 |
|------|------|-----|
| 位点抽样 | 每染色体位点数 | 5000 |
| LD 剪枝 | 窗口/步长/r² | 50/10/0.2 |
| ADMIXTURE | K 范围 | 2-10 |
| ADMIXTURE | seeds | 1-5 |
| ADMIXTURE | CV folds | 10 |
| IQ-TREE | bootstrap | 1000 |
| IQ-TREE | 模型 | 标准流程可用 MFP；Tajik 公共位点版使用 GTR+ASC |

## 输出目录结构

```
admixture_pca_tree/
├── admixture_runs/        # ADMIXTURE 结果
│   ├── K2_seed1/          # .Q, .P, .log
│   ├── K2_seed2/
│   └── ... K10_seed5/
├── iqtree_5k_per_chr/     # IQ-TREE 结果
│   ├── biallelic_snps.*.iqtree.log
│   └── biallelic_snps.*.treefile
├── pca.log                # PCA 日志
├── ld_pruned.log          # LD 剪枝日志
└── raw.log                # 原始数据日志
```

## 使用脚本

| 脚本 | 用途 |
|------|------|
| [[run-admixture-pca-tree]] | 完整 ADMIXTURE+PCA+建树流程 |
| [[run-maxMissing08-admixture-pca-tree]] | maxMissing 0.8 版本 |
| [[run-iqtree-5k-per-chr]] | 每条染色体 5k 位点建树 |
| [[plot-admixture-pca-tree]] | ADMIXTURE/PCA 可视化 |
| [[plot-iqtree-tree-nature]] | 树可视化 (Nature 风格) |
| [[plot-iqtree-tree-ggtree-circular]] | 树可视化 (环状) |
| [[vcf2phylip]] | VCF→PHYLIP 转换 |

## 注意事项

- ADMIXTURE 需要 >5 个 seed 确保结果一致性
- PCA 最好用 LD 剪枝后的数据，避免 LD 引起的偏差
- IQ-TREE `-m MFP` 会花时间做模型选择，大数据集可用 `-m GTR+G`
- 结果目录名中的 `maxMissing0.8` 表示使用的过滤参数
- Tajik 公共位点版当前按 201 个样本和四亚群 `TAJ / XJ / GNN / NM` 解释；分组文件见 [[subpopulation-groups-colors]]。
- 当前 R 4.1.2 / Bioconductor 3.14 环境中 `ggtree` 与 `ggplot2` 版本链不兼容，圆形树图优先使用 [[plot-iqtree-tree-nature]] 中的 non-ggtree 实现；详见 [[ggtree-r-version-conflict]]。

## 相关笔记
- [[vcf-filtering]] — 上游过滤
- [[admixture]] — ADMIXTURE 工具笔记
- [[iqtree]] — IQ-TREE 工具笔记
- [[plink]] — PLINK 工具笔记
- [[admixture-params]] — 参数记录
- [[population-structure]] — 结果摘要
- [[ggtree-r-version-conflict]] — ggtree 依赖冲突记录
