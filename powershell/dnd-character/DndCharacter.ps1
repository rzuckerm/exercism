<#
.SYNOPSIS
    Generate a DnD character with all the classic abilities by rolling 4 dice.

.DESCRIPTION
    A DnD character starts has, among other things, six abilities:
    strength, dexterity, constitution, intelligence, wisdom and charisma.
    These abilities score are determined randomly by throwing dice.
    Throw 4 six-sided dice and return the the sum of the largest three.
    Your character's inittial hitpoints are: 10 + your character's constitution modifier.
    You find your character's constitution modifier by but this formula : (Constitution - 10) / 2 and then round down.
    
.EXAMPLE
    $character = [Character]::new()
    $character | Format-Table
    
    Strength Dexterity Constitution Intelligence Wisdom Charisma HitPoints
    -------- --------- ------------ ------------ ------ -------- ---------
           7        10           15            9     13       13        12

#>
Class Character {
    [int]$Strength
    [int]$Dexterity
    [int]$Constitution
    [int]$Intelligence
    [int]$Wisdom
    [int]$Charisma
    [int]$HitPoints

    Character() {
        [Character].GetProperties().Name | Where-Object { $_ -ne "HitPoints" } | ForEach-Object { $this.$_ = $this.Ability() }
        $this.HitPoints = 10 + [Character]::GetModifier($this.Constitution)
    }

    static [int] GetModifier([int]$Score) {
        return [Math]::Floor(($Score - 10) / 2)
    }

    [int] Ability() {
        $Stats = 1..4 | ForEach-Object { Get-Random -Minimum 1 -Maximum 7 } | Measure-Object -Sum -Minimum
        return $Stats.Sum - $Stats.Minimum
    }
}
