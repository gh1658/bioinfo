---
title: IQ-TREE
type: tool
date: 2026-06-04
tags: [iqtree, phylogenetics, maximum-likelihood]
---
# IQ-TREE

## 概述

高效的极大似然法系统发育树构建工具。支持自动模型选择、超快 bootstrap、多种替换模型。

## 在本项目中的使用

### 输入准备

1. VCF → PHYLIP 格式（用 `vcf2phylip.py` 转换）
2. 每条染色体随机抽样 5000 个 SNP

### 运行命令

```bash
# 核心脚本：scripts/run_iqtree_5k_per_chr.sh
iqtree \
  -s input.phy \
  -m MFP \           # ModelFinder Plus: 自动选择最佳模型
  -B 1000 \           # 1000 次超快 bootstrap
  -T AUTO \           # 自动检测线程数
  --prefix output_prefix
```

### 关键参数

| 参数 | 常用值 | 说明 |
|------|--------|------|
| `-s` | input.phy | 输入序列文件 (PHYLIP 格式) |
| `-m` | MFP | ModelFinder Plus — 自动模型选择 |
| `-B` | 1000 | 超快 bootstrap 重复数 |
| `-T` | AUTO | 自动检测最优线程数 |
| `--prefix` | prefix | 输出文件前缀 |

### 输出文件

| 文件 | 说明 |
|------|------|
| `*.treefile` | 最大似然树 (Newick 格式) |
| `*.log` | 运行日志 |
| `*.iqtree` | IQ-TREE 报告 |
| `*.contree` | 一致树 (如有 bootstrap) |
| `*.bionj` | NJ 起始树 |

### 可视化

用 R 脚本绘制：
- `plot_iqtree_tree_nature.R` — Nature 期刊风格
- `plot_iqtree_tree_ggtree_circular.R` — 环状树 (ggtree)

## 性能提示

- `-T AUTO` 自动选择最优线程数
- 大数据集建议先用 `-m TESTONLY` 测试几个模型
- 系统发育树文件可用 FigTree、iTOL 或 ggtree 可视化

## 相关笔记
- [[admixture-pca-tree]] — 完整分析流程
- [[run-iqtree-5k-per-chr]] — 批量建树脚本
- [[plot-iqtree-tree-nature]] — Nature 风格可视化
- [[plot-iqtree-tree-ggtree-circular]] — 环状树可视化
- [[vcf2phylip]] — VCF 转 PHYLIP 格式
