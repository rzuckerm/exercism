<#
.SYNOPSIS
Implement a simple shift cipher like Caesar and a more secure substitution cipher.

.DESCRIPTION
Implement a simple cipher class to encode or decode a message with a key.
If there was no key provided, generate one minumum 100 characters long contains only lower case letter (a-z).

.EXAMPLE
$cipher = [SimpleCipher]::new("mykey")

$cipher.Encode("aaaaa")
Return: "mykey"

$cipher.Decode("ecmvcf")
Return: "secret"
#>

Class SimpleCipher {
    [string]$_key

    SimpleCipher() {
        $this._key = -join (1..100 | ForEach-Object { 'a'..'z' | Get-Random })
    }

    SimpleCipher([string]$key) {
        $this._key = $key
    }

    [string] hidden Transform([string]$text, [ScriptBlock]$func) {
        return -join (0..($text.Length -1) |
            ForEach-Object {
                [char](((& $func ([char]$text[$_] - 97) ([char]$this._key[$_ % $this._key.Length] - 97)) % 26 + 26) % 26 + 97)
            })
    }

    [string] Encode([string]$text) {
        return $this.Transform($text, { param([int]$a, [int]$b) $a + $b })
    }

    [string] Decode([string]$text) {
        return $this.Transform($text, { param([int]$a, [int]$b) $a - $b })
    }
}
