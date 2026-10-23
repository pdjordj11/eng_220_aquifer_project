# Beneath the Mesa

**Assessing Aquifer, Well, and Acequia Water Resources Across Sandoval County, New Mexico**

ENG 220 · Team 23

[Open the live app](https://eng220aquiferproject.streamlit.app/) · [View the code on GitHub](https://github.com/pdjordj11/eng_220_aquifer_project)

## About the project

Water scarcity is a persistent challenge across New Mexico. Sandoval County spans several hydrogeologic settings, and its communities depend on a mix of groundwater wells, surface water, and acequia irrigation systems.

This project evaluates the condition and long-term viability of those water resources across the county, with Cuba, New Mexico, on the eastern edge of the San Juan Basin, as a focused case study. The project is motivated by concern about declining groundwater near Cuba, but rather than assume how severe that decline is or what is causing it, we test what the available public data actually show.

## Approach

The study works at two levels:

- **County-wide screening.** Map and compare aquifers, wells, water levels, water quality, and acequia and surface-water features across Sandoval County. Because the county crosses several geologic regions, comparisons are grouped by region or aquifer system instead of treating the county as one uniform aquifer.
- **Cuba case study.** A closer look at the Ojo Alamo Sandstone and San Jose Formation near Cuba, using San Juan Basin aquifer datasets alongside nearby well, water-level, and water-quality records.

The analysis focuses on measurable indicators such as depth to water, water-level change over time, well depth, aquifer unit, and salinity, rather than a full hydrologic model. Where records are sparse, the results say so instead of filling the gaps.

## Research questions

1. How do groundwater levels vary across Sandoval County, and which areas show sustained decline, stability, or recovery?
2. What do well records show about well depth, depth to water, and the aquifer units that communities rely on?
3. Do the available data support the concern that Cuba's main groundwater source is approaching severe depletion?
4. How do the Ojo Alamo Sandstone and San Jose Formation compare near Cuba in extent, thickness, hydraulic properties, water levels, and water quality?
5. How does groundwater quality, including salinity, vary across the county and near Cuba?
6. Where are acequias located, what surface water do they depend on, and which communities do they serve?
7. Do changes in groundwater levels line up with nearby surface-water or acequia conditions, or are the records too limited to tell?
8. Where is monitoring coverage strong, and where are the most important data gaps?
9. Which indicators can be combined into a dashboard that shows water-resource stress without overstating how certain the data are?

## Data

Datasets currently in the repository's `data/` folder:

| File | Contents |
|---|---|
| `water_flow_data_sandoval_county_sources.csv` | USGS monthly and yearly statistics for 30 monitoring sites in Sandoval County (17 stream gages, 9 wells, 2 canals, and 2 reservoirs), covering streamflow, groundwater levels, suspended sediment, water temperature, and reservoir storage, with records from 1926 to 2026. |
| `ose_aquifer_test_wells.csv` | New Mexico Office of the State Engineer aquifer-test records, 3,455 statewide and 179 in Sandoval County, including well depth, screened interval, geologic formation, and hydraulic properties such as transmissivity and storativity. |

Other sources the project draws on:

- [USGS San Juan Basin digital aquifer data (ScienceBase)](https://www.sciencebase.gov/catalog/item/5d8e350be4b0c4f70d0cc484)
- [USGS groundwater-flow model report, WRI 95-4187](https://pubs.usgs.gov/publication/wri954187)
- [NM Bureau of Geology: San Juan Basin Brackish Water Assessment](https://geoinfo.nmt.edu/resources/water/projects/bwa/sjb/home.html)
- [New Mexico Office of the State Engineer](https://www.ose.nm.gov/)
- [National Ground-Water Monitoring Network](https://www.usgs.gov/apps/ngwmn/index.jsp)
- [Healy Collaborative Groundwater Monitoring Network](https://geoinfo.nmt.edu/resources/water/cgmn/home.cfml)
- [New Mexico Water Data Catalog](https://catalog.newmexicowaterdata.org/)
- [NM Interstate Stream Commission: Acequias](https://www.ose.nm.gov/Acequias/isc_acequias.php)

## Deliverables

- An interactive Streamlit dashboard (linked above)
- This GitHub repository, with reproducible code and documentation
- A final written report
- A seven-minute team presentation video

## Team

| Member | Role |
|---|---|
| Dylan | Data acquisition and dataset justification |
| James | Data cleaning and preprocessing |
| Micah | Analysis code and visualizations |
| Meckrem | GitHub workflow and the Streamlit app |
| Petar | Documentation, final report, presentation, and video |

Instructor: Ramiro Jordan
