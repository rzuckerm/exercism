Function Invoke-CryptoSquare() {
    <#
    .SYNOPSIS
    Implement the classic method for composing secret messages called a square code.

    .DESCRIPTION
    Given an English text, output the encoded version of that text.
    First, the input is normalized: the spaces and punctuation are removed from the English text and the message is down-cased.
    Then, the normalized characters are broken into rows.
    These rows can be regarded as forming a rectangle when printed with intervening newlines.

    .PARAMETER PlainText
    The string to be encoded.

    .EXAMPLE
    Invoke-CryptoSquare -PlainText "Exercism"
    Return: "ers xcm ei "
    #>
    [CmdletBinding()]
    Param(
        [string]$PlainText
    )

    $cleanText = $PlainText.ToLower() -replace '[^a-z\d]', ""
    $q = [Math]::Sqrt($cleanText.Length)
    $r, $c = [Math]::Round($q), [Math]::Ceiling($q)
    @(for ($i = 0; $i -lt $c; $i++) {
        -join @(for ($j = 0; $j -lt $r; $j++) { $cleanText[$j * $c + $i] ?? " " })}
    ) -join " "
}
