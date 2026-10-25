# 2. Data cleaning

**Lead:** James Wanueka

This stage turns the raw downloads into tables the analysis code can use directly. Cleaning makes the data correct and consistent; it doesn't draw conclusions. Averaging, trends, and narrowing to the Cuba area happen in the analysis stage.

## Where files go

| What | Where | Example |
|---|---|---|
| Raw downloads (never edited) | `data/` | `data/ose_aquifer_test_wells.csv` |
| Cleaning scripts | `cleaning/` | `cleaning/clean_aquifer_tests.py` |
| Cleaned files | `data/clean/` | `data/clean/aquifer_tests.csv` |

Each cleaned file has a script with a matching name that reads the raw file and writes the cleaned one, so anyone can rerun it and get the same result. Python or MATLAB both work. If a step is done by hand in Excel, write it down under [Cleaning steps](#cleaning-steps).

## Conventions for cleaned files

Every cleaned file follows the same rules, so the files can be combined and charted the same way.

**File names:** lowercase with underscores, describing what's inside, such as `groundwater_levels_monthly.csv`. No dates, versions, or "final" in names; GitHub keeps the history.

**Column names:** lowercase with underscores, with the unit at the end, such as `well_depth_ft` or `transmissivity_drawdown_ft2_per_day`.

**Shared columns:** every file starts with these, using the same names:

| Column | Contents |
|---|---|
| `site_id` | The source's ID for the well or site, as text |
| `site_name` | The well or site name |
| `latitude`, `longitude` | Decimal degrees |
| `date` | `YYYY-MM-DD` |
| `source` | Where the data came from, such as `USGS` or `NM OSE` |

**Rows:** one row per measurement, sorted by `site_id` and then `date`.

**Values:**

- Numbers only, with no units, commas, or ranges inside cells.
- Missing values left blank. Never use `0`, `N/A`, or `-9999`, which charts would plot as real values.
- Dates as `YYYY-MM-DD`.
- Text trimmed of extra spaces and spelled consistently.

**File format:** comma-separated, UTF-8, one header row, and no index column. In pandas, use `df.to_csv(path, index=False)`. From Excel, save as "CSV UTF-8".

**What to keep:** IDs, location, date, and every measurement the analysis might use. Drop columns that are empty or identical in every row.

## What each raw file needs

### Groundwater levels → `data/clean/groundwater_levels_monthly.csv`

From `data/water_flow_data_sandoval_county_sources.csv`:

- Keep groundwater-level rows only: `parameter_code` 72019.
- Keep one period and statistic: `interval_type` is `month` and `parent_statistic_name` is `Mean`. That leaves 2,673 rows for 9 wells, with no duplicates.
- Rename to the shared columns: `monitoring_location_id` → `site_id`, `monitoring_location_name` → `site_name`, `y` → `latitude`, `x` → `longitude`, `start_date` → `date`, and `arithmetic_mean` → `depth_to_water_ft`. Set `source` to `USGS`.
- Keep wells with an A or B suffix as separate sites. They're measured at different depths at the same location, so don't average them together.
- Values are depth below land surface, so a larger number means a lower water table.

The other measurements in this file (streamflow, reservoir storage, water quality) can follow the same pattern later, one file per measurement.

### Aquifer tests → `data/clean/aquifer_tests.csv`

From `data/ose_aquifer_test_wells.csv`:

- Keep Sandoval County only: `COUNTY NAME` is `SANDOVAL`, which leaves 179 rows.
- The file starts with a hidden byte-order mark, so the first column name can appear as `ï»¿ObjectID`. In pandas, read the file with `encoding="utf-8-sig"`.
- Keep one row per test. The same well (`OSE POD ID`) can appear more than once, so don't remove rows just because a well ID repeats.
- Convert dates such as `11/12/2002 12:00:00 AM` to `2002-11-12`.
- `START WATER LEVEL DATE` uses `1/1/1900` when the date is unknown. Leave those blank.
- Some numbers are stored as text, and one hydraulic conductivity value is a range (`11 to 21`). Convert everything to numbers, decide how to handle ranges, and record the decision under [Problems and decisions](#problems-and-decisions).
- Fix misspelled formation names and extra spaces, such as `POINT LOOKOUT SAANDSTONE` and `MENEFEE FORMATION  `.
- Drop empty and administrative columns. `GROUND SURFACE ELEVATION - FT AMSL` is blank for every Sandoval row, and columns such as `GlobalID`, `Entered By`, `Creator`, and `Editor` aren't needed.
- Some test dates are January 1, which may mean only the year is known. Keep them, but note it.

Suggested columns, in order: `site_id` (from `OSE POD ID`), `site_name` (`ALT WELL NAME`), `latitude`, `longitude`, `date` (test start), `source` (`NM OSE`), `formation`, `well_depth_ft`, `screen_top_ft`, `screen_bottom_ft`, `depth_to_water_ft` (start water level), `pumping_rate_gpm`, `transmissivity_drawdown_ft2_per_day`, `transmissivity_recovery_ft2_per_day`, `storativity`, `specific_capacity_gpm_per_ft`, and `hydraulic_conductivity_ft_per_day`.

## Cleaning steps

*To be written: each step, in order, and the script that does it.*

## Cleaned outputs

*To be written: each cleaned file, its row count, and the script that makes it.*

## Problems and decisions

*To be written: missing values, odd records, and how they were handled.*
