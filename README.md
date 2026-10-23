# Beneath the Mesa
### Assessing Aquifer, Well, and Acequia Water Resources Across Sandoval County, New Mexico

**ENG 220 – Team 23**

**[Live app](https://eng220aquiferproject.streamlit.app/)** | **[Documentation site](https://pdjordj11.github.io/eng_220_aquifer_project/)**

## Team Roles

- **Dylan:** Data acquisition and dataset justification.
- **James:** Data cleaning and preprocessing.
- **Micah:** Writing analysis code and producing visualizations.
- **Meckrem:** Managing GitHub workflow and building the Streamlit application.
- **Petar:** Video editing; building the PowerPoint presentation; writing documentation and the final project report; assisting other members as needed.

## Running the App

Streamlit apps must be started with `streamlit run`. The ▶ play button and `python ProjectApp.py` won't open the app; they only print "missing ScriptRunContext" warnings.

**In GitHub Codespaces (recommended):** On the repo page, click **Code → Codespaces** and open a codespace. The app starts automatically in a preview pane. If it doesn't, run this in the terminal:

```
streamlit run ProjectApp.py
```

**On your own computer:**

```
pip install -r requirements.txt
streamlit run ProjectApp.py
```

The app opens at http://localhost:8501. Press **Ctrl+C** in the terminal to stop it.

## Updating the Live App

The live app runs whatever is on the `main` branch on GitHub. Running the app in a codespace or on your computer does **not** update it. To publish changes:

```
git pull
git add -A
git commit -m "Describe your change"
git push
```

The live app updates within about a minute.

- Always run `git pull` before you start working, to avoid merge conflicts.
- If you use a new Python package, add it to `requirements.txt` and double-check the spelling, or the live app will fail to start.

## Updating the Documentation Site

The documentation site is built with [MkDocs](https://www.mkdocs.org). Its pages are the Markdown files in `mk_documentation/docs/`, and the site settings are in `mk_documentation/mkdocs.yml`.

1. Edit or add `.md` files in `mk_documentation/docs/`.
2. Preview the site (opens at http://127.0.0.1:8000; press **Ctrl+C** to stop):
```
   pip install mkdocs
   cd mk_documentation
   mkdocs serve
```
3. Publish it to the documentation site, still inside `mk_documentation`:
```
   mkdocs gh-deploy
   cd ..
```
4. Commit and push your Markdown changes to `main` as usual, so the source stays in sync with the site.

`mkdocs gh-deploy` builds the site and pushes it to the `gh-pages` branch, which is what the documentation link serves. The built `mk_documentation/site/` folder is listed in `.gitignore`, so it is never committed to `main`.

## Project Structure

```
ProjectApp.py        Streamlit app (do not rename: the live app runs this file)
requirements.txt     Python packages the live app installs
data/                Datasets
docs/                Proposal, deadlines, and notes
mk_documentation/    MkDocs documentation site (pages in mk_documentation/docs/)
.devcontainer/       Codespaces setup
```

## Loading Data in the App

Build file paths from the app's location so they work in Codespaces, on your computer, and on the live app:

```python
from pathlib import Path
import pandas as pd

DATA = Path(__file__).parent / "data"
wells = pd.read_csv(DATA / "ose_aquifer_test_wells.csv")
```