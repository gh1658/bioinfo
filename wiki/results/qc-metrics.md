---
title: QC 指标汇总
type: result
date: 2026-06-04
tags: [qc, metrics, dp, gq, cv]
---
# QC 指标汇总

## 项目 QC 流程

DeepVariant 单样本 → GLnexus 联合 calling → 多轮过滤 → QC 统计

## QC 统计维度

### 1. 深度 (DP) 分布
评估测序覆盖度。
- 查看位点深度分布是否合理
- 过高深度可能为重复区域
- 过低深度可能为覆盖不足

### 2. 基因型质量 (GQ) 分布
评估变异 calling 可信度。
- GQ 越高越可信
- 低 GQ 比例过高 → 测序质量可能有问题

### 3. 变异系数 (CV)
位点间深度变异程度。
- CV 过高说明某些位点深度不均匀
- 用于检测异常样本或区域

## 各批次 QC 结果

### SY-P2 1to10 过滤前
- 路径：`reports/user_script_stat_sample过滤前dpgq/`
- 文件：`merge_100w_sites_DP.txt`, `merge_100w_sites_GQ.txt`
- 采样：100 万位点

### SY-P2 1to10 过滤后 (dp5-20, gq10, siteDP4-20, siteGQ10)
- 路径：`reports/SY-P2_1to10_filtered_dp5-20_gq10_siteDP4-20_siteGQ10_stat_sample/`
- 文件：同上结构

### Tajik 组过滤后 (dp4-20, gq13, siteDP3-20, siteGQ6)
- 路径：`reports/tajik_filtered_dp4-20_gq13_siteDP3-20_siteGQ6_stat_sample/`
- 含运行日志：`p2_joint_call.log`

### 全样本过滤后 (不含塔吉克)
- 路径：`reports/filtered_user_script_stat_sample不带塔吉克过滤后dpgq/`

## QC 脚本

| 脚本 | 功能 |
|------|------|
| [[glnexus-dp-gq-cv-hist]] | DP/GQ/CV 分布直方图 |
| [[glnexus-merged-metrics]] | GLnexus 合并后综合指标 |
| [[vcf-dp-gq-cv-stat-like-user]] | 类似 user 方法的统计 |
| [[count-joint-sites-by-missing-rate]] | 按缺失率统计 |
| [[count-joint-called-sites-between-vcfs]] | VCF 间共同位点统计 |

## QC 可视化

| 脚本 | 功能 |
|------|------|
| [[plot-vcf-dp-gq-cv-from-user-stats]] | 从统计数据画图 |
| [[plot-histograms]] | DP/GQ/CV 直方图 (R) |

## 染色体级别 QC

- 路径：`chr_count_qc/` — 原始 QC
- 路径：`chr_count_qc_fai/` — 使用 fai 索引的 QC
- 文件：`sample_qc_summary.tsv`, `chr_rate_ranked.tsv`

## 相关笔记
- [[vcf-filtering]] — 过滤流程
- [[filtering-params]] — 过滤参数
- [[glnexus-joint-calling]] — 联合 calling
