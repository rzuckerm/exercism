Function Invoke-SwiftScheduling() {
    <#
    .SYNOPSIS
    Find the actual dates for deliveries.

    .DESCRIPTION
    Convert delivery date descriptions to actual delivery dates, based on when the meeting started.

    .PARAMETER MeetingStart
    A datetime object for delivery date.

    .PARAMETER Description
    A string describes the nature of the delivery date.

    .EXAMPLE
    #>
    [CmdletBinding()]
    Param(
        [datetime]$MeetingStart,
        [string]$Description
    )

    switch -Regex ($Description) {
        "NOW" { $MeetingStart.AddHours(2) }
        "ASAP" { ($MeetingStart.Hour -lt 13) ? $MeetingStart.Date.AddHours(17) : $MeetingStart.Date.AddDays(1).AddHours(13) }
        "EOW" {
            ($MeetingStart.DayOfWeek -le "Wednesday") ?
                $MeetingStart.Date.AddDays("Friday" - $MeetingStart.DayOfWeek).AddHours(17) :
                $MeetingStart.Date.AddDays(("Sunday" - $MeetingStart.DayOfWeek + 7) % 7).AddHours(20)
        }
        "([1-9]|1[0-2])M" {
            $yearAdd = ($MeetingStart.Month -lt [int]$Matches[1]) ? 0 : 1
            $first = [datetime]::new($MeetingStart.Year + $yearAdd, [int]$Matches[1], 1, 8, 0, 0)
            $first.AddDays(($first.DayOfWeek -in "Saturday", "Sunday") ? ("Monday" - $first.DayOfWeek + 7) % 7 : 0)
        }
        "Q([1-4])" {
            $month = 3 * [int]$Matches[1]
            $yearAdd = ($MeetingStart.Month -le $month) ? 0 : 1
            $last = [datetime]::new($MeetingStart.Year + $yearAdd, $month, 1, 8, 0, 0).AddMonths(1).AddDays(-1)
            $last.AddDays(($last.DayOfWeek -in "Saturday", "Sunday") ? -(($last.DayOfWeek - "Friday" + 7) % 7) : 0)
        }
    }
}
