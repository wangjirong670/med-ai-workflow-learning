# med-ai-workflow-learning

**中文** · [English](README.en.md)

医学生**学习向** AI 整理工作流：把乱笔记、书页转写、题库揉成**可辩护**的复习结构。

```
人乱扔 → AI 揉 → 人拍板
```

**仅用于学习整理与复习，不构成诊疗建议。**  
不诊断、不给药、不代写作业；真实患者材料停止处理。

## 这是什么 / 不是什么

| 是 | 不是 |
|----|------|
| 课业乱材料 → 结构、缺口、核对路径 | 临床决策 / 患者咨询 |
| 你拍板，AI 不替你下结论 | 作业代写 / 题库直填答案 |
| 证据可追：材料 / 我补的分开标 | 「教材上说」却不给版次页码 |

## 安装

技能包是标准 **`SKILL.md` 目录**，任意支持该格式的 agent 可用。

| 系统 | 一条命令 |
|------|----------|
| **Windows** | `irm https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/main/install.ps1 \| iex` |
| **macOS / Linux** | `curl -fsSL https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/main/install.sh \| bash` |

指定目录（任意系统）：

```powershell
# Windows
.\install.ps1 -Target "<你的 skills 目录>"
```

```bash
# macOS / Linux
./install.sh <你的 skills 目录>
```

或纯文本 L1：复制 [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md) 的【对话块】到任意对话。

## 试一下

1. 示例：[`examples/formA-notes.md`](examples/formA-notes.md)  
2. 已装 skill：直接说「帮我揉一下这页药理课业笔记」  
3. 期望输出：一句话状态 → 主干（标材料/我补的）→ 还不能当真 → 拍板 → 学习钉子单  

## 文档

- [`docs/method.zh.md`](docs/method.zh.md) — 循环、证据纪律、范围切割、勘误  
- [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md) — L1 全文（红线 / 证据档位 / 输出）  
- [`skills/README.md`](skills/README.md) — 技能包与依赖解析  
- [`tests/`](tests/) — 红线用例定义（**不要**粘完整对话）  
- [`docs/testing-status.md`](docs/testing-status.md) — 验证摘要（冒烟级）

## 边界

- 教材层面的机制、适应证、治疗原则、鉴别框架可以整理；**不对具体病例给处置**  
- 空白/半填题库：你先填、AI 后批；无参照不下对错  
- 「脱敏」不改变诊疗红线  

## License

[MIT](LICENSE) · 姊妹仓（临床向）：[med-ai-workflow-clinical](https://github.com/wangjirong670/med-ai-workflow-clinical)

## 怎么反馈

朋友在用：不对劲就开 Issue。  
红线问题（代写、真患者没停、误杀教材题…）→ 用模板 **反例 / 行为不对**（只给输入摘要 + 1–3 句关键输出，不要贴完整对话）。  
体验建议 → **体验 / 功能建议**。  
红线优先于功能请求。
