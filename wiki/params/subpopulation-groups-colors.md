---
title: 松叶猪毛菜四个亚群与固定配色
type: params
date: 2026-06-05
tags: [population-genetics, admixture, pca, visualization, sy]
---
# 松叶猪毛菜四个亚群与固定配色

## 项目背景

本项目为**松叶猪毛菜遗传多样性分析**。

研究对象属于**西北干旱区植物**。后续群体遗传学分析、遗传多样性分析、PCA、ADMIXTURE、系统发育树和其他可视化图，统一按四个亚群展示。

## 后续标准数据版本

后续分析默认使用**带 Tajik 版本**的数据和结果：

- 结果目录：`/data1/gh/sy/vcf/admixture_pca_tree_tajik`
- 过滤后 VCF：`/data1/gh/sy/vcf/admixture_pca_tree_tajik/tajik.maf0.05.minAllele2.maxAllele2.vcf.gz`

## 四个亚群

虽然 Tajik 版本的 ADMIXTURE CV 平均值最低对应 `K=7`，但结合：

- `K=4` 时 CV 曲线斜率变化最大；
- PCA 结果可分为四组；
- 地理来源和样本分组；

后续采用 `K=4` 作为物种内部亚群解释，并将松叶猪毛菜划分为以下四个亚群。

| 亚群代码 | 俗称 | 分组样品文件 | 样本数 | 固定颜色 |
|----------|------|--------------|--------|----------|
| TAJ | 塔吉克 | `/data1/gh/sy/vcf/分组样品/TAJ.txt` | 10 | `#3C5488FF` |
| XJ | 新疆 | `/data1/gh/sy/vcf/分组样品/xj.txt` | 60 | `#E64B35FF` |
| GNN | 甘肃 | `/data1/gh/sy/vcf/分组样品/GNN.txt` | 80 | `#4DBBD5FF` |
| NM | 内蒙 | `/data1/gh/sy/vcf/分组样品/NM.txt` | 55 | `#00A087FF` |

## 固定配色

后续所有图必须使用以下统一配色：

```text
TAJ = #3C5488FF
XJ  = #E64B35FF
GNN = #4DBBD5FF
NM  = #00A087FF
```

这些颜色与带 Tajik 版本 ADMIXTURE `K=4` 的祖源颜色对应：

- `TAJ` 塔吉克：`#3C5488FF`
- `XJ` 新疆：`#E64B35FF`
- `GNN` 甘肃：`#4DBBD5FF`
- `NM` 内蒙：`#00A087FF`

## 绘图规则

后续所有分析图，包括但不限于：

- PCA
- ADMIXTURE
- IQ-TREE 树图
- 遗传多样性统计图
- 群体间比较图
- 地理或生态解释图

均按 `TAJ / XJ / GNN / NM` 四个亚群展示，颜色必须与上表保持一致。

如果脚本中出现旧的群体标签或局部地区标签，应在最终可视化前映射为这四个亚群。

## 相关页面

- [[population-structure]]
- [[admixture-result-folders]]
- [[admixture-params]]
