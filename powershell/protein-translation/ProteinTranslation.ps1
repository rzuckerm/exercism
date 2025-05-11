Function Invoke-ProteinTranslation() {
    <#
    .SYNOPSIS
    Translate RNA sequences into proteins.

    .DESCRIPTION
    Take an RNA sequence and convert it into condons and then into the name of the proteins in the form of a list.

    .PARAMETER Strand
    The RNA sequence to translate.

    .EXAMPLE
    Invoke-ProteinTranslation -Strand "AUG"
    #>
    [CmdletBinding()]
    Param(
        [string]$Strand
    )

    switch -regex ($Strand -split "(.{0,3})" -ne "") {
        "AUG" { "Methionine" }
        "UU[UC]" { "Phenylalanine" }
        "UU[AG]" { "Leucine" }
        "UC[UCAG]" { "Serine" }
        "UA[UC]" { "Tyrosine" }
        "UG[UC]" { "Cysteine" }
        "UGG" { "Tryptophan" }
        "UA[AG]|UGA" { break }
        default { throw "error: Invalid codon" }
    }
}
