<#
.SYNOPSIS
    Manage robot factory settings.

.DESCRIPTION
    Generate a random name for a robot when it is created.
    The name should be in the format of two uppercase letters followed by three digits, such as RX837 or BC811.
    The robot should be able to reset and get a completely new name. (Old name that got reset should not be available for future use)

.EXAMPLE
    $robot = [Robot]::new()
    $robot.Name
    Returns: "EX341"
#>

Class Robot {
    [String]$Name
    static [String[]]$Names = @()
    static [int]$Count = 0


    Robot() { $this.Reset() }

    [void] Reset() {
        if (-not [Robot]::Count) {
            [Robot]::Names = @(foreach ($l1 in 'A'..'Z') {
                foreach ($l2 in 'A'..'Z') { 0..999 | ForEach-Object { "{0}{1}{2:d3}" -f $l1, $l2, $_ } }
            }) | Get-Random -Shuffle
        }

        $this.Name = [Robot]::Names[[Robot]::Count]
        [Robot]::Count = ([Robot]::Count + 1) % [Robot]::Names.Length
    }
}
