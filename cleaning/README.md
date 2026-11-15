# Cleaning scripts

Scripts that read raw files from `data/`, clean them, and write the results to `data/clean/`. Python (`.py`) or MATLAB (`.m`) both work.

`clean_csvs.m` makes all six cleaned files. Until Nov 15 it was named `clean_csvs_Revised_2.m`. James's first version, which makes only the first two the same way, is kept as `clean_csvs_old.m` for reference.

| Reads (in `data/`) | Writes (in `data/clean/`) |
|---|---|
| `water_flow_data_sandoval_county_sources.csv` | `groundwater_levels_monthly.csv` |
| `ose_aquifer_test_wells.csv` | `aquifer_tests.csv` |
| `data2_groundwater_sandoval_county.csv` | `groundwater_levels_nmbgmr.csv` |
| `data4_channel-measurements.csv`, `data4_field-measurements.csv`, `data4_monitoring-location-metadata.csv` | `streamflow_measurements.csv` |
| `data7_Wells With Well Log Information.csv` | `well_logs.csv` |
| `data3_Aquifer_Sensitivity.csv` | `aquifer_sensitivity.csv` |

To run it, set MATLAB's current folder to the repository root (the folder that contains `data/`), then run one of these:

    clean_csvs                            % make every cleaned file whose raw file is present
    clean_csvs('groundwater')             % USGS groundwater levels only
    clean_csvs('aquifer')                 % aquifer tests only
    clean_csvs('nmbgmr')                  % NM Bureau of Geology groundwater levels only
    clean_csvs('streamflow')              % Rio Puerco at Cuba only
    clean_csvs('welllogs')                % well logs only
    clean_csvs('sensitivity')             % aquifer sensitivity only

Never edit the raw files in `data/`. What the script does to each file, the problems it found, and the naming and format rules for cleaned files are on the [Data cleaning page](https://pdjordj11.github.io/eng_220_aquifer_project/data-cleaning/). James's report on the cleaning is `project_notes/Sandoval_County_Water_Data_Report.pdf`.
