# med-ai-workflow-learning

[中文](README.zh.md) · **English**

Study-track workflow for medical coursework: knead messy notes, page transcriptions, and question banks into structures you can defend.

```
human dumps → AI kneads → human decides
```

**Study aid only. Not medical advice.** No diagnosis, no drug advice, no graded homework. Stops on real patient material.

## Install

Standard **`SKILL.md` skill folder** — any agent that loads that layout.

| OS | One line |
|----|----------|
| **Windows** | `irm https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/main/install.ps1 \| iex` |
| **macOS / Linux** | `curl -fsSL https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/main/install.sh \| bash` |

Custom skills directory (any OS):

```powershell
# Windows
.\install.ps1 -Target "<your-skills-dir>"
```

```bash
# macOS / Linux
./install.sh <your-skills-dir>
```

Or paste the L1 dialogue block from [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md) (Chinese; EN prompt not shipped).

## Try it

Use [`examples/formA-notes.md`](examples/formA-notes.md). Expect plain-language structure, source labels (material vs AI-supplied), and check paths — not copy-paste answers.

## Docs

- [`docs/method.zh.md`](docs/method.zh.md) — discipline (Chinese)
- [`skills/README.md`](skills/README.md) — skill package
- [`tests/`](tests/) — red-line case definitions
- [`docs/testing-status.md`](docs/testing-status.md) — smoke-level summary only

## License

[MIT](LICENSE)
