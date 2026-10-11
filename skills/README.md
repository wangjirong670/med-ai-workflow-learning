# 学习向 · Skills（L2 · 初版可用）

把 [`../prompts/quickstart.zh.md`](../prompts/quickstart.zh.md) 的方法论打成可被 agent 加载的 skill 包。  
**权威源仍是 prompt**；skill 只做薄封装，冲突时以 prompt 为准。

## 已发布

| Skill | 路径 | 用途 |
|-------|------|------|
| `med-study-knead` | [`med-study-knead/`](med-study-knead/) | 学习向课业整理：乱笔记/书页/题库 → 可辩护结构；默认人话 |

- 触发示例：整理笔记 / 帮我揉一下 / 学习钉子 / 自测卡 / 我填了 X 对吗  
- 红线摘要在 SKILL.md；E 表、坏输出表等外置到 `prompts/quickstart.zh.md` 对应节  
- 版本钉子：`prompts/quickstart.zh.md`（v3.1+）· `docs/method.zh.md`  
- 冒烟样例（1 次，人工套规则，**非**自动加载验证）：[`../docs/skill-smoke-formA-1x.md`](../docs/skill-smoke-formA-1x.md)

## 安装 / 加载（MiMo SKILL.md）

Skill 设计为与仓内 prompt 同用（需要能读到 `prompts/quickstart.zh.md`）。  
**全局安装 ≠ 可在任意项目独立跑**：缺依赖时应说明缺失，不得假装已执行对应规则。

### 项目内（推荐）

工作目录在本仓或其子目录时，把 skill 放进项目技能根：

```text
<repo>/skills/med-study-knead  →  <repo>/.mimocode/skills/med-study-knead
```

PowerShell（把 `<repo>` 换成你的本地仓路径）：

```powershell
$repo = "<path-to>/med-ai-workflow"   # 例：C:/Users/<you>/XiaomiMiMoProjects/med-ai-workflow
New-Item -ItemType Directory -Force -Path "$repo/.mimocode/skills" | Out-Null
Copy-Item -Recurse -Force "$repo/skills/med-study-knead" "$repo/.mimocode/skills/med-study-knead"
```

### 用户级

对所有会话可见；仍建议在本仓工作目录下使用，以便解析 prompt 路径：

```powershell
$repo = "<path-to>/med-ai-workflow"
$skills = Join-Path $HOME ".config/mimocode/skills/med-study-knead"
# Windows 典型：C:\Users\<you>\.config\mimocode\skills\med-study-knead
Copy-Item -Recurse -Force "$repo/skills/med-study-knead" $skills
```

加载后：自然语言触发（见上）或 `/med-study-knead`。引擎重启或新会话后生效。

### 验证是否真加载

1. 新会话里说「帮我揉一下这份乱笔记」，确认走学习向工作流（人话默认、红线在）。  
2. 若输出像普通聊天，检查 skill 是否在技能根、名称是否 `med-study-knead`、是否已重启会话。  
3. 当前仓库只有**人工** formA 冒烟；**Agent 自动加载 / 依赖解析**的集成测试未做（见 `docs/testing-status.md`）。

## 约束

- 不与 `prompts/quickstart.zh.md` 规则分叉  
- 不写诊疗/用药；无「转临床轨」产品承诺  
- 测试口径：冒烟/单次，禁止写「红线通过」  
- 临床向 skill 不在本仓  

## 路线（已拍板，未实施）

- **阶段 B**：脚本从 prompt 生成 `references/` 发布快照（带来源版本），支持脱离仓内路径的打包安装  
- **阶段 C**：测试结果进 `tests/results/`；用例定义与运行记录分离  
