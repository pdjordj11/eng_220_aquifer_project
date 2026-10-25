# Cleaning scripts

One script per cleaned file. Each script reads a raw file from `data/`, cleans it, and writes the result to `data/clean/` under a matching name. Python (`.py`) or MATLAB (`.m`) both work.

| Script | Reads | Writes |
|---|---|---|
| `clean_groundwater_levels` | `data/water_flow_data_sandoval_county_sources.csv` | `data/clean/groundwater_levels_monthly.csv` |
| `clean_aquifer_tests` | `data/ose_aquifer_test_wells.csv` | `data/clean/aquifer_tests.csv` |

Never edit the raw files in `data/`. The naming and format rules for cleaned files are on the [Data cleaning page](https://pdjordj11.github.io/eng_220_aquifer_project/data-cleaning/).
