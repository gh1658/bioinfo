---
title: DeepVariant 变异检测流程
type: workflow
date: 2026-06-04
status: production
tools: [deepvariant, docker]
project: sy
tags: [variant-calling, germline, gvcf]
---
# DeepVariant 变异检测流程

## 目的

对每个样本的 BAM 文件进行 germline SNP/Indel 变异检测，输出 gVCF 格式。

## 输入数据

- 各样本的 BAM 文件（比对后）
- 参考基因组 FASTA + 索引

## 运行方式

使用 Docker 容器运行 DeepVariant，每个样本一个任务。

## 样本规模

~200 个样本，样本名 → 客户 ID 映射见 [[sampleName_clientId.txt]]

路径：`/data1/gh/sy/vcf/sampleName_clientId.txt`

## 输出

### gVCF 文件
每个样本产出：
- `.g.vcf.gz` — gVCF（含非变异区域）
- `.vcf.gz` — 仅变异位点

### 运行日志

路径：`/data1/gh/sy/vcf/logs_reseq/`

日志文件命名：`{sampleName}_good.log`

日志包含：
- DeepVariant 版本和参数
- 每个染色体的处理时间
- 变异位点总数
- SNP/Indel 比例

## 远程指标采集

项目中使用自定义 Python 脚本采集 DeepVariant 运行指标：

| 脚本 | 功能 |
|------|------|
| [[deepvariant-remote-metrics]] | 基础指标采集 |
| [[deepvariant-remote-metrics-checkpoint]] | 支持断点续传的增强版 |

配置文档：`scripts/deepvariant_remote_metrics.md`

## 质量检查

### 单样本指标
- 总变异数（SNP + Indel）
- 各染色体变异数分布
- DP（深度）分布
- GQ（基因型质量）分布

### 相关 QC 脚本
- `count_single_sample_chr_rows.sh` — 统计单样本各染色体变异数
- `analyze_chr_row_counts.sh` — 分析行数统计
- `chr_count_qc/` — QC 结果目录

## 注意事项

- gVCF 文件较大（含非变异区域信息），磁盘空间需充足
- DeepVariant Docker 需要 GPU 或足够 CPU
- `--num_shards` 设为核心数可加速

## 相关笔记
- [[glnexus-joint-calling]] — 下游联合 calling
- [[deepvariant]] — DeepVariant 工具笔记
- [[deepvariant-remote-metrics]] — 指标采集脚本
- [[deepvariant-result-stat]] — 结果统计脚本
