# 2. Data cleaning

**Lead:** James Wanueka

This stage turns the raw downloads into tables the analysis code can use directly.

## Starting notes

What the raw files already need:

- `ose_aquifer_test_wells.csv` covers all of New Mexico. Filtering `COUNTY NAME` to `SANDOVAL` keeps 179 of its 3,455 records.
- `water_flow_data_sandoval_county_sources.csv` mixes ten measurement types, each in its own units (cubic feet per second, feet, mg/L, and so on). Split it by `parameter_code` before comparing values.
- The same file mixes monthly, calendar-year, and water-year periods (`interval_type`) and several statistics per period (`parent_statistic_name`: mean, minimum, maximum, median). Pick one combination per chart so values aren't double counted.

## Cleaning steps

*To be written: each step, in order, and the script that does it.*

## Cleaned outputs

*To be written: the cleaned files this stage produces and where they're saved.*

## Problems and decisions

*To be written: missing values, odd records, and how they were handled.*
