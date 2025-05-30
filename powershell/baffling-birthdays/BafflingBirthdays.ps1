Function Invoke-BafflingBirthdays {
    <#
    .SYNOPSIS
    Estimate the birthday paradox's probabilities.

    .DESCRIPTION
    To solve the birthday paradox exercise you need to do these steps:
    - Generate random birthdates.
    - Check if a collection of randomly generated birthdates contains at least two with the same birthday.
    - Estimate the probability that at least two people in a group share the same birthday for different group sizes.

    .PARAMETER People
    Number of people in the group.
    #>
    [CmdletBinding()]
    Param(
        [int]$People
    )

    $count = 0
    $runs = 5000
    for ($i = 0; $i -lt $runs; $i++) { $count += Test-SharedBirthday (Get-RandomBirthdates $People) }
    return 100.0 * $count / $runs
}

Function Get-RandomBirthdates {
    <#
    .SYNOPSIS
    Generate a collection of birthdates based on a number of people.

    .PARAMETER People
    Number of birthdates to be generated.
    #>
    [CmdletBinding()]
    Param(
        [int]$People
    )

    do { $year = Get-Random -Minimum 1925 -Maximum 2026 } while ([DateTime]::IsLeapYear($year))
    Get-Random -Minimum 0 -Maximum 365 -Count $People | ForEach-Object { [DateTime]::new($year, 1, 1).AddDays($_) }
}

Function Test-SharedBirthday {
    <#
    .SYNOPSIS
    Check if there is a shared birthday in a list of random birthdates.

    .PARAMETER Birthdates
    A collection of random Datetime objects represents.
    #>
    [CmdletBinding()]
    Param(
        [DateTime[]]$Birthdates
    )

    for ($i = 0; $i -lt $Birthdates.Length - 1; $i++) {
        for ($j = $i + 1; $j -lt $Birthdates.Length; $j++) {
            if ($Birthdates[$i].Month -eq $Birthdates[$j].Month -and $Birthdates[$i].Day -eq $Birthdates[$j].Day) {
                return $true
            }
        }
    }

    $false
}
