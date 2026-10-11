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

口径三态（**禁止**写「红线通过」）：**未测** / **冒烟单次**（≥1 次，不可靠）/ **冒烟×2**；另有**不确定**（如 D6 需诱错剧本）。

测试材料：一份扫描版中药学区别汇总（**不随仓库发布**）+ 合成样例。驱动与环境见 [`docs/testing-status.md`](docs/testing-status.md)。

| 项目 | 状态 |
|------|------|
| 形态 B 冷启动（书页，T1） | 冒烟单次 |
| 空白题库拒填（A1） | 冒烟单次 |
| 半填题库（A3） | 冒烟单次 |
| 占位符绕过（A4） | 冒烟单次 |
| 脱敏绕行（A9） | 冒烟单次 |
| 连续施压（A10） | 冒烟单次 |
| 批改/提示/自测卡（B1–B3） | 各冒烟单次 |
| 教材病例放行（C1，冷启动） | 冒烟单次 |
| 对账≠正确（D4） | 冒烟单次 |
| 人话模式 + 审计反向（E4） | 冒烟×2 |
| 真实患者材料拦截（A7） | 冒烟单次 |
| 勘误闭环（D6） | **不确定**（切割挡住假缺行，需诱错） |
| A2/A5/A6/A8/A11 · B4 · C2 · D1–D3/D5/D7–D9 · E1–E3 · 英文 prompt | 未测 |
| 上列已过项再 ×2 记通过率 | 待补 |
| L2 Skill 规格校验 + formA 人工冒烟 | 冒烟单次（非自动加载验证） |

用例：[`tests/redline-cases.zh.md`](tests/redline-cases.zh.md)（[en](tests/redline-cases.en.md)）。欢迎补充反例。结果汇总：[`docs/testing-status.md`](docs/testing-status.md)。

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

- [x] L1 Prompt：学习向  
- [ ] 补测（见 `tests/`）  
- [x] L2 Skill：[`skills/med-study-knead`](skills/med-study-knead/)（安装见 [`skills/README.md`](skills/README.md)）  
- [ ] L3 Harness  
- [ ] 临床向 → 另仓 `med-ai-workflow-clinical`

## 发现红线失败？

请开 Issue，附**完整对话**（去掉患者信息）。红线优先于一切功能请求。

## 免责声明

用于学习整理与复习，不构成诊疗建议，不替代教材、老师或上级医师。

## 许可证

见 [LICENSE](LICENSE)（MIT）。


