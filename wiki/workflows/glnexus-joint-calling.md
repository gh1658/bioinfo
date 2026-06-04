---
title: GLnexus 联合 Calling 流程
type: workflow
date: 2026-06-04
status: production
tools: [glnexus, bcftools, deepvariant]
project: sy
tags: [joint-calling, glnexus, gvcf]
---
# GLnexus 联合 Calling 流程

## 目的

将 DeepVariant 产生的多个样本 gVCF 合并为联合 VCF，进行 joint genotyping，提高低覆盖度区域的变异检出率。

## 输入数据

- 每个样本的 gVCF 文件（DeepVariant 输出）
- 参考基因组索引文件 `.fai`
- 样本-客户 ID 映射表：`sampleName_clientId.txt`

## 分析步骤

### 1. 准备样本列表
创建 gVCF 路径列表文件，按样本组分开。

路径：`glnexus_merge/sample_lists/`

```
# 示例：merge_without_1to10_exclude_13_14_70_94.gvcf.list
/path/to/sample1.g.vcf.gz
/path/to/sample2.g.vcf.gz
...
```

### 2. 按染色体 GLnexus 合并

**脚本**：[[run-glnexus-by-chr]]

```bash
bash run_glnexus_by_chr.sh
```

内部逻辑：
1. 从第一个 gVCF 头部提取染色体区间 → 生成 BED 文件
2. 每个染色体独立运行 GLnexus
3. bcftools concat 合并所有染色体 VCF

**参数**：
| 参数 | 值 | 说明 |
|------|-----|------|
| threads | 16 | 每染色体线程数 |
| mem_gb | 120 | 内存上限 |
| chroms | Chromosome_1~9 | 染色体列表 |

### 3. 合并后建索引

```bash
bcftools index -t merge_${prefix}.by_chr.vcf.gz
```

### 4. VCF 过滤（后续步骤）

参见 [[vcf-filtering]]

### 5. 质控统计（后续步骤）

参见 [[vcf-qc-metrics]]

## 输出文件

### 主要输出

| 文件 | 大小 | 描述 |
|------|------|------|
| `merge_without_1to10_exclude_13_14_70_94.by_chr.vcf.gz` | ~72 GB | 合并后的联合 VCF |
| `merge_with_1to10_exclude_13_14_94.by_chr.vcf.gz` | ~83 GB | 含 SY-P2 1-10 的联合 VCF |

### 中间文件
| 目录 | 内容 |
|------|------|
| `glnexus_merge/by_chr/` | 每个染色体的 BCF/VCF |
| `tmp_glnexus/by_chr/` | GLnexus 临时文件 |

## 运行时间

约数小时到一天，取决于样本数和染色体数。

## 样本分组策略

本项目有两种分组：
- **含 1to10**：包含 SY-P2-1~10 核心样本
- **不含 1to10**：其余样本（约 190 个），排除异常样本 13, 14, 70, 94

## 注意事项

- 每条染色体的 GLnexus 可以并行跑（需独立 tmp 目录）
- 注意 `tmp_glnexus` 临时文件磁盘空间
- `--bed` 参数确保 GLnexus 只检查指定染色体的变异

## 相关笔记
- [[deepvariant-calling]] — 上游 gVCF 生成
- [[vcf-filtering]] — 下游过滤流程
- [[glnexus-params]] — 完整参数记录
- [[glnexus]] — GLnexus 工具笔记
- [[glnexus-oom]] — 内存问题排查
