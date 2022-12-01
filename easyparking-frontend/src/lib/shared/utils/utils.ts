// eslint-disable-next-line @typescript-eslint/no-empty-function
export const nop = () => {};

export const generateMessageFromDate = (date: string): string => {
  const millisInSecond = 1000;
  const secondsInMinute = 60;
  const minutesInHour = 60;
  const hoursInDay = 24;

  const dateParsedMillis = Date.now() - Date.parse(date);
  const dateParsedSeconds = dateParsedMillis / millisInSecond;
  const dateParsedMinutes = dateParsedSeconds / secondsInMinute;
  const dateParsedHours = dateParsedMinutes / minutesInHour;
  const dateParsedDays = dateParsedHours / hoursInDay;

  return `Last updated ${Math.floor(
    dateParsedDays >= 1
      ? dateParsedDays
      : dateParsedHours >= 1
      ? dateParsedHours
      : dateParsedMinutes >= 1
      ? dateParsedMinutes
      : dateParsedSeconds
  )} ${
    dateParsedDays >= 1
      ? 'days'
      : dateParsedHours >= 1
      ? 'hours'
      : dateParsedMinutes >= 1
      ? 'minutes'
      : 'seconds'
  } ago`;
};
