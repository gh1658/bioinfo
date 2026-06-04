# index.md — 生信分析知识库目录

> 最后更新：2026-06-04
> 自动维护，每次 ingest 后更新

## 分析流程 (workflows/)

| 流程 | 描述 | 工具 | 状态 |
|------|------|------|------|
| [[deepvariant-calling]] | DeepVariant 单样本变异检测 | deepvariant | production |
| [[glnexus-joint-calling]] | GLnexus 多样本联合 calling | glnexus, bcftools | production |
| [[vcf-filtering]] | VCF 站点和基因型过滤 | bcftools | production |
| [[vcf-qc-metrics]] | VCF DP/GQ/CV 统计分析 | python, R | production |
| [[admixture-pca-tree]] | 群体结构分析 (ADMIXTURE + PCA + IQ-TREE) | admixture, plink, iqtree | production |

## 脚本库 (wiki/scripts/)

### Shell 脚本
| 脚本 | 功能 | 路径 |
|------|------|------|
| [[run-glnexus-by-chr]] | GLnexus 按染色体并行 joint calling | `run_glnexus_by_chr.sh` |
| [[run-glnexus-fast-one]] | GLnexus 快速单次合并 | `run_glnexus_fast_one.sh` |
| [[run-glnexus-SY-P2-1to10]] | SY-P2 组 1-10 号样本 joint calling | `run_glnexus_SY-P2_1to10.sh` |
| [[merge-glnexus-local]] | 本地 GLnexus 合并 | `merge_glnexus_local.sh` |
| [[count-single-sample-chr-rows]] | 统计单样本各染色体变异数 | `count_single_sample_chr_rows.sh` |
| [[analyze-chr-row-counts]] | 分析染色体行数统计 | `analyze_chr_row_counts.sh` |
| [[filter-without-1to10-core]] | 过滤不含 1to10 核心样本的 VCF | `filter_without_1to10_core.sh` |
| [[run-admixture-pca-tree]] | ADMIXTURE + PCA + 建树流程 | `scripts/run_admixture_pca_tree.sh` |
| [[run-filter-maf005-minAllele2]] | MAF 0.05, minAllele2 过滤 | `scripts/run_filter_maf0.05_minAllele2.sh` |
| [[run-filter-maf005-minAllele2-maxMissing08]] | MAF 0.05 + maxMissing 0.8 过滤 | `scripts/run_filter_maf0.05_minAllele2_maxMissing0.8.sh` |
| [[run-iqtree-5k-per-chr]] | 每条染色体 5k 位点 IQ-TREE 建树 | `scripts/run_iqtree_5k_per_chr.sh` |
| [[run-maxMissing08-admixture-pca-tree]] | maxMissing 0.8 过滤后群体结构分析 | `scripts/run_maxMissing0.8_admixture_pca_tree.sh` |
| [[shuf-vcf-sites]] | 随机抽样 VCF 位点 | `scripts/shuf_vcf_sites.sh` |
| [[shuf-vcf-sites-text]] | 文本模式随机抽样 VCF 位点 | `scripts/shuf_vcf_sites_text.sh` |

