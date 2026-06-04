---
title: ADMIXTURE 运行参数记录
type: params
date: 2026-06-04
tags: [admixture, params, population-genetics]
---
# ADMIXTURE 运行参数记录

## 当前配置

| 参数 | 值 | 说明 |
|------|-----|------|
| K 范围 | 2-10 | 假定祖源群体数 |
| seed | 1-5 | 每个 K 值 5 次重复 |
| CV folds | 10 | 10-fold 交叉验证 |
| 线程 | 16 (-j16) | |
| LD 剪枝 | 50 10 0.2 | 窗口/步长/r² |
| 输入位点 | ~45000 (5k × 9 chr) | LD 剪枝后随机抽样 |

## 结果目录

```
admixture_pca_tree/admixture_runs/
├── K2_seed{1..5}/
├── K3_seed{1..5}/
├── ...
└── K10_seed{1..5}/
```

每个目录包含：
- `*.Q` — 祖源成分矩阵
- `*.P` — 等位基因频率矩阵
- `run.log` — 运行日志（含 CV error）

## CV Error 记录

| K | CV Error (范围) |
|---|-----------------|
| 2 | (待补充) |
| 3 | (待补充) |
| 4 | (待补充) |
| 5 | (待补充) |
| 6 | (待补充) |
| 7 | (待补充) |
| 8 | (待补充) |
| 9 | (待补充) |
| 10 | (待补充) |

## 运行脚本

- `scripts/run_admixture_pca_tree.sh` — 基础流程
- `scripts/run_maxMissing0.8_admixture_pca_tree.sh` — maxMissing 0.8 版本

## 相关笔记
- [[admixture-pca-tree]] — 完整分析流程
- [[admixture]] — ADMIXTURE 工具笔记
- [[filtering-params]] — 输入数据过滤参数
- [[population-structure]] — 结果摘要
