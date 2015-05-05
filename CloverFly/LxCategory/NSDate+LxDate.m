//
//  NSDate+LxDate.m
/*
 //     ___ __   ____  _   _________
 //   / __// /  / __ \| | / / __/ _ \
 //  / /  / /_ / /_/ /| |/ / _// , _/
 // /___//____/\____/_\___/___/_/|_|
 // --------Created by clover--------
 */


#import "NSDate+LxDate.h"

@implementation NSDate (LxDate)

#define kCalendar [NSCalendar currentCalendar]

#define kDateComponents (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)


#pragma mark -
#pragma mark Comparing dates

- (BOOL) isEarlierDate: (NSDate *) aDate
{
	return ([[self earlierDate:aDate] isEqualToDate:self]);
}

- (BOOL) isLaterDate: (NSDate *) aDate
{
	return ([[self laterDate:aDate] isEqualToDate:self]);
}

- (BOOL) dateBetweenStartDate:(NSDate*)start andEndDate:(NSDate*)end {
    
    BOOL isEarlier = [self isLaterDate:start];
    BOOL isLater = [self isEarlierDate:end];
    
    if (isLater && isEarlier) {
        return YES;
    } else
        return NO;
}

#pragma mark -
#pragma mark Date formatting

- (NSString*)localeFormattedDateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *ret = [formatter stringFromDate:self];
    
    return ret;
}

- (NSString*)localeFormattedDateStringWithTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy HH:mm"];
    [formatter setLocale:[NSLocale currentLocale]];
    //   [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString *ret = [formatter stringFromDate:self];
    return ret;
}

+ (NSDate *)localeFormatted {
    
    return [[NSDate date] dateFormattedLocale];
}

- (NSDate *)dateFormattedLocale {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *ret = [formatter stringFromDate:self];
    
    return [formatter dateFromString:ret];
}


- (NSString *)formattedStringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *ret = [formatter stringFromDate:self];
    
    return ret;
}

- (NSDate *)dateWithoutTime
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *ret = [formatter stringFromDate:self];
    
    return [formatter dateFromString:ret];
}

+ (NSDate *)dateWithoutTime
{
    return [[NSDate date] dateWithoutTime];
}


#pragma mark -
#pragma mark SQLite formatting

- (NSDate *) dateForSqlite {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *ret = [formatter stringFromDate:self];
    
    NSDate *date = [formatter dateFromString:ret];
    
    return date;
}

+ (NSDate*) dateFromSQLString:(NSString*)dateStr
{
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    [dateForm setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date = [dateForm dateFromString:dateStr];
    return date;
}

+ (NSDate*) dateFromFormatString:(NSString*)dateStr formatStr:(NSString*)formatStr
{
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    [dateForm setDateFormat:formatStr];
    NSDate *date = [dateForm dateFromString:dateStr];
    return date;
}

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorian];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setTimeZone:systemTimeZone];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    
    
    return [dateComps date];
}

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day{
    return [NSDate dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}
#pragma mark -
#pragma mark Beginning and end of date components

- (NSDate *) startOfDay
{
    
    
	NSDateComponents *components = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                fromDate:self];    [components setHour: 0];
    [components setMinute: 0];
    [components setSecond: 0];
    
    return [kCalendar dateFromComponents:components];
}

- (NSDate *) endOfDay
{
    NSDateComponents *components = [kCalendar components: NSUIntegerMax fromDate: self];
    [components setHour: 23];
    [components setMinute: 59];
    [components setSecond: 59];
    
    return [kCalendar dateFromComponents:components];
}


- (NSDate *)beginningOfWeek {
    
    NSDate *beginningOfWeek = nil;
	BOOL ok = [kCalendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
                            interval:NULL forDate:self];
	if (ok) {
		return beginningOfWeek;
	}
    
	// couldn't calc via range, so try to grab Sunday, assuming gregorian style
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [kCalendar components:NSWeekdayCalendarUnit fromDate:self];
    
	/*
	 Create a date components to represent the number of days to subtract from the current date.
	 The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.) */
    
	NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] + 1)];
	beginningOfWeek = nil;
	beginningOfWeek = [kCalendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
	//normalize to midnight, extract the year, month, and day components and create a new date from those components.
	NSDateComponents *components = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                fromDate:beginningOfWeek];
	return [kCalendar dateFromComponents:components];
    
}

- (NSDate *)beginningOfMonth {
    
    NSDateComponents *comps = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comps setDay:1];
    
    return [kCalendar dateFromComponents:comps];
    
}

