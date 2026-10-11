# 学习向 · Skills（L2 · 可用）

把 `../prompts/quickstart.zh.md` 的方法论打成可被 agent 加载的 skill 包。  
**权威源仍是 prompt**；skill 只做薄封装，冲突时以 prompt 为准。

## 已发布

| Skill | 路径 | 用途 |
|-------|------|------|
| `med-study-knead` | [`med-study-knead/`](med-study-knead/) | 学习向课业整理：乱笔记/书页/题库 → 可辩护结构；默认人话 |

- 触发示例：整理笔记 / 帮我揉一下 / 学习钉子 / 自测卡 / 我填了 X 对吗  
- 红线摘要在 SKILL.md；E 表、坏输出表等外置到 `prompts/quickstart.zh.md` 对应节  
- 版本钉子：`prompts/quickstart.zh.md`（v3.1+）· `docs/method.zh.md`  
- 冒烟样例（1 次，非红线全面通过）：[`../docs/skill-smoke-formA-1x.md`](../docs/skill-smoke-formA-1x.md)

## 安装 / 加载（MiMo SKILL.md）

skill 设计为与仓内 prompt 同用（需能读到 `prompts/quickstart.zh.md`）。

**项目内（推荐）**——工作目录在本仓或子目录时：

```text
# 将 skill 放到项目技能根（已存在则覆盖）
skills/med-study-knead  →  <repo>/.mimocode/skills/med-study-knead
```

PowerShell 示例：

```powershell
$repo = "C:\Users\<you>\XiaomiMiMoProjects\med-ai-workflow"
New-Item -ItemType Directory -Force -Path "$repo\.mimocode\skills" | Out-Null
Copy-Item -Recurse -Force "$repo\skills\med-study-knead" "$repo\.mimocode\skills\med-study-knead"
```

**用户级**——对所有会话可见（仍建议在本仓工作目录下用，以便读到 prompt）：

```powershell
Copy-Item -Recurse -Force `
  "C:\Users\<you>\XiaomiMiMoProjects\med-ai-workflow\skills\med-study-knead" `
  "C:\Users\<you>\.config\mimocode\skills\med-study-knead"
```

加载后：自然语言触发（见上）或 `/med-study-knead`。引擎重启或新会话后生效。

## 约束

- 不与 `prompts/quickstart.zh.md` 规则分叉  
- 不写诊疗/用药；无「转临床轨」产品承诺  
- 测试口径：冒烟/单次，禁止写「红线通过」  
- 临床向 skill 不在本仓
