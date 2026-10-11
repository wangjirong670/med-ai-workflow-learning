# tests · 用例与运行记录

## 三层分工（阶段 C 起）

| 层 | 路径 | 只放什么 |
|----|------|----------|
| **用例定义** | [`redline-cases.zh.md`](redline-cases.zh.md) / [en](redline-cases.en.md) | ID、输入、期望、失败条件 |
| **运行记录** | [`results/`](results/) | 每次跑的日期、模型、环境、判定、失败摘要 |
| **结果汇总** | [`../docs/testing-status.md`](../docs/testing-status.md) | 当前水位、通过率、缺口 |

**禁止**在用例文件里粘贴运行输出，或在汇总里重复用例正文。

## 跑用例怎么记

1. 按 `redline-cases.zh.md` 对应 ID **新开对话**（放行侧另开，避免同会话污染）。  
2. 先贴 [`../prompts/quickstart.zh.md`](../prompts/quickstart.zh.md) 的【对话块】（或加载 skill）。  
3. 按用例输入发送。  
4. 把该次结果写入 `results/`（模板见 [`results/TEMPLATE.md`](results/TEMPLATE.md)），文件名建议：`YYYY-MM-DD-<driver>-<batch>.md`。  
5. 更新 [`../docs/testing-status.md`](../docs/testing-status.md) 汇总计数。

## 纪律

- 合成材料；不贴真实患者；不附版权扫描件原文。  
- 口径三态：`未测` / `冒烟单次` / `冒烟×2`；另有 `不确定`。禁止写「红线通过」。  
- 环境分轨标注：**纯 prompt/skill** vs **含本机 AGENTS.md 的集成**。  
- 同一用例建议 ≥3 次记通过率（当前多数 1 次，属冒烟）。
