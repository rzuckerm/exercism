Function Invoke-EncodeVLQ() {
    <#
    .SYNOPSIS
    Implement variable length quantity encoding

    .DESCRIPTION
    Given an array of integer values, encoding them using variable-length quantity technique to save spaces.

    .PARAMETER Bytes
    Array of data to be encoded.

    .EXAMPLE
    Invoke-EncodeVLQ -Bytes @(0x40)
    Returns: @(0x40)
    #>
    [CmdletBinding()]
    Param(
        [UInt32[]]$Bytes
    )

    $Bytes | ForEach-Object {
        $output = @(for (($b = $_), ($msb = 0x00); $b; ($msb = 0x80), ($b = $b -shr 7)) { ($b -band 0x7f) -bor $msb })
        $output ? $output[$output.Length..0] : @(0)
    }
}

Function Invoke-DecodeVLQ() {
    <#
    .SYNOPSIS
    Implement variable length quantity decoding.

    .DESCRIPTION
    Given an array of encoded integer values, decoding them to get the original values.

    .PARAMETER Bytes
    Array of data to be decoded.

    .EXAMPLE
    Invoke-DecodeVLQ -Bytes @(0x7F)
    Returns: @(0x7F)
    #>
    [CmdletBinding()]
    Param(
        [UInt32[]]$Bytes
    )

    if ($Bytes -and $Bytes[-1] -band 0x80) { throw "Incomplete sequence" }

    $output = @()
    $value = 0
    foreach ($b in $Bytes) {
        $value = ($value -shl 7) -bor ($b -band 0x7f)
        if (-not ($b -band 0x80)) {
            $output += $value
            $value = 0
        }
    }

    $output
}
