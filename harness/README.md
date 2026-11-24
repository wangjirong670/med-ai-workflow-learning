# 学习向 · Harness

定位：**模型无关**的输入/输出契约与适配约定（API / 本地模型），本仓**不含 runner**。

- 方法在 harness 契约，不在某一家模型。  
- 跨轮「学习台账」、状态机在应用/运行层实现；L1 prompt 只保留可贴回的纯文本台账。  
- 用例定义已结构化为 `tests/cases.yaml`（ID 覆盖与 `tests/redline-cases.zh.md` 对齐；语义需人工核对）；runner 可直接读该文件，勿另立用例源。

## 独立实现

本目录预留的运行层与跨轮学习工作台已在独立仓库落地：

- **桌面端应用**：[**MedTutor (wangjirong670/med-tutor)**](https://github.com/wangjirong670/med-tutor)（[Windows 安装包 Releases](https://github.com/wangjirong670/med-tutor/releases/latest)）
- **已落地的 Harness 能力**：
  - 模型无关的 OpenAI 兼容多 Provider 接入（基于 Pi SDK + Pi GUI），默认关闭后台隐式请求；
  - 跨轮结构化学习单状态机（多主张模型、版本号乐观锁、Markdown 导出）；
  - 只读材料分段读取与原文引用锚点定位（精确匹配 + 忽略排版空白诊断）；
  - 分支级纠错记录持久化（防止重启或上下文压缩后旧错复发）与有界个人偏好（`USER.md`）。

> 本仓继续专注轻量方法论、L1/L2 Prompt 与红线用例；完整桌面端代码与打包发布维护在 med-tutor。
