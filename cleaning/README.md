# Cleaning scripts

Scripts that read raw files from `data/`, clean them, and write the results to `data/clean/`. Python (`.py`) or MATLAB (`.m`) both work.

| Script | Reads | Writes |
|---|---|---|
| `clean_csvs.m` | `data/water_flow_data_sandoval_county_sources.csv` | `data/clean/groundwater_levels_monthly.csv` |
| `clean_csvs.m` | `data/ose_aquifer_test_wells.csv` | `data/clean/aquifer_tests.csv` |

To run it, set MATLAB's current folder to the repository root (the folder that contains `data/`), then run one of these:

    clean_csvs                  % make both cleaned files
    clean_csvs('groundwater')   % groundwater levels only
    clean_csvs('aquifer')       % aquifer tests only

Never edit the raw files in `data/`. What each script does, and the naming and format rules for cleaned files, are on the [Data cleaning page](https://pdjordj11.github.io/eng_220_aquifer_project/data-cleaning/).
