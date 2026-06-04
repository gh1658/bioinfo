---
title: DeepVariant
type: tool
date: 2026-06-04
tags: [deepvariant, variant-calling, germline]
---
# DeepVariant

## 概述

Google 开发的基于深度学习的 germline 变异检测工具。将 BAM 文件转换为 pileup 图像，用 CNN 模型识别 SNP 和 Indel。

## 在本项目中的使用

### 版本
- Docker 镜像运行
- 模型：WGS (Whole Genome Sequencing)

### 运行模式
- 单样本模式
- 输出 gVCF 格式（用于后续联合 calling）

### 典型命令

```bash
# DeepVariant 单样本运行
docker run \
  -v /data1/input:/input \
  -v /data1/output:/output \
  google/deepvariant:latest \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=WGS \
  --ref=/input/ref.fasta \
  --reads=/input/sample.bam \
  --output_vcf=/output/sample.vcf.gz \
  --output_gvcf=/output/sample.g.vcf.gz \
  --num_shards=$(( $(nproc) ))
```

### 关键参数

| 参数 | 常用值 | 说明 |
|------|--------|------|
| `--model_type` | WGS | 测序类型 |
| `--output_gvcf` | sample.g.vcf.gz | 输出 gVCF |
| `--num_shards` | CPU 核心数 | 并行 shard 数 |

### 输出

- `.vcf.gz` — 变异位点 VCF
- `.g.vcf.gz` — 包含非变异区域的 gVCF
- 日志文件 — 包含每个样本运行指标

### 日志位置
- 项目日志：`/data1/gh/sy/vcf/logs_reseq/*_good.log`

## 相关笔记
- [[glnexus-joint-calling]] — gVCF 后续处理
- [[vcf-filtering]] — VCF 过滤
- [[deepvariant-remote-metrics]] — 远程指标采集脚本
- [[deepvariant-result-stat]] — 结果统计脚本
