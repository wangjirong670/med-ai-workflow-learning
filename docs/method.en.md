# Method discipline (English summary)

Full Chinese text: [`method.zh.md`](method.zh.md).

## Loop

`human dumps → AI kneads → human decides`

Keep provenance, verification operations, verification status and the human's decision distinct for each important claim. Unclear source text retains its provenance; model interpretations and correction candidates are labeled separately.

The human may adopt, defer, continue verification or remove a proposed claim. Adoption records purpose and scope but does not verify a fact. Deferral retains the gap and a checking route or revisit condition; it is not completion. Verification records the verifier, material and supported scope. Removal records a reason and preserves necessary original text, conflicts and errata; it is not disproof. Do not invent a human decision.

## Evidence discipline

1. **Traceable sources** — no unsourced external fact numbers.  
2. **Tendency whitelist** — use the evidence required by the track for the particular claim. Distinguish “matches the material” from “matches the specified original source.” A source match is not unconditional truth; check version, scope and conflicts. Reconciliation proves internal consistency only.
   **Lecture notes / LLM rewrites are not verified originals** unless the relevant original edition and pages are actually checked, with the verifier identified.
3. **`AI·待核` is not evidence** — model priors and model-only re-derivations. Exit: find and check a traceable source for the claim, recording its supported scope, or remove the proposed claim with a reason. Deferral is allowed while a gap and next checking step remain visible; it is not verification. Never use pending claims in a tendency statement or silently erase unresolved source conflicts.  
4. **Conflicts stay visible.**  
5. **Verifiable operations** need reproducible inputs and steps (counts, list↔row checks, cross-refs). Source categories and operations are not a strength ranking. “The model thought again” is not independent verification. See the track prompt for its labels.

## Range slicing

In-range absence → “may continue on another page,” **not** “missing.” Later pages can overturn earlier stats via a fixed 【勘误】 block.

## Forms

| Form | Main chain |
|------|------------|
| Mechanism | mechanism chain |
| Lists / differentials | discrimination chain |
| Procedures | step chain |

No fake causality. List-like material: two-way reconciliation.

## Counter-arms

Open an arm on a **reversal point**: in-material conflict, reconciliation mismatch, or wording fork. Also explain supported alternative interpretations or evidence gaps that could change the human decision; model hypotheses remain model-added, not established counterevidence. Otherwise one line: what was checked. Wording forks without E1 go to the upgrade list.

## Errata

Fixed block: original claim · cause · corrected · impact. No silent rewrites.

## Output skeleton

Status → structure → evidence ledger (with upgrade list) → counter-arms → human decision list. **No self-check tick lists.**
