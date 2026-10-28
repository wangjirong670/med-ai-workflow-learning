# med-ai-workflow-learning

**中文** · [English](README.en.md)

医学生**学习向** AI 整理工作流：把乱笔记、书页转写、题库揉成**可辩护**的复习结构。

```
人乱扔 → AI 揉 → 人拍板
```

**仅用于学习整理与复习，不构成诊疗建议。**  
不诊断、不给药、不代写作业；真实患者材料停止处理。

## 前后对比（合成示例）

**乱扔进来的**（虚构内容，非教材原文）

```text
雾岭草？好像清热？又说能安神？黑板两行我抄乱了。
跟白花藤那个搞混……剂量完全没记。
```

**揉完的学习钉子单（骨架）**

- **一句话**：雾岭草两条功效（清热 / 安神）都出自课堂笔记，**还没对教材**。
- **概念钉子**：清热（材料）· 安神（材料）· 与白花藤辨异（**我补的，待你核对**）
- **还不能当真**：无版次页码；剂量材料未记，我补的数字一律不信。

每条分清「材料」和「我补的，待你核对」——待核的装不成教材事实。

## 怎么选

| 你是谁 | 用什么 |
|--------|--------|
| 朋友用免费 chatbot（豆包等） | 转发 [`prompts/share-pack-lite.zh.md`](prompts/share-pack-lite.zh.md) |
| 朋友用强模型 / agent | 转发 [`prompts/share-pack-full.zh.md`](prompts/share-pack-full.zh.md) |
| 装进 agent 长期用 | 下方 Install（skill） |
| 看规则 / 贡献 | 权威对话块 [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md)（分享包与它逐字一致） |

**用法三句**：① 新开对话，贴对话块再贴材料，说「整理成学习钉子单」；② 不确定写「我补的，待你核对」；③ 真实患者停，作业只给骨架。

## 这是什么 / 不是什么

| 是 | 不是 |
|----|------|
| 课业乱材料 → 结构、缺口、核对路径 | 临床决策 / 患者咨询 |
| 你拍板，AI 不替你下结论 | 作业代写 / 题库直填答案 |
| 证据可追：材料 / 我补的分开标 | 「教材上说」却不给版次页码 |

## 安装

技能包采用标准 **`SKILL.md` 目录**；发现路径和权限取决于宿主，跨 agent 自动加载尚未全面验证。

先克隆仓库并阅读脚本，再安装到你的 agent 实际配置的技能目录：

```bash
git clone https://github.com/wangjirong670/med-ai-workflow-learning.git
cd med-ai-workflow-learning
```

| OS | Command after review |
|----|----|
| Windows | `powershell -File .\install.ps1 -Target "<your-skills-dir>"` |
| macOS / Linux | `bash ./install.sh "<your-skills-dir>"` |

建议先阅读脚本再执行。

指定目录（任意系统）：

```powershell
# Windows
.\install.ps1 -Target "<你的 skills 目录>"
```

```bash
# macOS / Linux
./install.sh <你的 skills 目录>
```

或纯文本：复制分享包里的【对话块】（免费 → [`share-pack-lite`](prompts/share-pack-lite.zh.md)；强模型 → [`share-pack-full`](prompts/share-pack-full.zh.md)）。规则权威源是 [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md)。

## 试一下

1. 示例：[`examples/formA-notes.md`](examples/formA-notes.md)  
2. 已装 skill：直接说「帮我揉一下这页药理课业笔记」  
3. 期望输出：一句话状态 → 学习钉子单（主交付；标材料/我补的）→ 还不能当真 → 拍板  
4. 免费 chatbot 用 [`share-pack-lite.zh.md`](prompts/share-pack-lite.zh.md)；强模型/agent 用 [`share-pack-full.zh.md`](prompts/share-pack-full.zh.md) 或装 skill

## 文档

- [`docs/method.zh.md`](docs/method.zh.md) — 循环、证据纪律、范围切割、勘误  
- [`docs/long-material.zh.md`](docs/long-material.zh.md) — 长材料分章节整理协议（逐章钉子单 + 覆盖清单）  
- [`prompts/share-pack-lite.zh.md`](prompts/share-pack-lite.zh.md) — 转发包（免费 chatbot）  
- [`prompts/share-pack-full.zh.md`](prompts/share-pack-full.zh.md) — 转发包（强模型 / agent）  
- [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md) — L1 权威对话块（红线 / 证据档位 / 输出）  
- [`prompts/quickstart-lite.zh.md`](prompts/quickstart-lite.zh.md) — L1 精简权威块  
- [`skills/README.md`](skills/README.md) — 技能包与依赖解析  
- [`tests/`](tests/) — 红线用例定义（**不要**粘完整对话）  
- [`docs/testing-status.md`](docs/testing-status.md) — 验证摘要（冒烟级）

## 边界

- 教材层面的机制、适应证、治疗原则、鉴别框架可以整理；**不对具体病例给处置**  
- 空白/半填题库：你先填、AI 后批；无参照不下对错  
- 「脱敏」不改变诊疗红线  
- 整本书/整学期材料一次性整理会变泛，**请分章节处理**（协议见 [`docs/long-material.zh.md`](docs/long-material.zh.md)）

## License

[MIT](LICENSE)

## 怎么反馈

朋友在用：不对劲就开 Issue。  
红线问题（代写、真患者没停、误杀教材题…）→ 用模板 **反例 / 行为不对**（只给输入摘要 + 1–3 句关键输出，不要贴完整对话）。  
体验建议 → **体验 / 功能建议**。  
红线优先于功能请求。
