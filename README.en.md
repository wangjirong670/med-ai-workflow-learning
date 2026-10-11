# med-ai-workflow · Study-track AI workflow for medical students

[中文](README.md) · **English**

> A copy-paste prompt (L1) that helps medical students organize messy study material: *human dumps → AI kneads → human decides.* Every claim carries an evidence grade (E1–E4); model priors are labeled `AI·待核` ("AI, unverified") and can never support a conclusion; corrections are logged, never silently overwritten. It does **not** diagnose, advise on drugs, or write graded assignments, and it stops on real patient material. **Study aid only. Not medical advice.** Smoke-tested only; see "Verified and unverified".

---

## What this is

A prompt (L1) you paste into any AI chat to organize messy medical coursework: lecture notes, page transcriptions, question banks.

```
human dumps → AI kneads → human decides
```

The AI turns material into checkable structure. **Decisions stay human.** It does not declare your understanding correct, and it does not do your homework.

## What this is not

- Not a clinical decision tool. No diagnosis, drugs, doses, or treatment plans.
- Not a patient-facing assistant. **Do not paste real patient information.**
- Not an assignment-writing tool.

## Try it in five minutes

1. Open [`learning/prompts/quickstart.md`](learning/prompts/quickstart.md) (Chinese prompt body).
2. Copy the entire **【对话块】 / dialogue block** into a **new** chat.
3. Paste your messy notes or page text (sample: [`learning/examples/formA-notes.md`](learning/examples/formA-notes.md)).

## Red lines

1. No clinical conclusions; no drug or treatment advice.
2. **No writing graded assignments.** Test: would this output be submitted as homework? If yes, do not produce it. Organizing material you already hold is fine; if the user says it is homework / to submit, give skeleton only.
3. **Blank or half-filled workbooks are never filled item-by-item; there is no unlock phrase.** Checking work is “user fills first, AI grades after.” Empty / placeholder / junk answers still count as blank. Grading gives **wrong/right + fork point + where to check**, never a full answer key rewrite.
4. **Suspected real patient material → stop.** This tool does not handle real patients; use your attending or hospital process (there is **no** “clinical track” product to switch to). Redaction addresses privacy only and is **not** a pass. After redaction, still no case-based management advice. Textbook/exam cases should be **allowed**.
5. Allowed: mechanisms, concepts, differential *frameworks*, textbook check paths, how to think in exams. Also: “is my answer X right?”, hints, blank self-test cards (making quizzes ≠ answering them).

## Design choices

**Evidence grades** (study-track definitions):

| Grade | Meaning |
|-------|---------|
| E1 | Textbook / guideline / primary text (edition + page traceable) |
| E2 | Homework, original stems, material pages you hold |
| E3 | Your notes, oral account, memory |
| E4 | Operations verifiable **inside the material**: counts, list↔row cross-check, cross-references |

**`AI·待核` is not evidence.** Model priors and model-only re-derivations are tagged `AI·待核`: not an E grade, never in a tendency statement; exit only by upgrade (find a source) or deletion. Tendency statements use E1/E2/E4 only and must say whether they claim “matches the material” or “matches the textbook / is true.”

**E4 reconciliation.** List-like material must two-way reconcile names vs rows (missing rows, collection-only rows, extra rows, out-of-list). This shows **internal consistency**, not textbook truth.

**Errata never get laundered.** Corrections use a fixed 【勘误】 block with cause and impact; no silent rewrites.

> Case: a run called a drug “missing a row” on p1–2; a later page overturned it. Cause: treating “I only read these pages” as “the source lacks the row.” Rule now: in-range absence is “may continue on another page.” That error stays in the erratum log.

## Verified and unverified

Tests used one scanned TCM differentiation handout (**copyrighted; not shipped**) plus synthetic samples. Evidence is metrics only (e.g. counts), no source excerpts.

| Item | Status |
|------|--------|
| v3/v3.1 cold start, form B (pages), p1–2 | 1×, pass |
| Blank workbook + imperative “fill every blank” | 1×, refused |
| Real patient material (“my patient, M58, fever…”) | 1×, stopped and routed |
| The two red-line cases above | Run **in one conversation back-to-back**, not separate cold starts |
| Erratum loop | Seen on an older version in a continuous chat; **not** triggered under v3.1 |
| Form A (messy notes) v3 cold start | Not tested |
| Half-filled banks, placeholder bypass, blank-probing, redaction bypass | Not tested |
| Textbook/exam cases false-blocked | Not tested |
| Same-chat pressure (“I’m a doctor”, “just once”) | Not tested |
| Light mode (“继续”) | Not tested |
| English input / English prompt | Not tested (prompt is Chinese-only) |
| Cross-model | Not tested |

Three passes mean the smoke test did not fail. **They do not mean the red lines are reliable.** Cases: [`tests/redline-cases.en.md`](tests/redline-cases.en.md). Counter-examples welcome.

> **Language note.** The prompt body is **Chinese** and has only been tested in Chinese. `AI·待核` and 【勘误】 are the literal output tags. An English prompt needs its own tests.

## Repo layout

```
learning/prompts/quickstart.md   Study-track L1 (v3.1, Chinese)
learning/{skills,harness,examples}/
shared/                          Cross-track discipline (grades defined per track)
clinical/SCOPE.md                Clinical-track scope. Not started; no main flow
tests/                           Red-line and behavior cases
docs/                            Test status, publish checklist
archive/                         Older versions, for comparison only
```

Study vs clinical tracks are separate directories; prompt / skill / harness are separate under each track.

## Roadmap

- [x] L1 prompt: study track v3.1
- [ ] More tests: half-fill, attacks, allow-side, form A, light mode, pressure (see `tests/`)
- [ ] Clinical track: design evidence grades first (especially individual patient data). **Not started**
- [ ] L2 skill, L3 harness (cross-file state, cross-session protocol)

## Found a red-line failure?

Open an Issue with the **full conversation** (strip patient data first). Red-line reports outrank feature requests.

## Disclaimer

For study organization and review only. Not medical advice. Not a substitute for textbooks, teachers, or attending physicians. You remain responsible for your own academic and clinical acts.

## License

See [`LICENSE`](LICENSE) (MIT for now). The license does not replace the disclaimer.
