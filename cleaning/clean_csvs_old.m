% James Wauneka
% ENG 220
% CSV cleaner

function clean_csvs(kind, inFile)
% Cleans raw CSVs into the shared schema and saves them to data/clean/.
% Run from the repo root (the folder that contains "data").
%
%   clean_csvs                                  % clean both, default input files
%   clean_csvs('groundwater')                   % only groundwater, default input
%   clean_csvs('aquifer')                       % only aquifer tests, default input
%   clean_csvs('groundwater', 'data/other.csv') % groundwater cleaning on a specific file
%   clean_csvs('aquifer', 'C:\path\to\file.csv')

    if nargin < 1, kind = 'all'; end
    kind = lower(char(kind));

    cleanDir = fullfile('data', 'clean');
    if ~exist(cleanDir, 'dir'), mkdir(cleanDir); end

    gwDefault = fullfile('data', 'water_flow_data_sandoval_county_sources.csv');
    aqDefault = fullfile('data', 'ose_aquifer_test_wells.csv');

    switch kind
        case 'all'
            clean_groundwater(gwDefault, fullfile(cleanDir, 'groundwater_levels_monthly.csv'));
            clean_aquifer_tests(aqDefault, fullfile(cleanDir, 'aquifer_tests.csv'));
        case 'groundwater'
            if nargin < 2, inFile = gwDefault; end
            clean_groundwater(inFile, fullfile(cleanDir, 'groundwater_levels_monthly.csv'));
        case 'aquifer'
            if nargin < 2, inFile = aqDefault; end
            clean_aquifer_tests(inFile, fullfile(cleanDir, 'aquifer_tests.csv'));
        otherwise
            error('Unknown kind "%s". Use ''groundwater'', ''aquifer'', or no argument.', kind);
    end
end

%% ======================================================================
%% Groundwater levels (USGS)
%% ======================================================================
function clean_groundwater(inFile, outFile)
    fprintf('--- Groundwater levels ---\n');
    T = read_all_text(inFile);

    need = {'parameter_code','interval_type','parent_statistic_name', ...
            'monitoring_location_id','monitoring_location_name','y','x', ...
            'start_date','arithmetic_mean'};
    require_cols(T, need, inFile);

    keep = strtrim(T.parameter_code) == "72019" & ...
           lower(strtrim(T.interval_type)) == "month" & ...
           lower(strtrim(T.parent_statistic_name)) == "mean";
    T = T(keep, :);
    fprintf('Rows after filtering (expected 2673): %d\n', height(T));

    C = table();
    C.site_id        = clean_text(T.monitoring_location_id);   % A/B suffix wells stay separate
    C.site_name      = clean_text(T.monitoring_location_name);
    C.latitude       = to_num(T.y);
    C.longitude      = to_num(T.x);
    C.date           = to_date(T.start_date);
    C.source         = repmat("USGS", height(T), 1);
    C.depth_to_water_ft = to_num(T.arithmetic_mean);

    % duplicate check (site + date)
    key = C.site_id + "|" + string(C.date, 'yyyy-MM-dd');
    fprintf('Duplicate site/date rows: %d\n', numel(key) - numel(unique(key)));
    fprintf('Wells: %d\n', numel(unique(C.site_id)));

    write_clean(C, outFile);
end

