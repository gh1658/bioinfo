# 生信知识库交接文档

## 是什么

`~/bioinfo-kb/` 是一个纯 Markdown 知识库，记录所有生信分析的脚本、流程、参数、结果。用 Obsidian 打开即可浏览。Git 管理版本。

## 核心操作：做完分析后写一条记录

只需一行命令，把分析记录丢进收件箱。之后 Claude Code 那边会自动整理成 wiki 页面。

## ingest.sh 用法

```bash
bash ~/bioinfo-kb/ingest.sh [选项]
```

### 四种模式

**1. 管道输入（最常用）**
```bash
cat <<'EOF' | bash ~/bioinfo-kb/ingest.sh
## VCF 过滤
- 输入: merge.by_chr.vcf.gz (172M sites)
- 参数: dp3-20, gq5, siteDP4-20, siteGQ10, maf0.05, minAllele2, maxMissing0.8
- 输出: merge.filtered.maf0.05.maxMissing0.8.vcf.gz (11.8M sites)
- 命令:
  bcftools view -i 'FORMAT/DP>=3 && FORMAT/DP<=20 && FORMAT/GQ>=5' ...
EOF
```

**2. 保存脚本 (-s)**
```bash
bash ~/bioinfo-kb/ingest.sh -s /data1/gh/sy/vcf/scripts/my_new_script.py
```

**3. 一句话消息 (-m)**
```bash
bash ~/bioinfo-kb/ingest.sh -m "跑完了 DeepVariant，200个样本，gVCF 在 /data1/output/gvcf/"
```

**4. 从文件 (-f)**
```bash
bash ~/bioinfo-kb/ingest.sh -f /tmp/analysis_summary.md
```

### 查看帮助
```bash
bash ~/bioinfo-kb/ingest.sh -h
```

## 真实场景示例

### 场景1：跑完 GLnexus joint calling
```bash
bash ~/bioinfo-kb/ingest.sh -m "GLnexus joint calling 完成:
- 191样本, 24线程, 150G内存
- gVCF列表: glnexus_merge/sample_lists/xxx.gvcf.list
- 输出: glnexus_merge/merge_xxx.by_chr.vcf.gz (172.8M sites, 73G)
- 日志: glnexus_merge/merge_xxx.fast_run.log
- 耗时: bulk load 3h20m"
```

### 场景2：写完一个新 Python 脚本
```bash
bash ~/bioinfo-kb/ingest.sh -s /data1/gh/sy/vcf/scripts/count_variants_by_population.py
```

### 场景3：ADMIXTURE 群体结构分析
```bash
cat <<'EOF' | bash ~/bioinfo-kb/ingest.sh
## ADMIXTURE 群体结构分析
- 输入: filtered.maxMissing0.8.vcf.gz → PLINK bed (45k SNPs after LD pruning)
- K值: 2-10, 每个5个seed
- 线程: 16
- 输出: admixture_pca_tree/admixture_runs/
- 最佳K: K=5 (CV error 0.363)
EOF
```

### 场景4：跑完 IQ-TREE 建树
```bash
cat <<'EOF' | bash ~/bioinfo-kb/ingest.sh
## IQ-TREE 系统发育树
- 输入: biallelic_snps.5k_per_chr.phy (9 chr × 5000 sites)
- 模型: MFP (自动选择)
- Bootstrap: 1000 (ultrafast)
- 输出: admixture_pca_tree/iqtree_5k_per_chr/
- 可视化: plot_iqtree_tree_nature.R, plot_iqtree_tree_ggtree_circular.R
EOF
```

## 写入后发生了什么

1. `ingest.sh` 写入 `~/bioinfo-kb/inbox/` 目录
2. 自动 git commit
3. 下次在 Claude Code 说 **"整理知识库"** 时，收件箱里的记录会被整理成正式 wiki 页面，建立交叉引用

## 目录速查

| 路径 | 内容 |
|------|------|
| `~/bioinfo-kb/wiki/workflows/` | 分析流程（variant calling → joint calling → filtering → popgen） |
| `~/bioinfo-kb/wiki/scripts/` | 脚本说明 |
| `~/bioinfo-kb/wiki/params/` | 参数记录（过滤参数、GLnexus 参数、ADMIXTURE 参数） |
| `~/bioinfo-kb/wiki/tools/` | 工具笔记（DeepVariant、GLnexus、bcftools、ADMIXTURE、IQ-TREE、PLINK） |
| `~/bioinfo-kb/wiki/troubleshooting/` | 踩坑记录 |
| `~/bioinfo-kb/inbox/` | 收件箱（待整理的原始记录） |
| `~/bioinfo-kb/CLAUDE.md` | 知识库规则 |

## 项目路径

生信分析主目录：`/data1/gh/sy/vcf/`

| 子目录 | 内容 |
|--------|------|
| `scripts/` | Python 和 Shell 脚本 |
| `glnexus_merge/` | GLnexus 合并结果 |
| `reports/` | QC 统计报告 |
| `logs_reseq/` | DeepVariant 运行日志 |
| `admixture_pca_tree/` | 群体结构分析结果 |
| `tools/` | 第三方工具 |
