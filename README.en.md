# med-ai-workflow-learning · Study-track AI workflow for medical students

[中文](README.zh.md) · **English**

> A copy-paste prompt (L1) to organize messy medical coursework: *human dumps → AI kneads → human decides.* Claims carry evidence grades (E1–E4); model priors are tagged `AI·待核` ("AI, unverified") and never support conclusions; corrections use a fixed erratum block. No diagnosis, no drug advice, no graded homework. Stops on real patient material. **Study aid only. Not medical advice.**

---

## What this is

An L1 prompt you paste into any AI chat to organize lecture notes, page transcriptions, and question banks.

```
human dumps → AI kneads → human decides
```

## What this is not

- Not a clinical decision tool  
- Not patient-facing (do **not** paste real patient data)  
- Not an assignment writer  

**Clinical track** lives in a sibling repo: [`med-ai-workflow-clinical`](https://github.com/wangjirong670/med-ai-workflow-clinical) (not started; scope only).

## Try it

1. Open [`prompts/quickstart.zh.md`](prompts/quickstart.zh.md) (prompt body is **Chinese-only**, tested in Chinese).  
2. Paste the **【对话块】 / dialogue block** into a **new** chat.  
3. Add your notes (sample: [`examples/formA-notes.md`](examples/formA-notes.md)).

## Red lines

1. No clinical conclusions; no drug or treatment advice.  
2. **No graded homework** (if it would be submitted, do not write it).  
3. **Blank/half-filled workbooks are never filled**; no unlock phrase; grade only after the user fills; never rewrite a full answer key.  
4. **Suspected real patient material → stop**; use attending / hospital process.  
5. Allowed: mechanisms, concepts, differentials as frameworks, textbook check paths, “is my answer X?”, hints, blank self-test cards.

## Method

See [`docs/method.zh.md`](docs/method.zh.md) (Chinese). Summary: E1–E4 · `AI·待核` is not evidence · list↔row reconciliation · range-slicing (in-range absence ≠ missing) · errata never laundered.

## Verified and unverified

One scanned TCM handout (**not shipped**) + synthetic samples.

| Item | Status |
|------|--------|
| Form B cold start (pages) | 1×, pass |
| Blank workbook refusal | 1×, pass |
| Real patient stop | 1×, pass |
| Two red-line cases | Same chat back-to-back, not separate cold starts |
| Erratum loop | Seen on older revision only |
| Form A / half-fill / placeholders / allow-side / light mode / pressure / English prompt | Not tested |

Cases: [`tests/redline-cases.en.md`](tests/redline-cases.en.md). Counter-examples welcome.

## Layout

```
prompts/quickstart.zh.md   Main L1 (Chinese)
prompts/quickstart.en.md   English note (body not translated)
docs/                      method, test status, publish checklist
tests/                     red-line cases (zh + en)
examples/                  synthetic samples
skills/med-study-knead/    L2 study-track skill (usable)
harness/                   not started
```

## Roadmap

- [x] L1 prompt: study track  
- [ ] More tests (see `tests/`)  
- [x] L2 skill: [`skills/med-study-knead`](skills/med-study-knead/) (install: [`skills/README.md`](skills/README.md))  
- [ ] L3 harness  
- [ ] Clinical track → sibling repo  

## Red-line failure?

Open an Issue with the **full conversation** (strip patient data). Red lines outrank features.

## Disclaimer

For study organization only. Not medical advice.

## License

[LICENSE](LICENSE) (MIT).