%% ======================================================================
%% Aquifer tests (NM OSE)
%% ======================================================================
function clean_aquifer_tests(inFile, outFile)
    fprintf('--- Aquifer tests ---\n');

    % ---- CONFIG: output column -> candidate raw headers (normalized names).
    % If the script says a column is missing, add the right header here.
    % (Normalized = lowercase, non-alphanumerics become underscores.)
    map = {
      'site_id',            {'ose_pod_id'}
      'site_name',          {'alt_well_name'}
      'latitude',           {'latitude'}
      'longitude',          {'longitude'}
      'date',               {'test_date_start'}
      'formation',          {'formation_name'}
      'well_depth_ft',      {'well_depth_ft'}
      'screen_top_ft',      {'depth_to_top_of_screen_ft'}
      'screen_bottom_ft',   {'depth_to_bottom_of_screen_ft'}
      'depth_to_water_ft',  {'start_water_level_ft'}
      'pumping_rate_gpm',   {'pumping_rate_gpm'}
      'transmissivity_drawdown_ft2_per_day', {'transmissivity_drawdown_ft2pday'}
      'transmissivity_recovery_ft2_per_day', {'transmissivity_recovery_ft2pday'}
      'storativity',        {'storativity'}
      'specific_capacity_gpm_per_ft', {'specific_capacity_gpm_p_ft'}
      'hydraulic_conductivity_ft_per_day', {'horizontal_hydraulic_conductivity_ftpd'}
    };
    countyCol = {'county_name'};
    waterDateCandidates = {'start_water_level_date'};

    T = read_all_text(inFile);
    avail = T.Properties.VariableNames;

    % County filter
    cc = find_col(avail, countyCol, 'county');
    T = T(upper(strtrim(T.(cc))) == "SANDOVAL", :);
    fprintf('Sandoval rows (expected 179): %d\n', height(T));

    C = table();
    for i = 1:size(map, 1)
        out = map{i,1};
        src = find_col(avail, map{i,2}, out);
        v = T.(src);
        switch out
            case {'site_id','site_name'}
                C.(out) = clean_text(v);
            case 'date'
                C.(out) = to_date(v);
            case 'formation'
                C.(out) = clean_formation(v);
            otherwise
                C.(out) = to_num(v);
        end
    end

    % The test date and unknown-date handling (1/1/1900 means unknown)
    wd = find_col_optional(avail, waterDateCandidates);
    if ~isempty(wd)
        d = to_date(T.(wd));
        fprintf('START WATER LEVEL DATE unknown (1900) rows: %d (left blank, column not exported)\n', sum(isnat(d)));
    end

    % Insert source after date, so shared columns come first
    C.source = repmat("NM OSE", height(C), 1);
    shared = {'site_id','site_name','latitude','longitude','date','source'};
    rest   = setdiff(C.Properties.VariableNames, shared, 'stable');
    C = C(:, [shared, rest]);

    % Note ambiguous Jan 1 dates
    isJan1 = ~isnat(C.date) & month(C.date) == 1 & day(C.date) == 1;
    fprintf('Tests dated January 1 (may be year-only): %d  -> kept\n', sum(isJan1));

    % Drop columns that are empty or identical in every row (never the shared ones)
    for k = 1:numel(rest)
        col = C.(rest{k});
        allBlank = all(ismissing(col));
        identical = ~any(ismissing(col)) && numel(unique(col)) <= 1;
        if allBlank || identical
            fprintf('Dropping empty/constant column: %s\n', rest{k});
            C.(rest{k}) = [];
        end
    end

    if ismember('formation', C.Properties.VariableNames)
        fprintf('Unique formations after cleaning (review for leftover typos):\n');
        disp(unique(C.formation(~ismissing(C.formation))));
    end

    write_clean(C, outFile);
end

%% ======================================================================
%% Helpers
%% ======================================================================
function T = read_all_text(file)
    if ~exist(file, 'file')
        found = dir(fullfile(fileparts(file), '*.csv'));
        if isempty(found)
            seen = '(no CSV files found in that folder)';
        else
            seen = strjoin({found.name}, ', ');
        end
        error(['Input file "%s" not found.\nMATLAB''s current folder is: %s\n' ...
               'CSVs in "%s": %s\nEither change the current folder to your repo root, ' ...
               'or pass the full path: clean_csvs(''groundwater'', ''C:\\full\\path\\file.csv'')'], ...
               file, pwd, fileparts(file), seen);
    end
    opts = detectImportOptions(file, 'Encoding', 'UTF-8');
    opts.VariableNamingRule = 'preserve';
    opts = setvartype(opts, opts.VariableNames, 'string');   % read everything as text, convert ourselves
    T = readtable(file, opts);
    T.Properties.VariableNames = cellfun(@normalize_name, ...
        T.Properties.VariableNames, 'UniformOutput', false);
end

function n = normalize_name(s)
    s = regexprep(char(s), '[^\x20-\x7E]', '');   % drops BOM debris from the first header
    s = lower(s);
    s = regexprep(s, '[^a-z0-9]+', '_');
    n = regexprep(s, '^_+|_+$', '');
end

function require_cols(T, need, file)
    miss = setdiff(need, T.Properties.VariableNames);
    if ~isempty(miss)
        error('Missing columns in %s: %s\nFound: %s', file, strjoin(miss, ', '), ...
              strjoin(T.Properties.VariableNames, ', '));
    end
end

function c = find_col(avail, candidates, label)
    c = find_col_optional(avail, candidates);
    if isempty(c)
        error(['Could not find a raw column for "%s". Tried: %s\n' ...
               'Available columns: %s\nAdd the right name to the CONFIG block.'], ...
               label, strjoin(candidates, ', '), strjoin(avail, ', '));
    end