### Python 脚本
| 脚本 | 功能 | 路径 |
|------|------|------|
| [[deepvariant-remote-metrics]] | DeepVariant 远程指标采集 | `scripts/deepvariant_remote_metrics.py` |
| [[deepvariant-remote-metrics-checkpoint]] | DeepVariant 指标断点续传版 | `scripts/deepvariant_remote_metrics_checkpoint.py` |
| [[glnexus-dp-gq-cv-hist]] | GLnexus 合并后 DP/GQ/CV 直方图 | `scripts/glnexus_dp_gq_cv_hist.py` |
| [[glnexus-merged-metrics]] | GLnexus 合并后指标统计 | `scripts/glnexus_merged_metrics.py` |
| [[pre-glnexus-local-qc]] | GLnexus 合并前本地 QC | `scripts/pre_glnexus_local_qc.py` |
| [[pre-glnexus-qc-common]] | GLnexus QC 公共函数 | `scripts/pre_glnexus_qc_common.py` |
| [[vcf-dp-gq-cv-stat-like-user]] | 类似 user 方法的 DP/GQ/CV 统计 | `scripts/vcf_dp_gq_cv_stat_like_user.py` |
| [[count-joint-called-sites-between-vcfs]] | 两个 VCF 间共同位点统计 | `scripts/count_joint_called_sites_between_vcfs.py` |
| [[count-joint-sites-by-missing-rate]] | 按缺失率统计 joint 位点 | `scripts/count_joint_sites_by_missing_rate.py` |
| [[count-p2-joint-call-sites]] | P2 样本 joint calling 位点统计 | `scripts/count_p2_joint_call_sites.py` |
| [[extract-joint-sites-by-called-count]] | 按样本数提取 joint 位点 | `scripts/extract_joint_sites_by_called_count.py` |
| [[filter-vcf-maf-min-allele-text]] | 文本模式 MAF/minAllele 过滤 | `scripts/filter_vcf_maf_min_allele_text.py` |
| [[build-chinese-qc-dashboard]] | 中文 QC 仪表盘构建 | `scripts/build_chinese_qc_dashboard.py` |
| [[deepvariant-result-stat]] | DeepVariant 结果统计 | `glnexus_merge/Deepvariant_result_stat.py` |

### R 脚本
| 脚本 | 功能 | 路径 |
|------|------|------|
| [[plot-admixture-pca-tree]] | ADMIXTURE/PCA/树可视化 | `scripts/plot_admixture_pca_tree.R` |
| [[plot-iqtree-tree-nature]] | IQ-TREE 树 Nature 风格可视化 | `scripts/plot_iqtree_tree_nature.R` |
| [[plot-iqtree-tree-ggtree-circular]] | IQ-TREE 环状树可视化 | `scripts/plot_iqtree_tree_ggtree_circular.R` |
| [[plot-vcf-dp-gq-cv-from-user-stats]] | 从 user 统计数据画 DP/GQ/CV 图 | `scripts/plot_vcf_dp_gq_cv_from_user_stats.R` |
| [[plot-histograms]] | DP/GQ/CV 分布直方图 | `reports/glnexus_dp_gq_cv_distribution/plot_histograms.R` |

### 其他
| 脚本 | 功能 | 路径 |
|------|------|------|
| [[vcf2phylip]] | VCF 转 PHYLIP 格式 | `admixture_pca_tree/vcf2phylip.py` |

## 参数记录 (wiki/params/)

| 页面 | 描述 |
|------|------|
| [[filtering-params]] | VCF 过滤参数组合（DP/GQ/siteDP/siteGQ/MAF/minAllele/maxMissing） |
| [[glnexus-params]] | GLnexus 运行参数（线程、内存、染色体列表） |
| [[admixture-params]] | ADMIXTURE K 值范围、seed、交叉验证参数 |

## 结果摘要 (wiki/results/)

| 页面 | 描述 |
|------|------|
| [[qc-metrics]] | 各批次 QC 指标汇总 |
| [[population-structure]] | 群体结构分析结果（ADMIXTURE/PCA/树） |
| [[variant-counts]] | 各阶段变异位点数量变化 |

## 工具笔记 (wiki/tools/)

| 页面 | 描述 |
|------|------|
| [[deepvariant]] | DeepVariant 使用笔记 |
| [[glnexus]] | GLnexus 使用笔记 |
| [[bcftools]] | bcftools 常用命令 |
| [[admixture]] | ADMIXTURE 群体结构分析 |
| [[iqtree]] | IQ-TREE 系统发育树 |
| [[plink]] | PLINK 格式转换和过滤 |

## 问题记录 (wiki/troubleshooting/)

| 页面 | 描述 |
|------|------|
| [[glnexus-oom]] | GLnexus 内存溢出问题 |
| [[vcf-chr-mismatch]] | VCF 染色体编号不匹配 |
| [[deepvariant-filter-quality]] | DeepVariant 过滤质量标记问题 |
