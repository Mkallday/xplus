Attribute VB_Name = "xpDateTime"
'@Module: This module contains a set of functions for working with dates and times.

Option Explicit


Public Function WEEKDAY_NAME( _
    Optional ByVal dayNumber As Byte _
) As String

    '@Description: This function takes a weekday number and returns the name of the day of the week.
    '@Author: Anthony Mancini
    '@Version: 1.0.0
    '@License: MIT
    '@Param: dayNumber is a number that should be between 1 and 7, with 1 being Sunday and 7 being Saturday. If no dayNumber is given, the value will default to the current day of the week.
    '@Returns: Returns the day of the week as a string
    '@Example: =WEEKDAY_NAME(4) -> Wednesday
    '@Example: To get today's weekday name: =WEEKDAY_NAME()

    If dayNumber = 0 Then
        WEEKDAY_NAME = WeekdayName(Weekday(Now()))
    Else
        WEEKDAY_NAME = WeekdayName(dayNumber)
    End If

End Function


Public Function MONTH_NAME( _
    Optional ByVal monthNumber As Byte _
) As String

    '@Description: This function takes a month number and returns the name of the month.
    '@Author: Anthony Mancini
    '@Version: 1.0.0
    '@License: MIT
    '@Param: monthNumber is a number that should be between 1 and 12, with 1 being January and 12 being December. If no monthNumber is given, the value will default to the current month.
    '@Returns: Returns the month name as a string
    '@Example: =MONTH_NAME(1) -> "January"
    '@Example: =MONTH_NAME(3) -> "March"
    '@Example: To get today's month name: =MONTH_NAME()

    If monthNumber = 0 Then
        MONTH_NAME = MonthName(Month(Now()))
    Else
        MONTH_NAME = MonthName(monthNumber)
    End If

End Function


Public Function QUARTER( _
    Optional ByVal monthNumberOrName As Variant _
) As Byte
    
    '@Description: This function takes a month as a number and returns the quarter of the year the month resides.
    '@Author: Anthony Mancini
    '@Version: 1.0.0
    '@License: MIT
    '@Todo: Look further into DatePart function and see if its a better choice for generating the quarter of the year. Also look into adding the month name as well as an option for this function
    '@Param: monthNumberOrName is a number that should be between 1 and 12, with 1 being January and 12 being December, or the name of a Month, such as "January" or "March".
    '@Returns: Returns the quarter of the month as a number
    '@Example: =QUARTER(4) -> 2
    '@Example: =QUARTER("April") -> 2
    '@Example: =QUARTER(12) -> 4
    '@Example: =QUARTER("December") -> 4
    '@Example: To get today's quarter: =QUARTER()
    
    If IsMissing(monthNumberOrName) Then
       monthNumberOrName = MonthName(Month(Now()))
    End If
    
    If IsNumeric(monthNumberOrName) Then
        monthNumberOrName = MonthName(monthNumberOrName)
    End If
    
    
    If monthNumberOrName = MonthName(1) Or monthNumberOrName = MonthName(2) Or monthNumberOrName = MonthName(3) Then
        QUARTER = 1
    End If
    
    If monthNumberOrName = MonthName(4) Or monthNumberOrName = MonthName(5) Or monthNumberOrName = MonthName(6) Then
        QUARTER = 2
    End If
    
    If monthNumberOrName = MonthName(7) Or monthNumberOrName = MonthName(8) Or monthNumberOrName = MonthName(9) Then
        QUARTER = 3
    End If
    
    If monthNumberOrName = MonthName(10) Or monthNumberOrName = MonthName(11) Or monthNumberOrName = MonthName(12) Then
        QUARTER = 4
    End If

End Function


Public Function TIME_CONVERTER( _
    ByVal date1 As Date, _
    Optional ByVal secondsInteger As Integer, _
    Optional ByVal minutesInteger As Integer, _
    Optional ByVal hoursInteger As Integer, _
    Optional ByVal daysInteger As Integer, _
    Optional ByVal monthsInteger As Integer, _
    Optional ByVal yearsInteger As Integer) _
