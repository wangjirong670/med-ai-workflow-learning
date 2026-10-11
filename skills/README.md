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
- 冒烟样例（1 次，人工套规则，**非**自动加载验证）：[`../tests/results/skill-behavior-B-2026-10-12.md`](../tests/results/skill-behavior-B-2026-10-12.md)

## 安装 / 加载（MiMo SKILL.md）

依赖解析（详见 skill 内「版本钉子与依赖解析」）：

1. **开发模式（优先）**：能读到仓内 `prompts/quickstart.zh.md` / `docs/method.zh.md` → 用权威源。  
2. **发布模式（回退）**：只安装了 skill 文件夹 → 用自带 `references/snapshot/`（脚本生成，含 MANIFEST sha256）。  
3. **缺失**：两者都无 → 明说缺文件，**禁止**假装已按规则执行。

**全局安装可以独立跑（走快照）**，但快照可能落后于权威 prompt；有仓时优先权威源。  
prompt 变更后请运行 `skills/med-study-knead/scripts/sync_from_prompt.py` 重新生成快照。

诊断解析模式（dev / release / missing）：

```powershell
python skills/med-study-knead/scripts/check_resolve.py --self-test
python skills/med-study-knead/scripts/check_resolve.py --root <repo-or-any-root>
```

### 项目内（推荐）

工作目录在本仓或其子目录时，把 skill 放进项目技能根：

```text
<repo>/skills/med-study-knead  →  <repo>/.mimocode/skills/med-study-knead
```

PowerShell（把 `<repo>` 换成你的本地仓路径）：

```powershell
$repo = "<path-to-repo>"   # 例：<path-to-repo>
New-Item -ItemType Directory -Force -Path "$repo/.mimocode/skills" | Out-Null
Copy-Item -Recurse -Force "$repo/skills/med-study-knead" "$repo/.mimocode/skills/med-study-knead"
```

### 用户级

对所有会话可见；仍建议在本仓工作目录下使用，以便解析 prompt 路径：

```powershell
$repo = "<path-to-repo>"
$skills = Join-Path $HOME ".config/mimocode/skills/med-study-knead"
# Windows 典型：C:\Users\<you>\.config\mimocode\skills\med-study-knead
Copy-Item -Recurse -Force "$repo/skills/med-study-knead" $skills
```

加载后：自然语言触发（见上）或 `/med-study-knead`。引擎重启或新会话后生效。

### 验证是否真加载

1. 新会话里说「帮我揉一下这份乱笔记」，确认走学习向工作流（人话默认、红线在）。  
2. 若输出像普通聊天，检查 skill 是否在技能根、名称是否 `med-study-knead`、是否已重启会话。  
3. 详见 `docs/testing-status.md` 与 `tests/results/`（catalog/依赖解析已有冒烟记录）。

## 约束

- 不与 `prompts/quickstart.zh.md` 规则分叉  
- 不写诊疗/用药；无「转临床轨」产品承诺  
- 测试口径：冒烟/单次，禁止写「红线通过」  
- 临床向 skill 不在本仓  

## 路线

- ~~阶段 B~~ **2026-10-12 已做**：`scripts/sync_from_prompt.py` 生成 `references/snapshot/`（MANIFEST 含 sha256）；SKILL 双模式依赖；集成冒烟见 `tests/results/`  
