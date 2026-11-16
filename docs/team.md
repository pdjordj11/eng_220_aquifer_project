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

My primary contribution to our project was researching and evaluating groundwater resources in Cuba, New Mexico, and the surrounding region especially Sandoval County. I collected data and technical publications from reliable and trustworthy sources including the USGS, New Mexico bureau of Geology, and Office of the State Engineer to investigate groundwater levels, well characteristics, aquifer geology, and water-resource sustainability. I analyzed the relevance and limitations of each source in relation to our research questions and prepared seven research briefs summarizing their findings and potential applications. Additionally, I developed a guide to help my teammates organize, clean, and visualize the collected data. My work helped establish a technical foundation for the project, identify gaps in available information, and guide the team's analysis toward evidence-based conclusions.

### James Wauneka

At the start of our project, my team pulled together eight raw CSV datasets that needed a lot of work before anyone could actually use them. I handled the data prep side of things and used MATLAB to clean, standardize, and transform all eight raw files into reliable, analysis-ready datasets. Getting that done meant everyone on the team was working from the exact same numbers we knew we could trust. Those cleaned files ended up supporting the rest of our project—helping us answer our six core research questions, feeding clean data into our web app, and giving us consistent results to use in our final report and project documentation.

### Micah Watkins

I worked on the analysis and visualizations. I used Claude, an AI coding tool from Anthropic, to write the code and the first drafts of the analysis write-ups, and I decided what to build and checked the results. To keep the quality up, I had a second AI grade every chart against a rubric based on our proposal and Dylan's plotting guide. After four rounds of fixes, the score went from 72 to 86 out of 100, and I decided when it was good enough and which version to keep. Everything is in the `analysis/` folder. It loads every dataset into the team's shared format, calculates the water-level trends (Sen's slope and the Mann-Kendall test), and makes 15 charts for our six research questions. Each chart comes with its takeaway, caption, scope, and labeled findings, so the app, the report, and this site always show the same numbers. Petar suggested pictograms, so I asked for pictogram versions of six charts, as long as they stayed scientific and didn't look cartoonish, and kept the plain versions for the report. When the team narrowed our research questions, I cut three charts that no longer fit. I tested the app on my own computer and merged everything with a pull request so the team could review it. More details, including how the charts were reviewed, are on the [Analysis and visualizations](analysis.md) page.

### Meckrem Yousef

I worked on developing and deploying the Streamlit app. A major focus was updating themes throughout the interface and refining how the graphs looked. I also worked on making the application mobile-accessible so that it could be easily read on phones, as well as gathering a few datasets to share with my team. Using built-in functions and config.toml, I adjusted specific aspects of the app to optimize it for mobile use and ensure the color scheme was more expressive of the project. Finally, I created the water estimator section of the app to give users an approximation of their total weekly water usage.

### Petar Djordjevic

As Prime Minister, I coordinated the team, its schedule, and its deliverables, and I submit the team's slides and video on Canvas. I manage the team's GitHub workflow, keeping the repository organized and publishing each update; I built and maintain this documentation site and the repository's README files; and I narrowed the proposal's nine research questions to the six that the collected data can answer. I wrote the final report in LaTeX, bringing together Dylan's dataset briefs, James's cleaned data, and Micah's figures with background research on Cuba's water system and a peace-engineering perspective. I also built the presentation slides and edit the team video. Details are on the [Final report](report.md) and [Presentation and video](presentation.md) pages.
