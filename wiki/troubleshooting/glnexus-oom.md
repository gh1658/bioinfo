---
title: GLnexus 内存溢出问题
type: troubleshooting
date: 2026-06-04
tags: [glnexus, troubleshooting, memory]
---
# GLnexus 内存溢出 (OOM)

## 问题描述

GLnexus 运行时因内存不足被系统 OOM killer 终止。

## 常见原因

1. **样本数过多**：gVCF 合并的样本数越多，GLnexus 内存占用越大
2. **染色体过大**：大染色体（如 Chromosome_1）的内存需求高于小染色体
3. **DeepVariant gVCF 块大小**：gVCF 中的 block 信息也占用内存

## 解决方案

### 方案 1：增加内存限制

```bash
MEM_GB=200 bash run_glnexus_by_chr.sh
```

### 方案 2：按染色体并行

将全基因组拆分到每条染色体，逐条跑（当前方案）：

```bash
# 每条染色体独立运行，所需内存大幅降低
for chr in Chromosome_1 Chromosome_2 ...; do
  glnexus_cli --mem-gbytes 120 ...
done
```

### 方案 3：减少单次处理的样本数

分批运行，多轮合并：
```
第1批: 合并样本 1-100
第2批: 合并样本 101-200
最终: 合并第1批 + 第2批
```

本项目使用的就是这种策略：
- 批次1: `with_1to10`
- 批次2: `without_1to10`
- 最终: P2 vs others

### 方案 4：减少线程数

减少线程数可略微降低内存：

```bash
THREADS=8 bash run_glnexus_by_chr.sh
```

## 排查命令

```bash
# 查看 GLnexus 进程内存
ps aux | grep glnexus

# 查看系统内存使用
free -h

# 查看 OOM 日志
dmesg | grep -i "out of memory"
```

## 预防措施

- 运行前用 `free -h` 确认有足够内存
- 监控 `htop` 确保内存在限制内
- 设置 `--mem-gbytes` 略低于系统可用内存
- 使用 `set -euo pipefail` 捕获失败

## 相关笔记
- [[glnexus]] — GLnexus 工具笔记
- [[glnexus-joint-calling]] — 完整流程
- [[glnexus-params]] — 参数记录
