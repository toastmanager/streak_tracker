export function datesDayDiff(date1: Date, date2: Date) {
  return Math.round((date1.getTime() - date2.getTime()) / (1000 * 3600 * 24));
}
