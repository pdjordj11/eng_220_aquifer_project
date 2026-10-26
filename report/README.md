# Project report

LaTeX source for the project report, styled to match the project proposal (two columns, Palatino, navy headings).

| File | Contents |
|---|---|
| `report.tex` | The report |
| `references.bib` | Bibliography (BibTeX) |
| `figures/` | Figures used in the report |

The report is currently a rough-draft template. Orange notes in brackets mark text still to be written, and dashed boxes mark figures still to be made.

## Editing and building

**Overleaf (easiest):** zip this `report` folder, then in Overleaf choose **New Project → Upload Project**. When you're done, download the source (**Menu → Download → Source**) and replace the files here.

**On your own computer** with a TeX distribution installed:

```
latexmk -pdf report.tex
```

## Adding a figure

Save the figure in `figures/` (PDF or PNG), then in `report.tex` replace the figure's `\figplaceholder[...]{...}` line with:

```latex
\includegraphics[width=\linewidth]{your-figure-name}
```

Then write its caption in the `\caption{...}` line below it.

## Switches

At the top of `report.tex`:

- `\draftnotesfalse` hides the orange notes.
- `\roughdraftfalse` removes the red ROUGH DRAFT stamp and sets the date to the final due date.
- `\coverpagetrue` adds a cover page matching the proposal's.

## Publishing the PDF

The documentation site links to `docs/files/project_report_draft.pdf`. After rebuilding, copy the new PDF there, commit, push, and run `mkdocs gh-deploy`.
