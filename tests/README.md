# tests

红线与行为用例**定义**在 [`redline-cases.zh.md`](redline-cases.zh.md)（[en](redline-cases.en.md)）。

**贡献反例**：开 Issue 或 PR，只带「输入 → 期望 / 实际」摘要（合成材料）。  
**不要**粘贴完整对话转写、本机路径、界面截图。
**记录建议**：同一用例 ≥2 次；中英不一致以 zh 详记为准。

原版逐次记录由维护者本地保存；仓内仅公开脱敏摘要（[`docs/results.md`](../docs/results.md)）。

## 工程回归（不等于模型行为通过）

先安装校验依赖：`python -m pip install -r skills/med-study-knead/scripts/requirements.txt`（完整仓库）；独立包使用 `<skill>/scripts/requirements.txt`。

完整仓库需要 Python 3.10+ 和 PyYAML，以下检查不需要模型 API：

```bash
python -m unittest discover -s tests -p "test_*.py" -v
python scripts/sync_share_packs.py --check
python skills/med-study-knead/scripts/sync_from_prompt.py --check
```

工程测试在临时目录验证：清单/源/快照完整性、损坏时的回退或停止、只读检查、许可证、分享包与用例 ID 覆盖；POSIX Bash 可用时还验证首次安装、更新、复制失败与替换失败恢复。PowerShell 可用时验证解析、只读预览和安装更新；缺少运行时会明确跳过，不能记为通过。

修改规则后运行 `python scripts/sync_share_packs.py`，再运行 `python skills/med-study-knead/scripts/sync_from_prompt.py` 更新生成物。`--check` 不创建或更新包文件。

行为定义在中英 Markdown 与 `cases.yaml` 中共 38 个 ID。工程测试只校验 ID 覆盖，不声称自动证明自然语言语义一致。D6 初轮未出现错误时，勘误分支记未覆盖；历史 W 保留，不重写历史数据。

新版协议仍需在干净会话中分别测试完整 prompt、Lite、独立 Skill 与 MCP 交付，并与无 Skill 基线比较。不得把旧冒烟记录或本页工程测试表述为新版模型通过率。

2026-10-29 定向修订：固定逐轮输入见 `behavior-scenarios.json`（38个ID、51个场景；未运行），执行范围与判分分支见 `../docs/behavior-followup-2026-10-29.md`。每次运行记录实际Git提交；同模型/同宿主对照暂略过，不将不同配置的结果当成入口因果差异。D6必须分别记录范围、结案与勘误断言。
