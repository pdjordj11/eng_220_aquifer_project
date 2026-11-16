# Team

ENG 220 · Team 23 · Instructor: Ramiro Jordan

| Member | Role |
|---|---|
| Petar Djordjevic (Prime Minister) | GitHub workflow, documentation, final report, presentation, and video |
| Dylan Gonzales | Data acquisition and dataset justification |
| James Wauneka | Data cleaning and preprocessing |
| Micah Watkins | Analysis code and visualizations |
| Meckrem Yousef | Streamlit app design and development |


## Contributions

Each member describes their own contributions here.

### Dylan Gonzales

*To be written.*

### James Wauneka

At the start of our project, my team pulled together eight raw CSV datasets that needed a lot of work before anyone could actually use them. I handled the data prep side of things and used MATLAB to clean, standardize, and transform all eight raw files into reliable, analysis-ready datasets. Getting that done meant everyone on the team was working from the exact same numbers we knew we could trust. Those cleaned files ended up supporting the rest of our project—helping us answer our six core research questions, feeding clean data into our web app, and giving us consistent results to use in our final report and project documentation.

### Micah Watkins

I wrote the analysis code and made the project's charts. All of it lives in the `analysis/` folder: loaders that bring every dataset into the team's shared column format (including the minimum preparation needed for the datasets that aren't cleaned yet), trend statistics (Sen's slope and the Mann-Kendall test), and one function per chart that returns the figure together with its takeaway, caption, scope, and labeled findings. The same functions feed the Streamlit pages, the report figures, and the documentation, so every number matches. I made 15 charts and figures covering all six research questions, wired them into the app's pages, and wrote a grading rubric from our proposal and Dylan's plotting guide to review and improve the charts. For six of them I also made pictograph versions (well cross-sections, a map of well pictograms sized by transmissivity, river-visit drops, rating balls, and unit charts), following Petar's suggestion, while keeping the plain versions for the report. Details are on the [Analysis and visualizations](analysis.md) page.

### Meckrem Yousef

I worked on developing and deploying the Streamlit app. A major focus was updating themes throughout the interface and refining how the graphs looked. I also worked on making the application mobile-accessible so that it could be easily read on phones, as well as gathering a few datasets to share with my team. Using built-in functions and config.toml, I adjusted specific aspects of the app to optimize it for mobile use and ensure the color scheme was more expressive of the project. Finally, I created the water estimator section of the app to give users an approximation of their total weekly water usage.

### Petar Djordjevic

As Prime Minister, I coordinated the team, its schedule, and its deliverables, and I submit the team's slides and video on Canvas. I manage the team's GitHub workflow, keeping the repository organized and publishing each update; I built and maintain this documentation site and the repository's README files; and I narrowed the proposal's nine research questions to the six that the collected data can answer. I wrote the final report in LaTeX, bringing together Dylan's dataset briefs, James's cleaned data, and Micah's figures with background research on Cuba's water system and a peace-engineering perspective. I also built the presentation slides and edit the team video. Details are on the [Final report](report.md) and [Presentation and video](presentation.md) pages.
