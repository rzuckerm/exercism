Function Invoke-Diamond() {
    <#
    .SYNOPSIS
    Given a letter, output a diamond shape.

    .DESCRIPTION
    Take a letter of the alphabet, return a string in a diamond shape starting with 'A', with the supplied letter at the widest point.
    The output should use only capitalized letters, however the input should be case-insensitive.

    .PARAMETER Letter
    The letter used to decide the shape of the diamond.

    .EXAMPLE
    Invoke-Diamond -Letter D
    Return:
    @"
       A   
      B B  
     C   C 
    D     D
     C   C 
      B B  
       A   
    "@ 
    #>
    [CmdletBinding()]
    Param(
        [char]$Letter
    )

    $ULetter = [char](([string]$Letter).ToUpper())
    if ($ULetter -eq "A") { return "A`n" }
    ("A"..$ULetter + [char]($ULetter - 1).."A" | ForEach-Object { $X = $_;
        -join ($ULetter.."A" + "B"..$ULetter | ForEach-Object { $_ -eq $X ? $_ : " " }) }) -join "`r`n"
}
