# inbox — 知识库收件箱

任何工具（Claude Code、Codex、手动脚本）都可以把分析记录丢到这里。
markdown 文件会被定期整理成正式的 wiki 页面。

## 如何使用

### 从 Codex / 其他工具
```bash
echo '## DeepVariant 运行记录
- 样本: SY-P2-1
- 参数: threads=8
- 结果: /path/to/output.vcf.gz
' | bash ~/bioinfo-kb/ingest.sh
```

### 从 Claude Code
直接说：**"整理知识库收件箱"** 或 **"处理 inbox"**

