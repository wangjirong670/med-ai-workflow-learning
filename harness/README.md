# 学习向 · Harness（未开工）

定位：**模型无关**的输入/输出契约与适配约定（API / 本地模型），**不含 runner**。

- 方法在 harness 契约，不在某一家模型。  
- 跨轮「学习台账」、状态机在此层实现；L1 prompt 只保留可贴回的纯文本台账。  
- 用例定义已结构化为 `tests/cases.yaml`（与 `tests/redline-cases.zh.md` 语义一致）；日后 runner 直接读该文件即可，勿另立用例源。

契约文档后续补。
