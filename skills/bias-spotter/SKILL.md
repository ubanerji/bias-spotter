---
name: bias-spotter
description: Analyze a piece of text for signs of cognitive biases (confirmation bias, sunk cost, anchoring, survivorship bias, hindsight bias, overconfidence, framing, and so on) and report them with quoted evidence, a confidence level, and a question that would test each one. Use this skill whenever the user shares writing (an essay, memo, email, article, post, decision write-up, pitch, journal entry, argument, or transcript) and asks whether it is biased, one-sided, well-reasoned, or what blind spots or flawed thinking it shows, or asks to "check my reasoning", "poke holes in this", "what am I missing", or "is this manipulative". Use it even when the user does not say the words "cognitive bias". Not for statistical or ML model bias, or for media political-lean ratings.
---

# Bias Spotter

Read a piece of text and report where its reasoning shows signs of common cognitive biases, in a way that helps the reader think better rather than feel accused.

## What this can and cannot do

A cognitive bias is a property of how someone reasoned. Text is only the residue of that reasoning. So this skill finds *signs consistent with* a bias, never proof of one. Two consequences shape everything below:

- **Evidence comes first.** Every finding hangs on an exact quote. If there is no passage to point at, there is no finding.
- **Restraint is the product.** A detector that flags everything teaches people to ignore it. Any text can be made to look biased by a motivated reader, which would itself be confirmation bias. A short report with three solid findings is worth more than a long one with twelve guesses. "No strong signs" is a legitimate and useful result.

## Process

### 1. Understand the text before judging it

Work out what kind of text it is, what it is trying to do, and who wrote it for whom. This sets the bar:

- A persuasive op-ed or ad is one-sided by design. One-sidedness alone is not a finding there; look for where the reasoning actually breaks.
- A decision memo, forecast, post-mortem, or analysis claims to weigh things fairly. Missing counter-evidence matters much more.
- A personal note or journal entry is someone thinking aloud. Be gentle and concrete.
- Fiction, satire, and quoted speech: the bias may belong to a character or a quoted person, not the author. Say whose it is.

If the user wrote the text themselves, address them as a thinking partner. If someone else wrote it, describe the text, not the person's character.

### 2. Sort what you see into three buckets

Keeping these apart is the main thing that makes a report trustworthy:

1. **The author's own reasoning** shows signs of a bias (the author seems to have fallen into it). Example: defending continued investment by pointing to money already spent.
2. **The text is built to trigger a bias in the reader** (a persuasion device). Example: "Only 3 seats left" leans on scarcity. The author is not biased here; they are using the reader's biases. Report these separately and label them as such.
3. **Not a cognitive bias at all.** Logical fallacies (ad hominem, straw man), factual errors, and plain disagreement with a conclusion are different things. Mention a fallacy only if it matters, and call it a fallacy. Never flag a view as biased because it is contestable or because you would have concluded otherwise.

### 3. Scan with the catalog

Read `references/bias-catalog.md`. It lists the biases to look for, the textual signals for each, and the innocent explanations that commonly get mistaken for them. Use it as a checklist of lenses, not a quota. Biases outside the catalog are fine to report if the evidence is clear; name them accurately.

### 4. Try to knock down each candidate

For every candidate finding, argue the other side before keeping it:

- Is there a reasonable reading where this passage is fine? (The author may have addressed the counter-evidence elsewhere, or the claim may simply be true.)
- Would the finding survive if the author's conclusion were one you agreed with?
- Does the text's genre excuse it?

Then rate it:

- **Strong**: the pattern is explicit in the wording and hard to read another way.
- **Moderate**: the pattern fits well, but a reasonable innocent reading exists.
- **Weak**: suggestive only. Drop these, unless several weak signs point the same way, in which case report them as one finding and say so.

When two labels fit the same passage, pick the more specific one and mention the other in a clause. Do not report the same quote twice under two names.

### 5. Write the report

Use this structure. Keep it proportionate: a three-sentence text gets a few lines, not a full report.

```markdown
## Bias check: [short description of the text]

**Overall:** [2-3 sentences. How sound is the reasoning overall, what is the most important issue, and how sure are you. Say plainly if there is little to flag.]

### Signs in the author's reasoning

**1. [Bias name]** · [Strong | Moderate]
> "[exact quote from the text]"

**Why it reads this way:** [1-3 sentences tying the wording to the bias, in plain language. Define the bias in a clause if it is not a household term.]
**Innocent reading:** [the best alternative explanation; omit only when rated Strong and none is plausible]
**Test it:** [one concrete question or check that would show whether the bias is really at work]

[...more findings, strongest first...]

### Persuasion devices aimed at the reader
[Same format, only if there are any. Omit the section otherwise.]

### What the text does well
[1-3 specific things: counter-evidence it considers, uncertainty it admits, base rates it cites. Omit if there is nothing real to say; do not invent praise.]

### Caveats
[One or two lines: what you could not judge from the text alone, e.g. facts you cannot verify or context you lack.]
```

Notes on the format:

- **Quotes must be exact.** Copy them from the text; trim with "..." if long. A paraphrase presented as a quote destroys trust in the whole report.
- **A bias of omission** (something that should be there and is not) has no quote. Quote the passage where the gap shows and say what is missing.
- **"Test it" is the most useful line.** It turns a label into something the reader can do. "What result would have changed your mind?" beats "Consider other perspectives."
- If there are no findings in a section, omit the section. If there are none at all, say so in **Overall**, explain briefly what you checked for, and keep **What the text does well**.
- Order by importance to the text's conclusion, not by how famous the bias is.

## Tone

People get defensive about bias, and a defensive reader learns nothing. Write as a sharp colleague would: specific, calm, never smug. Say "this passage reads as" rather than "the author is". Everyone reasons this way sometimes; that is why the biases have names.

Stay out of the object-level argument. The job is to assess how the conclusion was reached, not whether it is right. A biased process can land on a true conclusion, and it is worth saying so when relevant.

## Variations

- **User asks about one specific bias**: check for that one thoroughly, then add a single line on anything else major.
- **User asks for a fix**: after the report, offer a revised passage that keeps the author's point but repairs the reasoning.
- **Very long text**: report the findings that most affect the main conclusion (roughly the top five to seven) and say that you prioritized.
- **Text in a conversation or transcript**: attribute each finding to the speaker.
