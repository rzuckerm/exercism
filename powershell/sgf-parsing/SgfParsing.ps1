<#
.SYNOPSIS
Parsing a Smart Game Format string.

.DESCRIPTION
The exercise will have you parse an SGF string and return a tree structure of properties.

.EXAMPLE
Invoke-Parser -Data "(;E[xercism])"

Returns:
[SgfTree]::new(
    @{
        "E" = @("exercism")
    },
    @()
)
#>

Class SgfTree {
    <#
    .DESCRIPTION
    The SGF Tree class represent each node in the tree structure
    The Equals method is required to compare trees in test suite.
    #>
    [hashtable] $Properties = @{}
    [SgfTree[]]  $Children = @()

    SgfTree() {}

    SgfTree([hashtable]$properties, [SgfTree[]]$children) {
        $this.Properties = $properties
        $this.Children   = $children
    }

    [bool] Equals([object]$other) {
        return -not (Compare-Object $this.Properties.Keys $other.Properties.Keys) -and
            -not ($this.Properties.GetEnumerator() | Where-Object { Compare-Object $_.Value $other.Properties[$_.Key] }) -and
            -not (Compare-Object $this.Children $other.Children)
    }
}

function Invoke-Parser {
    param (
        [string]$Data
    )

    (Invoke-ParseNode $Data.Replace("\\\n", "") 0 "(" ")")[1]
}

function Invoke-ParseNode([string]$Data, [int]$Idx, [string]$StartDelim = "", [string]$EndDelim = "") {
    if ($StartDelim -and $Data[0] -ne $StartDelim) { throw "Tree missing" }

    $Idx += [int]($StartDelim -ne "")
    if ($Data[$Idx] -ne ";") { throw "Tree with no nodes" }

    $properties, $children = @{}, @()
    $Idx++
    while ($Idx -lt $Data.Length -and (-not $EndDelim -or $Data[$Idx] -ne $EndDelim)) {
        $keyIdx = $Data.IndexOf("[", $Idx)
        $key = ($keyIdx -ge 0) ? (-join $Data[$Idx..($keyIdx - 1)]) : ""
        if ($keyIdx -lt 0 -or $key -match '[;()\]]') { throw "Properties without delimiter" }
        if (-not $key) { throw "Property is empty" }
        if ($key -cmatch '[^A-Z]') { throw "Property must be in uppercase" }

        $Idx, $values = Invoke-ParseValues $Data $keyIdx
        $properties[$key] += $values

        if ($Data[$Idx] -eq ";") {
            $Idx, $child = Invoke-ParseNode $Data $Idx -EndDelim ")"
            $Idx--
            $children += $child
        }
        elseif ($Data[$Idx] -eq "(") {
            $children = @()
            while ($Idx -lt $Data.Length) {
                if ($Data[$Idx] -ne "(") { break }
                $Idx, $child = Invoke-ParseNode $Data $Idx "(" ")"
                $children += $child
            }

            $Idx--
        }
    }

    if ($EndDelim -and ($Idx -ge $Data.Length -or $Data[-1] -ne $EndDelim)) { throw "Tree missing" }

    $Idx += [int]($EndDelim -ne "")
    @($Idx, [SgfTree]::new($properties, $children))
}

function Invoke-ParseValues([string]$Data, [int]$Idx) {
    $values = @()
    while ($Idx -lt $Data.Length -and $Data[$Idx] -eq "[") {
        $Idx++
        $value = ""
        while ($Idx -lt $Data.Length -and $Data[$Idx] -ne "]") {
            if (-join $Data[$Idx..($Idx + 1)] -eq "\\") { $Idx += 2 }
            if (($nextTwoChars = -join $Data[$Idx..($Idx + 1)]) -in @("\t", "\\")) {
                $Idx += 2
                $value += ($nextTwoChars -eq "\t" ) ? " " : "\\"
            } else { $value += $Data[$Idx++] }
        }

        if ($Data[$Idx] -ne "]") { throw "Property value not terminated" }
        $Idx++
        $values += $value
    }

    @($Idx, $values)
}
