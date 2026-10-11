# med-ai-workflow-learning · 医学生学习向 AI 整理工作流

**中文** · [English](README.en.md)

> **EN summary.** A copy-paste prompt (L1) that helps medical students organize messy study material: *human dumps → AI kneads → human decides.* Every claim carries an evidence grade (E1–E4); model priors are labeled `AI·待核` and never support conclusions; corrections are logged, never silently overwritten. No diagnosis, no drug advice, no graded homework. Stops on real patient material. **Study aid only. Not medical advice.**

---

## 这是什么

一段可粘进任意 AI 对话的提示词（L1），整理医学课业乱材料：课堂笔记、书页转写、题库。

```
人乱扔 → AI 揉 → 人拍板
```

## 不是什么

- 不是临床决策工具  
- 不是患者咨询工具（**不要粘贴真实患者信息**）  
- 不是作业代写工具  

**临床向**在另一仓：[`med-ai-workflow-clinical`](https://github.com/wangjirong670/med-ai-workflow-clinical)（未开工，仅边界文档）。

## 一键试用

1. 打开 [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md)  
2. 复制【对话块】到**新**对话  
3. 粘贴你的乱笔记或书页（示例：[`examples/formA-notes.md`](examples/formA-notes.md)）

## 红线

1. 不给诊疗结论，不谈用药和治疗。  
2. **不代写作业**（会不会被直接提交？会就不做）。  
3. **空白/半填题库不逐空作答**，无授权解锁；「你先填、AI 后批」；不整表回写答案。  
4. **疑似真实患者材料 → 停止**；请走上级医师或院内流程。  
5. 允许：机制、概念、鉴别思路、教材核对路径、「我填了 X 对吗」、提示、出自测卡。

## 方法摘要

见 [`docs/method.zh.md`](docs/method.zh.md)。

- E1–E4 证据分级；`AI·待核` 不是证据  
- E4 名单↔条目对账（只证内部一致）  
- 范围切割：「范围内未见」≠「缺行」  
- 【勘误】不洗白  

## 验证摘要

- 模型：MiMo-V2.6-Flash（单模型）。部分批次未隔离本机 AGENTS.md。  
- 水位与逐 ID 计数只看 [`docs/testing-status.md`](docs/testing-status.md)（三态：未测 / 冒烟单次 / 冒烟×2 / 不确定）。  
- 禁止表述「红线通过」；纯 prompt / 纯 skill 分轨尚未重测。

## 仓库结构

```
prompts/quickstart.zh.md   学习向主入口（中文）
prompts/quickstart.en.md   英文说明（正文未翻译）
docs/                      方法、测试状态、发布检查
tests/                     红线用例（中英）
examples/                  合成示例
skills/med-study-knead/    学习向 L2 skill（可用）
harness/                   未开工
```

## 路线图

1. **L1 Prompt** 学习向 — 可用  
2. **L2 Skill** [`med-study-knead`](skills/med-study-knead/) — 初版可用（安装见 [`skills/README.md`](skills/README.md)）  
3. **L3 Harness** — 未开工；临床向另仓

## 发现红线失败？

请开 Issue，附**完整对话**（去掉患者信息）。红线优先于一切功能请求。

## 免责声明

用于学习整理与复习，不构成诊疗建议，不替代教材、老师或上级医师。

## 许可证

见 [LICENSE](LICENSE)（MIT）。


