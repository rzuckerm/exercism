$Global:Functions = @{
    "plus" = { Param([int]$Lhs, [int]$Rhs) $Lhs + $Rhs };
    "minus" = { Param([int]$Lhs, [int]$Rhs) $Lhs - $Rhs };
    "multiplied" = { Param([int]$Lhs, [int]$Rhs) $Lhs * $Rhs };
    "divided" = { Param([int]$Lhs, [int]$Rhs) [Math]::Floor($Lhs / $Rhs) }
}

Function Get-Answer() {
    <#
    .SYNOPSIS
    Parse and evaluate simple math word problems.
    
    .DESCRIPTION
    Implement a function that take in a string represent a math word problem and return the answer in integer.
    Throw error if the question doesn't make sense or doesn't related to math problem.

    .PARAMETER Question
    The string represent the math problem.

    .EXAMPLE
    Get-Answer -Question "What is 1 plus 1?"
    Returns: 2
    #>
    [CmdletBinding()]
    Param(
        [string]$Question
    )

    $Words = $Question.TrimStart("What is").TrimEnd("?") -replace "by", "" -split " " -ne ""
    $ValidKeywords = ($Global:Functions.Keys -join "|") + "|\-?\d+"
    if (($Words | Where-Object { $_ -notmatch $ValidKeywords }).Length) { throw "Unknown operation" }
    try {
        $Answer = [int]::Parse($Words[0])
        for ($X = 1; $X -lt $Words.Length; $X += 2) {
            $Answer = & $Global:Functions[$Words[$X]] $Answer ([int]::Parse($Words[$X + 1]))
        }
    } catch { throw "Syntax error" }

    $Answer
}
