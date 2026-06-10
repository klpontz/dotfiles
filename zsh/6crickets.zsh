# Run shell script for new programs and session created in past 7 days.
alias new-programs-export='bash $HOME/Projects/6crickets/coding/scripts/new-programs-sessions/export.sh'

# Run yearly platform metrics for any district.
alias run-metrics='/Users/pontz/Projects/6crickets/coding/SQL/yearly-metrics/run-metrics.sh'

# Computes unique present student counts per site by weekday date for a given month.
# Usage: site-daily-attendance [YYYY-MM] [district]
site-daily-attendance() {
  local input="$HOME/Projects/6crickets/coding/scripts/unique-att-month-sites/input.csv"
  local month="${1:-}"
  local district="${2:-}"
  local out="$HOME/Projects/6crickets/coding/scripts/unique-att-month-sites/outputs"

  [[ -z "$month" ]]    && read "month?Month (YYYY-MM): "
  [[ -z "$district" ]] && read "district?District name: "

  python3 "$HOME/Projects/6crickets/coding/scripts/unique-att-month-sites/site_daily_attendance.py" \
    --input "$input" \
    --month "$month" \
    --district "$district" \
    --out "$out"
}

# Transforms a Fresno roster CSV into per-school XLSX workbooks for a given month.
# Usage: fresno-rosters [month_number] [year]
fresno-rosters() {
  local month="${1:-}"
  local year="${2:-}"

  [[ -z "$month" ]] && read "month?Month (1-12): "
  [[ -z "$year" ]]  && read "year?Year (YYYY): "

  local month_name
  month_name=$(date -j -f "%m" "$(printf '%02d' "$month")" "+%B" 2>/dev/null || date -d "$(printf '%04d-%02d-01' "$year" "$month")" "+%B")

  local base="$HOME/Projects/6crickets/coding/scripts/fresno-rosters"

  source ~/roster-env/bin/activate
  python3 "$base/transform_roster.py" \
    --input "$base/input.csv" \
    --outdir "$base/FresnoRosters - $month_name $year" \
    --month "$month" \
    --year "$year"
  deactivate
}
