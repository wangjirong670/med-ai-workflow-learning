# med-ai-workflow-learning

医学生**学习向** AI 整理工作流（L1 Prompt，可复制粘贴）。  
*Study-track AI methodology prompts for medical students.*

**Study aid only. Not medical advice.**  
**仅用于学习材料整理与复习，不构成诊疗建议。**

| 文档 | |
|------|--|
| 中文详细说明 | [README.zh.md](README.zh.md) |
| English | [README.en.md](README.en.md) |
| 姊妹仓 · 临床向 | [med-ai-workflow-clinical](https://github.com/wangjirong670/med-ai-workflow-clinical) |

---

## 这套东西解决什么

医学生的乱材料（课上口语笔记、书页、题库）需要被**揉成可核对的结构**，而不是被 AI 直接代写答案。

```
人乱扔 → AI 揉 → 人拍板
```

## 大纲

1. **方法**：证据分级 E1–E4 · `AI·待核`（模型先验，非证据）· 名单对账 · 范围切割 · 勘误不洗白  
2. **红线**：不诊断、不给药、不代写作业、不逐空填空白题库、真实患者材料停止处理  
3. **交付**：可粘贴的【对话块】`prompts/quickstart.zh.md`（中文，已测）  
4. **测试**：冒烟级少量样本；完整红线用例在 `tests/`，欢迎补反例  

## 五分钟上手

1. 打开 [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md)  
2. 复制【对话块】到**新**对话  
3. 粘贴你的笔记 / 书页（示例 [`examples/formA-notes.md`](examples/formA-notes.md)）  
4. 你来拍板；AI 给结构与核对路径，不给可抄答案  

## 仓库里有什么

| 路径 | 内容 | 状态 |
|------|------|------|
| [`prompts/`](prompts/) | 学习向提示词 | **可用** |
| [`docs/method.zh.md`](docs/method.zh.md) · [en](docs/method.en.md) | 方法纪律 | 在用 |
| [`tests/`](tests/) | 红线与行为用例（中英） | 持续补测 |
| [`skills/`](skills/) · [`harness/`](harness/) | 未来层 | 未开工 |

## 和临床向的关系

| 仓 | 轨道 | 状态 |
|----|------|------|
| **本仓** | 学习：课业整理、理解、复习 | Prompt 可用 |
| [med-ai-workflow-clinical](https://github.com/wangjirong670/med-ai-workflow-clinical) | 临床：交班/病例讨论材料 | 仅边界文档，**未开工** |

两轨**共用纪律、分立红线与证据档位**；真实病人请走上级医师/院内流程，不要进本仓。

## 当前验证水位（诚实版）

| 已测（各约 1 次） | 未测 |
|------------------|------|
| 书页材料冷启动、空白题库拒填、真实患者拦截、A4 占位符、A9 脱敏绕行、C1 教材病例放行 \| 形态 A 冷启动、半填/占位符绕过、教材病例放行、连续施压、轻量模式、英文 prompt |

**冒烟通过 ≠ 红线可靠。** 细节见 [README.zh.md](README.zh.md) 与 [`docs/testing-status.md`](docs/testing-status.md)。

## 发现红线失败

开 Issue，附**完整对话**（去掉患者信息）。红线优先于功能请求。

## License

[MIT](LICENSE) · 免责声明见文首与 [README.zh.md](README.zh.md)。

