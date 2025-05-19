Function Get-PhoneNumber() {
    <#
    .SYNOPSIS
    Clean up user-entered phone numbers so that they can be sent SMS messages.

    .DESCRIPTION
    Given a phone number string, check if it's a valid phone number that complied with the NANP system.
    Return the cleaned number string if it's valid, otherwise throw the relevant error.
    Also provide user the option to print out the number in pretty format.

    .PARAMETER Number
    The phone number string to be processed.

    .PARAMETER Pretty
    Provide optional flag that will print out the phone number in pretty format: (Area)-Exchange-Number
    
    .EXAMPLE
    Get-PhoneNumber -Number '+1 (223) 456-7890'
    return: '2234567890'

    Get-PhoneNumber -Number '555.888.9999' -Pretty
    return: '(555)-888-9999'
    #>
    [CmdletBinding()]
    Param(
        [string]$Number,
        [switch]$Pretty
    )

    $Number = $Number -replace "[\s().+-]", ""
    $Number = ($Number.StartsWith("1") -and $Number.Length -eq 11) ? $Number.Substring(1) : $Number
    if ($Number.Length -lt 10) { throw "Number can't be fewer than 10 digits" }
    if ($Number.Length -eq 11) { throw "11 digits must start with 1" }
    if ($Number.Length -gt 11) { throw "Number can't be more than 11 digits" }
    if ($Number -match "[a-z]") { throw "Letters not permitted" }
    if ($Number -match "\D") { throw "Punctuations not permitted" }
    if ($Number[0] -in @("0", "1")) { throw "Area code can't start with $($Number[0])" }
    if ($Number[3] -in @("0", "1")) { throw "Exchange code can't start with $($Number[3])" }

    $Pretty ? ($Number -replace "(\d{3})(\d{3})(\d{4})", '($1)-$2-$3') : $Number
}