- (NSDate *)beginningOfYear {
    
    NSDateComponents *comps = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [comps setDay:1];
    [comps setMonth:1];
    
    return [kCalendar dateFromComponents:comps];
    
}

- (NSDate *)endOfWeek {
	NSDateComponents *weekdayComponents = [kCalendar components:NSWeekdayCalendarUnit fromDate:self];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
	[componentsToAdd setDay:(8 - [weekdayComponents weekday])];
	NSDate *endOfWeek = [kCalendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
	return endOfWeek;
}

- (NSDate *)endOfMonth {
    
    NSRange daysRange = [kCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    
    NSDateComponents *components = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    [components setDay:daysRange.length];
    
    return [kCalendar dateFromComponents:components];
}

- (NSDate *)endOfYear {
    
    NSUInteger days = 0;
    NSDateComponents *components = [kCalendar components:NSYearCalendarUnit fromDate:self];
    NSUInteger months = [kCalendar rangeOfUnit:NSMonthCalendarUnit
                                        inUnit:NSYearCalendarUnit
                                       forDate:self].length;
    for (int i = 1; i <= months; i++) {
        components.month = i;
        NSDate *month = [kCalendar dateFromComponents:components];
        days += [kCalendar rangeOfUnit:NSDayCalendarUnit
                                inUnit:NSMonthCalendarUnit
                               forDate:month].length;
    }
    
    NSDateComponents *comps = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];;
    
    [comps setMonth:12];
    
    return [[kCalendar dateFromComponents:comps] endOfMonth];
}

#pragma mark -
#pragma mark Date math

- (NSDate *) dateByAddingDays:(NSInteger)days
{
    NSDate *date = [self dateByAddingTimeInterval:(days * kSecondsDay)];
	return date;
}

- (NSDate *) dateBySubtractingDays:(NSInteger)days
{
    
    NSDate *date = [self dateByAddingTimeInterval:(-days * kSecondsDay)];
	return date;
}

- (NSDate *) dateByAddingHours:(NSInteger)hours
{
    NSDate *date = [self dateByAddingTimeInterval:(hours * kSecondsHour)];
	return date;
}

- (NSDate *) dateBySubtractingHours:(NSInteger)hours
{
    NSDate *date = [self dateByAddingTimeInterval:(-hours * kSecondsHour)];
    return date;
}

- (NSDate *) dateByAddingMinutes:(NSInteger)minutes
{
    NSDate *date = [self dateByAddingTimeInterval:(minutes * kSecondsMinute)];
	return date;
}

- (NSDate *) dateBySubtractingMinutes:(NSInteger)minutes
{
    NSDate *date = [self dateByAddingTimeInterval:(-minutes * kSecondsMinute)];
	return date;
}


- (NSDate*) dateByAddingMonth:(int)monthes
{
    NSDateComponents *components = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    components.month += monthes;
    
    return [kCalendar dateFromComponents:components];
}

- (NSDate*) dateBySubstractingMonth:(int)monthes
{
    NSDateComponents *components = [kCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    components.month -= monthes;
    
    return [kCalendar dateFromComponents:components];
}


#pragma mark Date components

- (NSInteger) hour
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components hour];
}

- (NSInteger) minute
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components minute];
}

- (NSInteger) seconds
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components second];
}

- (NSInteger) day
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components day];
}

- (NSInteger) month
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components month];
}

- (NSInteger) week
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components week];
}

- (NSInteger) weekday
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components weekday];
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components weekdayOrdinal];
}
- (NSInteger) year
{
	NSDateComponents *components = [kCalendar components:kDateComponents fromDate:self];
	return [components year];
}


- (NSString*) monthName {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSString *stringFromDate = [formatter stringFromDate:self];
    
    return stringFromDate;
}

- (NSString*) yearFromDateStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY"];
    [formatter setLocale:[NSLocale currentLocale]];
    
    NSString *stringFromDate = [formatter stringFromDate:self];
    
    return stringFromDate;
}

- (NSInteger)SecondsBetweenDate:(NSDate *)date
{
    return [self timeIntervalSinceDate:date];
}
- (NSInteger)MinutesBetweenDate:(NSDate *)date
{
    return [self timeIntervalSinceDate:date] / 24;
}
- (NSInteger)HoursBetweenDate:(NSDate *)date
{
    return [self timeIntervalSinceDate:date] / (60 * 24);
}
- (NSInteger)DaysBetweenDate:(NSDate *)date
{
    return [self timeIntervalSinceDate:date] / (60 * 60 * 24);
}
@end
