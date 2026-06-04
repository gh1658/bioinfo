---
title: GLnexus
type: tool
date: 2026-06-04
tags: [glnexus, joint-calling, gvcf]
---
# GLnexus

## 概述

DNAnexus 开发的 gVCF 联合 calling 工具。将多个样本的 gVCF 合并为一个联合 VCF，同时进行 joint genotyping。

## 在本项目中的使用

### 数据规模
- ~200 个样本
- 9 条染色体
- gVCF 来自 DeepVariant

### 运行策略

#### 按染色体并行
将样本按染色体拆分后分别运行 GLnexus，最后合并：

```bash
# 核心脚本：run_glnexus_by_chr.sh
# 每个染色体独立运行，并行处理
threads=16
mem_gb=120
chroms=(Chromosome_1 Chromosome_2 ... Chromosome_9)

for chr in "${chroms[@]}"; do
  glnexus_cli \
    --config DeepVariant_unfiltered \
    --bed ${chr}.bed \
    --threads ${threads} \
    --mem-gbytes ${mem_gb} \
    ${input_gvcfs[@]} \
    | bcftools view -Oz -o ${chr}.vcf.gz
done
```

#### 分批合并
由于样本量大，分批次运行：
- **批次 1** (`with_1to10`): 包含 SY-P2-1~10 等核心样本
- **批次 2** (`without_1to10`): 其余样本 → 再与批次1合并

### 关键参数

| 参数 | 常用值 | 说明 |
|------|--------|------|
| `--config` | DeepVariant_unfiltered | GLnexus 预设配置 |
| `--threads` | 16 | 线程数 |
| `--mem-gbytes` | 120 | 内存上限 (GB) |
| `--bed` | chr.bed | 染色体区间限定 |

### 输出文件命名约定

```
merge_{样本组}.by_chr.vcf.gz                           # 按染色体合并
merge_{样本组}.by_chr.filtered.{过滤参数}.vcf.gz        # 过滤后
```

示例：
```
merge_without_1to10_exclude_13_14_70_94.by_chr.vcf.gz
merge_without_1to10_exclude_13_14_70_94.by_chr.filtered.dp3-20.gq5.siteDP4-20.siteGQ10.vcf.gz
```

## 常见问题

### 内存溢出 (OOM)
- 症状：GLnexus 进程被 OOM killer 杀死
- 解决：增加 `--mem-gbytes`，或减少单次处理的样本数
- 详见：[[glnexus-oom]]

## 相关笔记
- [[glnexus-joint-calling]] — GLnexus 完整分析流程
- [[deepvariant]] — 上游 gVCF 生成
- [[vcf-filtering]] — 下游 VCF 过滤
- [[glnexus-params]] — 参数记录
