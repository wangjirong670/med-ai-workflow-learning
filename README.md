# med-ai-workflow-learning

**学习向**课业整理工作流：把你乱扔的医学/药学笔记、书页转写、题库，揉成**可辩护**的复习结构。  
*Turn messy medical coursework into structures you can defend.*

```
人乱扔 → AI 揉 → 人拍板
```

**Study aid only. Not medical advice.** 不诊断、不给药、不代写作业、不处理真实患者。

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

| | |
|--|--|
| 中文说明 | [README.zh.md](README.zh.md) |
| English | [README.en.md](README.en.md) |
| 许可证 | [MIT](LICENSE) |

## Install

任意能加载 **`<skills目录>/<name>/SKILL.md`** 的 agent 都可用（不限定某一家产品）。

| OS | 一条命令 |
|----|----------|
| **Windows** | `irm https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/v0.1.0/install.ps1 \| iex` |
| **macOS / Linux** | `curl -fsSL https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/v0.1.0/install.sh \| bash` |

建议先阅读脚本再执行。Read the script before you run it.

指定技能目录（任意 OS）：

```powershell
# Windows
.\install.ps1 -Target "<your-skills-dir>"
```

```bash
# macOS / Linux
./install.sh <your-skills-dir>
```

也可直接使用纯文本 L1：复制 [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md) 的【对话块】到任意对话。

## Try it

粘贴示例 [`examples/formA-notes.md`](examples/formA-notes.md)，或在已装 skill 的会话里说：

> 帮我揉一下这页药理课业笔记（不是作业，要自己写）

期望输出：一句话状态 → 学习钉子单（主交付；标材料/我补的）→ 还不能当真 → 拍板；**不是**可抄答案。

提示词：免费 chatbot 用 [`prompts/quickstart-lite.zh.md`](prompts/quickstart-lite.zh.md)；强模型和 agent 用完整版 [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md)。

## What's inside

| 路径 | 是什么 |
|------|--------|
| [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md) | L1 一键提示词（主入口） |
| [`skills/med-study-knead/`](skills/med-study-knead/) | L2 可加载技能包（标准 SKILL.md） |
| [`docs/method.zh.md`](docs/method.zh.md) | 方法纪律（证据、勘误、范围切割） |
| [`examples/`](examples/) | 合成示例 |
| [`tests/`](tests/) | 红线用例定义（贡献反例用） |

## Limits

- 学习整理，不是诊疗、不是患者咨询、不是作业代写  
- 真实患者材料请走上级医师 / 院内流程  
- 整本书/整学期材料一次性整理会变泛，**请分章节处理**（协议见 [`docs/long-material.zh.md`](docs/long-material.zh.md)）  
- 验证属冒烟级，**不能**理解成「红线全面通过」——摘要见 [`docs/testing-status.md`](docs/testing-status.md)

## License

[MIT](LICENSE)

## Feedback

Open an Issue. Red-line counterexamples use the **反例** template (summary only, no full chats). Red lines outrank features.
