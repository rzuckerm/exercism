<#
.SYNOPSIS
    Refactor a ledger printer.

.DESCRIPTION
    The code below is an attempt of creating a printer for a ledger.
    It barely works (only passed some of the tests), and is generally quite messy.
    Your job here is to refactor the code.

.EXAMPLE
    $entry1 = CreateEntry -Date '2011-12-13' -Desc 'Birthday present' -Amount 1234
    $entry2 = CreateEntry -Date '2011-11-19' -Desc 'Party prep & catering services' -Amount 98765
    FormatEntries -Currency "EUR" -Locale "en-US" -Entries @($entry1, $entry2)

    Returns:
    @"
    Date       | Description               | Change
    11/19/2011 | Party prep & catering ... |      €987.65
    12/13/2011 | Birthday present          |       €12.34
    "@
#>

$Global:LocaleTable = @{
    "en-US" = @{header = "Date", "Description", "Change"; date = "MM\/dd\/yyyy";
        change = { param($s, $m, $change) ($change -ge 0) ? "$s$m " : "(${s}$($m.Substring(1)))" }}
    "nl-NL" = @{header = "Datum", "Omschrijving", "Verandering"; date = "dd-MM-yyyy";
        change = { param($s, $m, $change) "$s $($m.Replace('.', '@').Replace(',', '.').Replace('@', ',')) " }}
}
$Global:CurrencyTable = @{"USD" = "$"; "EUR" = "€" }

Class LedgerEntry {
    [string]$Date
    [string]$Desc
    [double]$Change

    LedgerEntry([string]$date, [string]$desc, [double]$change) {
        $this.Date = $date
        $this.Desc = $desc
        $this.Change = $change
    }

    [string] Format([string]$Currency, [string]$Locale) {
        $dateStr = ([datetime]$this.Date).ToString($Global:LocaleTable[$Locale].date)
        $money = ($this.Change / 100).ToString("N2")
        $symbol = $Global:CurrencyTable[$Currency]
        $c = & $Global:LocaleTable[$Locale].change $symbol $money $this.Change
        $d = ($this.Desc.Length -le 25) ? $this.Desc : (-join $this.Desc[0..21]) + "..."
        return "{0,-10} | {1,-25} | {2,13}" -f $dateStr, $d, $c
    }
}

Function CreateEntry {
    <#
    .DESCRIPTION
    A function to create an entry for the ledger.
    This function is required for the test suite.

    .PARAMETER Date
    String represent the date.

    .PARAMETER Desc
    String represent the description of the entry.

    .PARAMETER Amount
    Integer represent the amount of money in cents.
    #>
    param (
        [string] $Date,
        [string] $Desc,
        [int] $Amount
    )

    [LedgerEntry]::new($Date, $Desc, $Amount)
}

Function FormatEntries {
    <#
    .DESCRIPTION
    A function to formats the entries of the ledger based on other info.
    This function is required for the test suite.

    .PARAMETER Currency
    String represent the currency symbol.

    .PARAMETER Locale
    String represent the region and culture to be followed.

    .PARAMETER Entries
    Array of entries, each is an instance of the class LedgerEntry, created via CreateEntry function.
    #>
    param (
        [string]$Currency,
        [string]$Locale,
        [LedgerEntry[]]$Entries
    )
    (@("{0,-10} | {1,-25} | {2,-13}" -f $Global:LocaleTable[$Locale].header) +
        @($Entries | Sort-Object Date, Desc, Change | ForEach-Object { $_.Format($Currency, $Locale) })) -join "`n"
}

Function MakeEntry {
    <#
    .DESCRIPTION
    An optional helper function that create and format each entry.
    #>
    param (
        [string] $Currency,
        [string] $Locale,
        [LedgerEntry] $Entry
    )

    $dateStr = ([datetime]$Entry.Date).ToString($Global:LocaleTable[$Locale].date)
    $money = ($entry.Change / 100).ToString("N2")
    $symbol = $Global:CurrencyTable[$Currency]
    if ($Locale -eq "en-US") { $change = ($Entry.Change -ge 0) ? "$symbol$money " : "(${symbol}$($money -replace '-', ''))" }
    elseif ($Locale -eq "nl-NL") { $change = "$symbol $($money -replace '\.', '@' -replace ',', '.' -replace '@', ',') " }

    # Truncated too long desc
    $desc = ($Entry.Desc.Length -le 25) ? $Entry.Desc : (-join $Entry.Desc[0..21]) + "..."

    # Format the text into correct space
    "{0,-10} | {1,-25} | {2,13}" -f $dateStr, $desc, $change
}