end

function c = find_col_optional(avail, candidates)
    c = '';
    for i = 1:numel(candidates)
        hit = find(strcmp(avail, candidates{i}), 1);
        if ~isempty(hit), c = avail{hit}; return; end
    end
end

function s = clean_text(v)
    s = regexprep(strtrim(string(v)), '\s+', ' ');
    s(s == "" | ismember(upper(s), ["NA","N/A","NULL","MISSING","NAN"])) = missing;
end

function s = clean_formation(v)
    s = upper(clean_text(v));
    % Known fixes: add more as you spot them in the printed unique list
    fixes = {
        'SAANDSTONE', 'SANDSTONE'
    };
    for i = 1:size(fixes, 1)
        s = replace(s, fixes{i,1}, fixes{i,2});
    end
    s = regexprep(s, '\s+', ' ');
    s = strtrim(s);
end

function x = to_num(v)
    % Text -> number. Blanks/placeholders -> NaN. Ranges ("11 to 21") -> midpoint.
    v = strtrim(string(v));
    x = nan(size(v));
    for i = 1:numel(v)
        s = v(i);
        if ismissing(s) || s == "", continue; end
        if ismember(upper(s), ["NA","N/A","NULL","MISSING","NAN","-999","-9999"]), continue; end
        s = erase(s, ",");
        % range: "11 to 21" or "11 - 21" (a leading minus is not a range)
        tok = regexp(char(s), '^\s*(-?[\d\.]+)\s*(?:[Tt][Oo]|-)\s*(-?[\d\.]+)\s*$', 'tokens', 'once');
        if ~isempty(tok)
            x(i) = mean([str2double(tok{1}), str2double(tok{2})]);
            fprintf('  Range "%s" -> midpoint %g\n', s, x(i));
        else
            x(i) = str2double(regexprep(char(s), '[^\d\.\-eE+]', ''));
        end
    end
end

function d = to_date(v)
    % Handles "11/12/2002 12:00:00 AM", "11/12/2002", and "2002-11-12" (optionally with a time).
    v = strtrim(string(v));
    d = NaT(size(v));
    for i = 1:numel(v)
        if ismissing(v(i)) || v(i) == "", continue; end
        s = char(v(i));
        t = regexp(s, '^(\d{1,2})/(\d{1,2})/(\d{4})', 'tokens', 'once');
        if ~isempty(t)
            d(i) = datetime(str2double(t{3}), str2double(t{1}), str2double(t{2}));
            continue
        end
        t = regexp(s, '^(\d{4})-(\d{2})-(\d{2})', 'tokens', 'once');
        if ~isempty(t)
            d(i) = datetime(str2double(t{1}), str2double(t{2}), str2double(t{3}));
        end
    end
    d.Format = 'yyyy-MM-dd';
    d(year(d) == 1900) = NaT;            % 1/1/1900 = unknown
end

function write_clean(C, outFile)
    C = sortrows(C, {'site_id','date'});

    % Convert everything to text ourselves so blanks are truly blank
    % (never 0, NaN, or NaT) and dates are YYYY-MM-DD.
    W = table();
    for k = 1:width(C)
        name = C.Properties.VariableNames{k};
        col = C.(name);
        if isdatetime(col)
            s = string(col, 'yyyy-MM-dd');
            s(isnat(col)) = "";
        elseif isnumeric(col)
            s = compose("%.10g", col);
            s(isnan(col)) = "";
        else
            s = string(col);
            s(ismissing(s)) = "";
        end
        W.(name) = s;
    end

    % Write the CSV ourselves (UTF-8, quote only fields with commas/quotes/newlines)
    M = table2array(W);
    needs = contains(M, [",", """", newline, char(13)]);
    M(needs) = """" + replace(M(needs), """", """""") + """";
    lines = join(M, ",", 2);

    fid = fopen(outFile, 'w', 'n', 'UTF-8');
    if fid < 0, error('Could not open "%s" for writing (is it open in Excel?).', outFile); end
    closer = onCleanup(@() fclose(fid));
    fprintf(fid, '%s\n', strjoin(W.Properties.VariableNames, ','));
    for i = 1:numel(lines)
        fprintf(fid, '%s\n', lines(i));
    end
    clear closer
    fprintf('Saved %d rows x %d columns -> %s\n\n', height(W), width(W), outFile);
end
