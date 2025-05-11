Function Invoke-RotationalCipher() {
    <#
    .SYNOPSIS
    Rotate a string by a given number of places.

    .DESCRIPTION
    Create an implementation of the rotational cipher, also sometimes called the Caesar cipher.
    
    .PARAMETER Text
    The text to rotate    

    .PARAMETER Shift
    The number of places to shift the text

    .EXAMPLE
    Invoke-RotationalCipher -Text "A" -Shift 1
    #>
    [CmdletBinding()]
    Param(
        [string]$Text, 
        [int]$Shift
    )

    <#
        Initial condition:
        - A thru Z = 0x41 thru 0x5a = 0x41 + (0 thru 25)
        - a thru z = 0x61 thru 0x7a = 0x61 + (0 thru 25)

        - Subtract 1:
        - A thru Z -> 0x40 + (0 thru 25)
        - a thru z -> 0x60 + (0 thru 25)

        And with 0x1f:
        - A thru Z, a thru z -> 0 thru 25

        Add shift and modulo 26 
        - Let shifted = Shifted value from 0 thru 25

        Original value And 0xe0
        - A thru Z -> 0x40
        - a thru Z -> 0x60

        Add (original value And 0xe0):
        - A thru Z -> 0x40 + shifted
        - a thru z -> 0x60 + shifted

        Add 1:
        - A thru Z -> 0x41 + shifted
        - a thru z -> 0x61 + shifted
    #>
    -join ($Text.ToCharArray() | ForEach-Object {
        $_ -match "[a-z]" ? [char]((((([byte]$_ - 1) -band 0x1f) + $Shift) % 26) + ([byte]$_ -band 0xe0) + 1): $_
    })
}
