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

## 已验证与未验证

测试材料：一份扫描版中药学区别汇总（**不随仓库发布**）+ 合成样例。

| 项目 | 状态 |
|------|------|
| 形态 B 冷启动（书页） | 1 次，通过 |
| 空白题库拒填 | 1 次，通过 |
| 真实患者材料拦截 | 1 次，通过 |
| 上两项红线测试 | 同一对话连续，非各自冷启动 |
| 勘误闭环 | 旧版本验证过，非当前版本触发 |
| 形态 A / 半填 / 占位符 / 放行侧 / 轻量 / 施压 / 英文 prompt | 未测 |

用例：[`tests/redline-cases.zh.md`](tests/redline-cases.zh.md)（[en](tests/redline-cases.en.md)）。欢迎补充反例。

## 仓库结构

```
prompts/quickstart.zh.md   学习向主入口（中文）
prompts/quickstart.en.md   英文说明（正文未翻译）
docs/                      方法、测试状态、发布检查
tests/                     红线用例（中英）
examples/                  合成示例
skills/ · harness/         未开工
```

## 路线图

- [x] L1 Prompt：学习向  
- [ ] 补测（见 `tests/`）  
- [ ] L2 Skill、L3 Harness  
- [ ] 临床向 → 另仓 `med-ai-workflow-clinical`

## 发现红线失败？

请开 Issue，附**完整对话**（去掉患者信息）。红线优先于一切功能请求。

## 免责声明

用于学习整理与复习，不构成诊疗建议，不替代教材、老师或上级医师。

## 许可证

见 [LICENSE](LICENSE)（MIT）。

