# med-ai-workflow-learning

医学生**学习向** AI 整理工作流（L1 Prompt，可复制粘贴；L2 Skill 可加载）。  
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
3. **交付**：可粘贴【对话块】`prompts/quickstart.zh.md` + 可加载 skill `skills/med-study-knead/`  
4. **测试**：冒烟级；用例在 `tests/`，结果汇总在 [`docs/testing-status.md`](docs/testing-status.md)

## 五分钟上手

**当 Prompt 用（L1）**

1. 打开 [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md)  
2. 复制【对话块】到**新**对话  
3. 粘贴你的笔记 / 书页（示例 [`examples/formA-notes.md`](examples/formA-notes.md)）  
4. 你来拍板；AI 给结构与核对路径，不给可抄答案  

**当 Skill 用（L2）** — 见 [`skills/README.md`](skills/README.md)

## 仓库里有什么

| 层级 | 路径 | 当前状态 |
|------|------|----------|
| L1 Prompt | [`prompts/`](prompts/) | **可用**（主入口 `quickstart.zh.md`） |
| L2 Skill | [`skills/med-study-knead/`](skills/med-study-knead/) | **已有初版**（薄封装，依赖仓内 prompt；集成测试待补） |
| L3 Harness | [`harness/`](harness/) | **未开工**（先契约，后 runner） |
| 方法纪律 | [`docs/method.zh.md`](docs/method.zh.md) · [en](docs/method.en.md) | 在用 |
| 测试用例 | [`tests/`](tests/) | 持续补测 |

## 和临床向的关系

| 仓 | 轨道 | 状态 |
|----|------|------|
| **本仓** | 学习：课业整理、理解、复习 | Prompt 可用 · Skill 初版 |
| [med-ai-workflow-clinical](https://github.com/wangjirong670/med-ai-workflow-clinical) | 临床：交班/病例讨论材料 | 仅边界文档，**未开工** |

两轨**共用纪律、分立红线与证据档位**；真实病人请走上级医师/院内流程，不要进本仓。

## 当前验证水位（诚实版）

口径三态，**禁止**把「单次通过」写成「红线通过」：

| 态 | 含义 |
|----|------|
| 未测 | 尚无运行记录 |
| 冒烟单次 | ≥1 次通过，样本少，**不可靠** |
| 冒烟×2 | 2 次通过；仍非充分覆盖 |
| 不确定 | 有跑过但结论不闭合（如 D6 勘误需诱错剧本） |

摘要（细节与次数以 [`docs/testing-status.md`](docs/testing-status.md) 为准）：

| 已有记录（约 1–2 次） | 未测 / 待补次数 |
|----------------------|----------------|
| 书页冷启动；空白题库拒填；A3 半填；A4 占位符；A9 脱敏；A10 连续施压；B1–B3 放行；C1 教材病例；D4 对账≠正确；E4 人话模式（×2）；真实患者拦截 | A2 / A5 / A6 / A8 / A11；B4；C2；D1–D3 / D5 / D7–D9；E1 形态 A / E2 轻量 / E3 版次；英文 prompt；各红线再 ×2 记通过率 |

**冒烟通过 ≠ 红线可靠。** Skill 冒烟为人工套规则，不等于 Agent 自动加载验证。

## 发现红线失败

开 Issue，附**完整对话**（去掉患者信息）。红线优先于功能请求。

## License

[MIT](LICENSE) · 免责声明见文首与 [README.zh.md](README.zh.md)。
