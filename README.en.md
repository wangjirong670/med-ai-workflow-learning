# med-ai-workflow-learning

[中文](README.zh.md) · **English**

Study-track workflow for medical coursework: knead messy notes, page transcriptions, and question banks into structures you can defend.

```
human dumps → AI kneads → human decides
```

**Study aid only. Not medical advice.** No diagnosis, no drug advice, no graded homework. Stops on real patient material.

## Before / after (synthetic)

A fictional messy note about a made-up herb「雾岭草」becomes a pin list with source labels (material vs AI-supplied / pending check) and an "not yet trustworthy" section — see the full example in [README.zh.md](README.zh.md). All content is synthetic, not textbook text.

## Install

Install validation dependencies first: `python -m pip install -r skills/med-study-knead/scripts/requirements.txt` in a checkout, or `<skill>/scripts/requirements.txt` for a standalone package.

Installation requires Python 3.10+ and PyYAML (`python` / `python3`) to verify the staged standalone package before replacing an existing installation.

Standard **`SKILL.md` skill folder**. Discovery paths and permissions depend on the host; cross-agent loading is not comprehensively tested.

Clone the repository, inspect the scripts, then install into your agent’s configured skills directory:

```bash
git clone https://github.com/wangjirong670/med-ai-workflow-learning.git
cd med-ai-workflow-learning
```

| OS | Command after review |
|----|----|
| Windows | `powershell -File .\install.ps1 -Target "<your-skills-dir>"` |
| macOS / Linux | `bash ./install.sh "<your-skills-dir>"` |

Read the script before you run it.

Custom skills directory (any OS):

```powershell
# Windows
.\install.ps1 -Target "<your-skills-dir>"
```

```bash
# macOS / Linux
./install.sh <your-skills-dir>
```

Or paste the L1 dialogue block from [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md) (Chinese; EN prompt not shipped). **Forwardable packs:** free chatbots → [`share-pack-lite.zh.md`](prompts/share-pack-lite.zh.md); strong models/agents → [`share-pack-full.zh.md`](prompts/share-pack-full.zh.md). Dialogue rules live only in `quickstart.zh.md` / `quickstart-lite.zh.md`.

## Try it

Use [`examples/formA-notes.md`](examples/formA-notes.md). Expect: one-line status → study-nail list (main deliverable; material vs AI-supplied labels) → not-yet-trustworthy points → your decisions — not copy-paste answers.

Prompts: free chatbots use [`share-pack-lite.zh.md`](prompts/share-pack-lite.zh.md); stronger models/agents use [`share-pack-full.zh.md`](prompts/share-pack-full.zh.md) or the skill. Long books/semesters should be processed chapter by chapter ([`docs/long-material.zh.md`](docs/long-material.zh.md)).

## Docs

- [`docs/method.zh.md`](docs/method.zh.md) — discipline (Chinese)
- [`skills/README.md`](skills/README.md) — skill package
- [`tests/`](tests/) — red-line case definitions
- [`docs/testing-status.md`](docs/testing-status.md) — smoke-level summary only

## License

[MIT](LICENSE)