As Date
    
    '@Description: This function takes a date, and then a series of optional arguments for a number of seconds, minutes, hours, days, and years, and then converts the date given to a new date adding in the other date argument values.
    '@Author: Anthony Mancini
    '@Version: 1.0.0
    '@License: MIT
    '@Param: date1 is the original date that will be converted into a new date
    '@Param: secondsInteger is the number of seconds that will be added
    '@Param: minutesInteger is the number of minutes that will be added
    '@Param: hoursInteger is the number of hours that will be added
    '@Param: daysInteger is the number of days that will be added
    '@Param: monthsInteger is the number of months that will be added
    '@Param: yearsInteger is the number of years that will be added
    '@Returns: Returns a new date with all the date arguments added to it
    '@Note: You can skip earlier date arguments in the function by putting a 0 in place. For example, if we only wanted to change the month, which is the 5th argument, we can do =TIME_CONVERTER(A1,0,0,0,2) which will add 2 months to the date chosen
    '@Example: =TIME_CONVERTER(A1,60) -> 1/1/2000 1:01; Where A1 contains the date 1/1/2000 1:00
    '@Example: =TIME_CONVERTER(A1,0,5) -> 1/1/2000 1:05; Where A1 contains the date 1/1/2000 1:00
    '@Example: =TIME_CONVERTER(A1,0,0,2) -> 1/1/2000 3:00; Where A1 contains the date 1/1/2000 1:00
    '@Example: =TIME_CONVERTER(A1,0,0,0,4) -> 1/5/2000 1:00; Where A1 contains the date 1/1/2000 1:00
    '@Example: =TIME_CONVERTER(A1,0,0,0,0,1) -> 2/1/2000 1:00; Where A1 contains the date 1/1/2000 1:00
    '@Example: =TIME_CONVERTER(A1,0,0,0,0,0,5) -> 1/1/2005 1:00; Where A1 contains the date 1/1/2000 1:00
    '@Example: =TIME_CONVERTER(A1,60,5,3,10,5,15) -> 6/11/2015 4:06; Where A1 contains the date 1/1/2000 1:00
    
    secondsInteger = Second(date1) + secondsInteger
    minutesInteger = Minute(date1) + minutesInteger
    hoursInteger = Hour(date1) + hoursInteger
    daysInteger = Day(date1) + daysInteger
    monthsInteger = Month(date1) + monthsInteger
    yearsInteger = Year(date1) + yearsInteger
    
    TIME_CONVERTER = DateSerial(yearsInteger, monthsInteger, daysInteger) + TimeSerial(hoursInteger, minutesInteger, secondsInteger)

End Function


Public Function DAYS_OF_MONTH( _
    Optional ByVal monthNumberOrName As Variant, _
    Optional ByVal yearNumber As Integer) _
