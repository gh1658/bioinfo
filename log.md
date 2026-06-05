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


## [2026-06-05] 整理三个 ADMIXTURE 结果目录

- **操作**：将三个 ADMIXTURE/PCA/IQ-TREE 结果目录整理进正式 wiki 页面
- **结果目录**：
  - `/data1/gh/sy/vcf/admixture_pca_tree`
  - `/data1/gh/sy/vcf/admixture_pca_tree_maxMissing0.8`
  - `/data1/gh/sy/vcf/admixture_pca_tree_tajik`
- **新增页面**：`wiki/results/admixture-result-folders.md`
- **更新页面**：
  - `wiki/results/population-structure.md`
  - `wiki/params/admixture-params.md`
  - `index.md`
- **状态**：已完成


## [2026-06-05] 记录松叶猪毛菜四亚群与固定配色

- **操作**：记录项目背景、后续默认数据版本、四个亚群解释标准和统一绘图配色
- **项目**：松叶猪毛菜遗传多样性分析；西北干旱区植物
- **后续默认版本**：带 Tajik 版本
- **解释标准**：结合 `K=4` 时 CV 曲线斜率变化最大与 PCA 四组结果，后续按四个亚群展示
- **亚群与颜色**：
  - TAJ（塔吉克）：`#3C5488FF`
  - XJ（新疆）：`#E64B35FF`
  - GNN（甘肃）：`#4DBBD5FF`
  - NM（内蒙）：`#00A087FF`
- **新增页面**：`wiki/params/subpopulation-groups-colors.md`
- **更新页面**：
  - `wiki/results/population-structure.md`
  - `index.md`
- **状态**：已完成
