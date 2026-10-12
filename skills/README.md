# 学习向 · Skills（L2 · 初版可用）

把 [`../prompts/quickstart.zh.md`](../prompts/quickstart.zh.md) 的方法论打成可被 agent 加载的 skill 包。  
**权威源仍是 prompt**；skill 只做薄封装，冲突时以 prompt 为准。

## 一键安装（Agent 通用）

技能包是标准 **`<目录>/<skill>/SKILL.md`** 布局，**凡是支持这种 skill 目录的 agent 都能用**（不限 MiMo / Claude）。

**Windows（PowerShell）**

```powershell
irm https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/main/install.ps1 | iex
```

**macOS / Linux**

```bash
curl -fsSL https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/main/install.sh | bash
```

**自定义目标（推荐给任意 agent）**

```powershell
.\install.ps1 -Target "<你的 skills 目录>"
# 例：.\install.ps1 -Target "$HOME/.config/myagent/skills"
```

```bash
./install.sh ~/.config/myagent/skills
```

脚本会：
1. 使用本地 `skills/med-study-knead/`（没有则从 GitHub 拉 zip）
2. 拷贝到默认通用目录 `~/.skills/`（便携包）
3. 自动探测已存在的常见 skills 根（项目/用户级），不存在则跳过；`-All` / `ALL=1` 强制写入探测列表
4. 每个目标都是：`<root>/med-study-knead/{SKILL.md, references/, scripts/}`

装完：**新开会话**，让 agent 加载 `med-study-knead`，或直接说「帮我揉一下这页药理课业笔记」。  
也可以把该文件夹 **symlink** 进你自己的技能目录。

## 已发布

| Skill | 路径 | 用途 |
|-------|------|------|
| `med-study-knead` | [`med-study-knead/`](med-study-knead/) | 学习向课业整理：乱笔记/书页/题库 → 可辩护结构；默认人话 |

- 触发示例：整理笔记 / 帮我揉一下 / 学习钉子 / 自测卡 / 我填了 X 对吗  
- 红线摘要在 SKILL.md；E 表、坏输出表等外置到 `prompts/quickstart.zh.md` 对应节  
- 版本钉子：`prompts/quickstart.zh.md`（v3.1+）· `docs/method.zh.md`  
- 冒烟样例（1 次，人工套规则，**非**自动加载验证）：[`../tests/results/skill-behavior-B-2026-10-12.md`](../tests/results/skill-behavior-B-2026-10-12.md)

## 安装说明（细节）

- 依赖解析：开发模式优先仓内 prompt；不可达则用 `references/snapshot/`；两者皆无则停用并说明缺失。  
- 诊断：`python skills/med-study-knead/scripts/check_resolve.py --self-test`  
- 同步快照：`python skills/med-study-knead/scripts/sync_from_prompt.py`（改 prompt 后必跑）

## 约束

- 不与 `prompts/quickstart.zh.md` 规则分叉  
- 不写诊疗/用药；无「转临床轨」产品承诺  
- 测试口径：冒烟/单次，禁止写「红线通过」  
- 临床向 skill 不在本仓  

## 路线

1. L1 Prompt — 可用  
2. L2 Skill — 初版可用（本页一键安装）  
3. L3 Harness — 未开工
