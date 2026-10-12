# 材料外置索引（与 SKILL.md 同级的细目录）

权威正文不在此文件。按需打开：

## 解析顺序

1. 仓内权威：`prompts/quickstart.zh.md` · `docs/method.zh.md`
2. 发布快照：`snapshot/quickstart.snapshot.md` · `snapshot/method.snapshot.md`（脚本生成）
3. 两者皆无：停止规则执行，只说明缺失

| 主题 | 权威路径 → 节 | 快照 |
|------|----------------|------|
| E1–E4 / `AI·待核` / 倾向拆明 | `prompts/quickstart.zh.md` →「学习向证据档位」 | `snapshot/quickstart.snapshot.md` |
| 形态 A/B · 主链 · 范围切割 | 同上 →「形态与主链」 | 同上 |
| 对照臂 / 翻案点 | 同上 →「对照臂与翻案点」 | 同上 |
| 轻量模式 | 同上 →「轻量模式」 | 同上 |
| 人话输出 / 钉子单模板 / 审计块 | 同上 →「输出模式」「输出」 | 同上 |
| 坏输出打分表 | 同上 →「坏输出（打分表）」 | 同上 |
| 双轨纪律 · 勘误协议 | `docs/method.zh.md` | `snapshot/method.snapshot.md` |
| 红线用例 | `tests/redline-cases.zh.md` | （不打包） |
| 快照来源版本与 sha256 | — | `snapshot/MANIFEST.json` |

权威源：以 `prompts/quickstart.zh.md` 为准（版本看 git）；skill 与其分叉时按权威源执行。  
快照**禁止手改**；变更后运行 `scripts/sync_from_prompt.py`。
