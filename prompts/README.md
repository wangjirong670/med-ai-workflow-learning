# 学习向 · Prompts

按场景选入口；**对话块规则只有一个权威源**。

| 文件 | 给谁 | 角色 |
|------|------|------|
| [`share-pack-lite.zh.md`](share-pack-lite.zh.md) | 免费 chatbot（豆包等） | **转发包**（壳）；对话块 = `quickstart-lite.zh.md` |
| [`share-pack-full.zh.md`](share-pack-full.zh.md) | 强模型 / agent | **转发包**（壳）；对话块 = `quickstart.zh.md` |
| [`quickstart.zh.md`](quickstart.zh.md) | 强模型 / skill / 贡献 | **权威对话块**（完整 L1） |
| [`quickstart-lite.zh.md`](quickstart-lite.zh.md) | 免费场景的权威源 | **权威精简块** |
| [`quickstart.en.md`](quickstart.en.md) | 英文读者 | 说明（正文未翻译） |

## 同步纪律

1. **改规则 → 只改** `quickstart.zh.md` / `quickstart-lite.zh.md`。  
2. **必须同步**对应 `share-pack-*.zh.md` 中【对话块】到「从这里结束」之间的正文（应与权威源逐字一致）。  
3. 运行 `python scripts/sync_share_packs.py` 更新分享块，`--check` 只读验收；红线语义不得在壳里另写一套。  
4. skill 快照仍钉 `quickstart.zh.md`，不以分享包为准。

测试水位见 [`../docs/testing-status.md`](../docs/testing-status.md)。
