# Bias Spotter

A skill for Claude that reads a piece of text and reports where its reasoning shows signs of common cognitive biases.

Give it an essay, memo, email, article, pitch or journal entry and ask "is this biased?", "check my reasoning" or "what am I missing?". Each finding comes with:

- **The bias name and a confidence level** (Strong or Moderate).
- **An exact quote** from the text as evidence.
- **An innocent reading**, the best alternative explanation for the passage.
- **A "Test it" question** you can use to check whether the bias is really at work.

## Example

From a founder's memo recommending that a late software rewrite continue:

> **1. Sunk cost** · Strong
> > "We have already put 14 months and roughly $2.3M into it, and walking away now would mean all of that was for nothing."
>
> **Why it reads this way:** The $2.3M is spent whichever way the board votes, so it cannot be a reason about the future. Putting it first signals that the decision is about justifying the past.
> **Test it:** If you were handed Atlas in its current state for free today, would you fund the remaining work from scratch?

## How it thinks

- **It finds signs, not proof.** A bias is a property of how someone reasoned. Text is only the residue, so every finding is "consistent with" a bias and hangs on a quote.
- **It is built to under-flag.** Any text can be made to look biased by a motivated reader. Weak guesses are dropped, and "no strong signs" is a valid result.
- **It separates the author's reasoning from persuasion aimed at the reader.** A founder defending sunk costs and a sales email saying "only 14 spots left" are different things and are reported separately.
- **It stays out of the argument.** It assesses how a conclusion was reached, not whether the conclusion is right.

The skill carries a catalog of about 40 biases, each with the textual signals to look for and what commonly gets mistaken for it: [bias-catalog.md](skills/bias-spotter/references/bias-catalog.md).

## Install

### Claude Code

```
/plugin marketplace add ubanerji/bias-spotter
/plugin install bias-spotter@bias-spotter
```

### Claude apps (web and desktop)

Download [bias-spotter.skill](https://github.com/ubanerji/bias-spotter/raw/main/bias-spotter.skill) and upload it in Settings, in the skills section.

## Limits

- It cannot verify facts in the text, and it sees only the text you give it, not the context around it.
- It is a prompt for a language model, which has biases of its own. Treat the report as a second opinion, not a verdict.
- It has been tested on three sample texts (in [evals](skills/bias-spotter/evals)). That is a sanity check, not a validation study.

## Contributing

Issues and pull requests are welcome, especially texts where the skill over-flags or misses something obvious.

## Releasing

After changing the skill, run `scripts/release.sh` (optionally with `minor`, `major` or an exact version). It bumps the plugin version, rebuilds `bias-spotter.skill`, validates the plugin and makes a local commit. Installed plugins only pick up changes when the version number changes. Review the commit, then `git push`.

## License

MIT
