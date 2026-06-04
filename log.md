# log.md — 知识库操作日志

> 追加写入。记录每次 ingest、query、lint 操作。

---

## [2026-06-04] 知识库初始化

- **操作**：创建知识库目录结构和基础文件
- **文件**：`CLAUDE.md`, `index.md`, `templates/`
- **状态**：已完成

---

## [2026-06-04] 首次批量 Ingest

- **操作**：对 `/data1/gh/sy/vcf` 项目做首次批量知识摄入
- **范围**：38 个脚本（10 bash + 14 Python + 5 R + 9 其他）
- **创建页面**：
  - `wiki/tools/` × 6：deepvariant, glnexus, bcftools, admixture, iqtree, plink
  - `wiki/workflows/` × 4：deepvariant-calling, glnexus-joint-calling, vcf-filtering, admixture-pca-tree
  - `wiki/params/` × 3：filtering-params, glnexus-params, admixture-params
  - `wiki/scripts/` × 5：核心脚本详细页
  - `wiki/results/` × 3：qc-metrics, population-structure, variant-counts
  - `wiki/troubleshooting/` × 3：glnexus-oom, vcf-chr-mismatch, deepvariant-filter-quality
- **软链接**：`raw/` 目录已链接到实际项目文件
- **待完善**：剩余脚本详细页、CV Error 具体数值、位点数填充

---

## [2026-06-04 16:57:47] 自动摄入 (stdin)

- 文件: `/home/descfly/bioinfo-kb/inbox/20260604-165747.md`
- 内容预览: ## 测试摄入 这是从 Codex 或其他工具自动保存的分析记录。 - 脚本: test.sh 


## [2026-06-04 19:01:25] 自动摄入 (message)

- 文件: `/data1/gh/bioinfo-kb/inbox/20260604-190125.md`
- 内容预览: # Tajik 公共位点 VCF 过滤、ADMIXTURE/PCA 与 IQ-TREE 分析记录  日期：2026-06-04 

