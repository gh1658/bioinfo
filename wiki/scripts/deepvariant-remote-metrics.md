---
title: deepvariant-remote-metrics
script: deepvariant_remote_metrics.py
path: /data1/gh/sy/vcf/scripts/deepvariant_remote_metrics.py
language: python
purpose: 远程采集 DeepVariant 运行指标，监控每个样本的变异检测质量
dependencies: [paramiko, pandas]
project: sy
tags: [deepvariant, metrics, python, monitoring]
date: 2026-06-04
---
# deepvariant_remote_metrics.py

## 功能描述

通过 SSH 远程连接运行 DeepVariant 的服务器，采集每个样本的变异检测指标（运行时间、变异数、深度分布等）。

## 使用方法

```bash
python deepvariant_remote_metrics.py --host <server> --user <username>
```

## 采集指标

- 每个样本的变异位点总数（SNP + Indel）
- 运行时间
- 每个染色体的变异数分布
- 错误和警告信息

## 输入 / 输出

- **输入**：远程服务器的 DeepVariant 日志
- **输出**：指标汇总表

## 依赖

- paramiko (SSH 连接)
- pandas (数据处理)

## 使用场景

- [[deepvariant-calling]] — 批量变异检测时监控质量
- 大批量样本（~200 个）的 deepvariant 运行管理

## 相关笔记
- [[deepvariant-remote-metrics-checkpoint]] — 支持断点续传的增强版
- [[deepvariant]] — DeepVariant 工具笔记
- 配置文档：`scripts/deepvariant_remote_metrics.md`
