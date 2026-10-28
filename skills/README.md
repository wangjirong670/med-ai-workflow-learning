# 学习向 · Skills（L2 · 初版可用）

把 [`../prompts/quickstart.zh.md`](../prompts/quickstart.zh.md) 的方法论打成可被 agent 加载的 skill 包。  
**权威源仍是 prompt**；skill 只做薄封装，冲突时以 prompt 为准。

## 从已审阅的仓库安装

先安装校验依赖：`python -m pip install -r skills/med-study-knead/scripts/requirements.txt`（完整仓库）；独立包使用 `<skill>/scripts/requirements.txt`。

标准 **`<skills目录>/med-study-knead/SKILL.md`**；目录发现和权限由宿主决定。先克隆本仓库、进入目录并阅读脚本。安装器不再下载或执行远程脚本。

### Windows（PowerShell 5+ / 7+）

```powershell
powershell -File .\install.ps1 -Target "<your-skills-dir>"
```

已 clone 本仓时：

```powershell
.\install.ps1
.\install.ps1 -Target "<your-skills-dir>"
```

### macOS / Linux

```bash
bash ./install.sh "<your-skills-dir>"
```

已 clone 本仓时：

```bash
./install.sh
./install.sh ~/.config/myagent/skills
```

### 任意 OS · 手动

把 `skills/med-study-knead/` 拷进（或 symlink 到）你的技能目录即可。

装完新开会话即可使用。

## 已发布

| Skill | 路径 | 用途 |
|-------|------|------|
| `med-study-knead` | [`med-study-knead/`](med-study-knead/) | 学习向课业整理：乱笔记/书页/题库 → 可辩护结构；默认人话 |

- 触发示例：整理笔记 / 帮我揉一下 / 学习钉子 / 自测卡 / 我填了 X 对吗  
- 红线摘要在 SKILL.md；E 表、坏输出表等外置到 `prompts/quickstart.zh.md` 对应节  
- 权威源：`prompts/quickstart.zh.md` · `docs/method.zh.md`（版本以 git 为准）  
- 公开行为验证仅有历史冒烟摘要（**非**自动加载保证）：[`../docs/results.md`](../docs/results.md)；逐次私有记录不作为可点击公开证据。

## 安装说明（细节）

- 本地依赖：源文件匹配清单才用开发模式，否则仅回退到完整性通过的快照；都不可用则停止。无工具文本/MCP 模式必须披露未机器核验，不得绕过已知失败。  
- 诊断：`python skills/med-study-knead/scripts/check_resolve.py --root .`  
- 同步快照：`python skills/med-study-knead/scripts/sync_from_prompt.py`（改 prompt / method / 长材料协议后必跑；同时复制 LICENSE）

默认只复制到 `~/.skills`（需自行配置 agent 发现路径）；`-Target` / Bash 位置参数可指定目录，`-All` / `ALL=1` 才显式安装到多处。新包先暂存，复制失败保留旧包，替换失败尝试恢复；同名目录中的本地定制在成功更新后会被替换，请先备份。PowerShell 可先加 `-PrintOnly` 预览。

本地维护脚本需要 Python 3.10+。Agensi MCP 使用文本快照与文件索引，不执行这些依赖本地目录结构的脚本。独立包包含 MIT 版权与许可全文，见 `med-study-knead/LICENSE`。

## 约束

- 不与 `prompts/quickstart.zh.md` 规则分叉  
- 不写诊疗/用药；无「转临床轨」产品承诺  
- 测试口径：冒烟/单次，禁止写「红线通过」  
- 临床向 skill 不在本仓  

## 路线

1. L1 Prompt — 可用  
2. L2 Skill — 初版可用（本页一键安装）  
3. L3 Harness — 未开工