As Variant

    '@Description: This function takes a month number or month name and returns the number of days in the month. Optionally, a year number can be specified. If no year number is provided, the current year will be used. Finally, note that the month name or number argument is optional and if omitted will use the current month.
    '@Author: Anthony Mancini
    '@Version: 1.0.0
    '@License: MIT
    '@Param: monthNumberOrName is a number that should be between 1 and 12, with 1 being January and 12 being December, or the name of a Month, such as "January" or "March". If omitted the current month will be used.
    '@Param: yearNumber is the year that will be used. If omitted, the current year will be used.
    '@Returns: Returns the number of days in the month and year specified
    '@Example: =DAYS_OF_MONTH() -> 31; Where the current month is January
    '@Example: =DAYS_OF_MONTH(1) -> 31
    '@Example: =DAYS_OF_MONTH("January") -> 31
    '@Example: =DAYS_OF_MONTH(2, 2019) -> 28
    '@Example: =DAYS_OF_MONTH(2, 2020) -> 29

    If IsMissing(monthNumberOrName) Then
        monthNumberOrName = Month(Now())
    End If

    If yearNumber = 0 Then
        yearNumber = Year(Now())
    End If

    If monthNumberOrName = 1 Or monthNumberOrName = MonthName(1) Then
        DAYS_OF_MONTH = 31
    ElseIf monthNumberOrName = 2 Or monthNumberOrName = MonthName(2) Then
        If yearNumber Mod 4 <> 0 Then
            DAYS_OF_MONTH = 28
        Else
            DAYS_OF_MONTH = 29
        End If
    ElseIf monthNumberOrName = 3 Or monthNumberOrName = MonthName(3) Then
        DAYS_OF_MONTH = 31
    ElseIf monthNumberOrName = 4 Or monthNumberOrName = MonthName(4) Then
        DAYS_OF_MONTH = 30
    ElseIf monthNumberOrName = 5 Or monthNumberOrName = MonthName(5) Then
        DAYS_OF_MONTH = 31
    ElseIf monthNumberOrName = 6 Or monthNumberOrName = MonthName(6) Then
        DAYS_OF_MONTH = 30
    ElseIf monthNumberOrName = 7 Or monthNumberOrName = MonthName(7) Then
        DAYS_OF_MONTH = 31
    ElseIf monthNumberOrName = 8 Or monthNumberOrName = MonthName(8) Then
        DAYS_OF_MONTH = 31
    ElseIf monthNumberOrName = 9 Or monthNumberOrName = MonthName(9) Then
        DAYS_OF_MONTH = 30
    ElseIf monthNumberOrName = 10 Or monthNumberOrName = MonthName(10) Then
        DAYS_OF_MONTH = 31
    ElseIf monthNumberOrName = 11 Or monthNumberOrName = MonthName(11) Then
        DAYS_OF_MONTH = 30
    ElseIf monthNumberOrName = 12 Or monthNumberOrName = MonthName(12) Then
        DAYS_OF_MONTH = 31
    Else
        DAYS_OF_MONTH = "#NotAValidMonthNumberOrName"
    End If

End Function


Public Function WEEK_OF_MONTH( _
    Optional ByVal date1 As Date) _
As Byte

    '@Description: This function takes a date and returns the number of the week of the month for that date. If no date is given, the current date is used.
    '@Author: Anthony Mancini
    '@Version: 1.0.0
    '@License: MIT
    '@Param: date1 is a date whose week number will be found
    '@Returns: Returns the number of week in the month
    '@Example: =WEEK_OF_MONTH() -> 5; Where the current date is 1/29/2020
    '@Example: =WEEK_OF_MONTH(1/29/2020) -> 5
    '@Example: =WEEK_OF_MONTH(1/28/2020) -> 5
    '@Example: =WEEK_OF_MONTH(1/27/2020) -> 5
    '@Example: =WEEK_OF_MONTH(1/26/2020) -> 5
    '@Example: =WEEK_OF_MONTH(1/25/2020) -> 4
    '@Example: =WEEK_OF_MONTH(1/24/2020) -> 4
    '@Example: =WEEK_OF_MONTH(1/1/2020) -> 1
    

    Dim weekNumber As Byte
    Dim currentDay As Byte
    Dim currentWeekday As Byte
    
    weekNumber = 1
    
    ' When year is 1899, no year was given as an input
    If Year(date1) = 1899 Then
        currentDay = Day(Now())
        currentWeekday = Weekday(Now())
    Else
        currentDay = Day(date1)
        currentWeekday = Weekday(date1)
    End If
    
    While currentDay <> 0
        If currentWeekday = 0 Then
            weekNumber = weekNumber + 1
            currentWeekday = 7
        End If
        
        currentDay = currentDay - 1
        currentWeekday = currentWeekday - 1
    Wend
    
    WEEK_OF_MONTH = weekNumber

End Function
