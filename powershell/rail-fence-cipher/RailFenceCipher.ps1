Function Invoke-Encode() {
    <#
    .SYNOPSIS
    Implement encoding for the rail fence cipher.

    .DESCRIPTION
    In the Rail Fence cipher, the message is written downwards on successive "rails" of an imaginary fence, then moving up when we get to the bottom (like a zig-zag).
    Finally the message is then read off in rows.

    .PARAMETER Message
    The message to be encoded.

    .PARAMETER Rails
    The number of rails to be use to construct the rail fence.

    .EXAMPLE
    Invoke-Encode -Message "EXERCISM" -Rails 2
    Returns: "EECSXRIM"
    #>
    [CmdletBinding()]
    Param(
        [string]$Message,
        [int]$Rails
    )

    -join (Get-Indices $Message $Rails | ForEach-Object { $Message[$_] })
}

Function Invoke-Decode() {
    <#
    .SYNOPSIS
    Implement decoding for the rail fence cipher.

    .DESCRIPTION

    .PARAMETER CipherText
    The ciphertext to be decoded.

    .PARAMETER Rails
    The number of rails to be use to construct the rail fence.

    .EXAMPLE
    Invoke-Decode -Ciphertext "EECSXRIM" -Rails 2
    Returns: "EXERCISM"
    #>
    [CmdletBinding()]
    Param(
        [string]$Ciphertext,
        [int]$Rails
    )

    $indices = Get-Indices $Ciphertext $Rails
    -join (0..($Ciphertext.Length - 1) | ForEach-Object { ,@($indices[$_], $Ciphertext[$_]) } | 
        Sort-Object -Stable -Property { $_[0] } | ForEach-Object { $_[1] })
}

Function Get-Indices([string]$msg, [int]$r) {
    0..($msg.Length - 1) | ForEach-Object { ,@([Math]::Abs(($_ + $r - 1) % (2 * $r - 2) - $r + 1), $_) } |
        Sort-Object -Stable -Property { $_[0] } | ForEach-Object { $_[1] }
}
