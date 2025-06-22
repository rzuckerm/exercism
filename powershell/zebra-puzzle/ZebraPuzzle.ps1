Enum Nationality { Norwegian ; Spaniard ; English ; Ukranian ; Japanese }

$Global:Items = @{
    "Nation" = [Nationality].GetEnumNames()
    "Drink" = @("Tea", "Orange Juice", "Milk", "Water", "Coffee")
    "Hobby" = @("Paint", "Dance", "Read", "Football", "Chess")
    "Pet" = @("Dog", "Horse", "Snails", "Fox", "Zebra")
}

# Things that are known by working through the clues
$Global:Knowns = @{
    # Since all colors are known, there's no need to include them
    # Color = @("Yellow", "Blue", "Red", "Ivory", "Green")
    "Nation" = @("Norwegian", "", "English", "", "")
    "Drink" = @("", "", "Milk", "", "Coffee")
    "Hobby" = @("Paint", "", "", "", "")
    "Pet" = @("", "Horse", "", "", "")
}

# Combinations of pets and hobbies that are known by working through the clues
$Global:KnownCombos = @(
    @(@("Pet", "Fox"), @("Hobby", "Read")),
    @(@("Hobby", "Read"), @("Pet", "Fox")),
    @(@("Hobby", "Read"), @("Pet", "Fox")),
    @(@("Pet", "Fox"), @("Hobby", "Read"))
)

Function Get-ZebraOwner() {
    <#
    .SYNOPSIS
    Solve the zebra puzzle and return who owns the zebra.
    #>

    Invoke-Solve "Pet" "Zebra"
}

Function Get-WaterDrinker() {
    <#
    .SYNOPSIS
    Solve the zebra puzzle and return who drinks water.
    #>

    Invoke-Solve "Drink" "Water"
}

Function Invoke-Solve([string]$category, [string]$target) {
    # Start with knowns and try known combinations
    for ($n = 0; $n -lt $Global:KnownCombos.Length; $n++) {
        $solution = @{}
        $Global:Knowns.GetEnumerator() | ForEach-Object { $solution[$_.Key] = $_.Value.Clone() }
        ($category1, $item1), ($category2, $item2) = $Global:KnownCombos[$n]
        $solution[$category1][$n], $solution[$category2][$n + 1] = $item1, $item2

        # Get candidate nations, drinks, hobbies, and pets and their corresponding unknown indices
        $candidates = @{}
        $unknownIndices = @{}
        foreach ($item in $Global:Items.GetEnumerator()) {
            $candidates[$item.Key] = $item.Value | Where-Object { $_ -notin $solution[$item.Key] }
            $unknownIndices[$item.Key] = 0..($item.Value.Length - 1) | Where-Object { -not $solution[$item.Key][$_] }
        }

        # Try out candidate nations
        foreach ($nations in (Get-Permutations $candidates.Nation)) {
            # Put this permutation of nations into the solution
            Set-Solution $solution "Nation" $nations $unknownIndices.Nation

            # Try out candidate pets
            foreach ($pets in (Get-Permutations $candidates.Pet)) {
                # Put this permutation of pets into the solution
                Set-Solution $solution "Pet" $pets $unknownIndices.Pet

                # If Spaniard doesn't have a dog, try another pet permutation
                if (-not (Test-Solution $solution.Nation "Spaniard" $solution.Pet "Dog")) { continue }

                # Try out candidate hobbies
                foreach ($hobbies in (Get-Permutations $candidates.Hobby)) {
                    # Put this permutation of smokes into the solution
                    Set-Solution $solution "Hobby" $hobbies $unknownIndices.Hobby

                    # If the Japanese doesn't play chess or the owner of snails doesn't dance,
                    # try another hobby permutation
                    if (-not (Test-Solution $solution.Nation "Japanese" $solution.Hobby "Chess") -or
                        -not (Test-Solution $solution.Pet "Snails" $solution.Hobby "Dance")) { continue }

                    # Try out candidate drinks
                    foreach ($drinks in (Get-Permutations $candidates.Drink)) {
                        # Put this permutation of drinks into the solution
                        Set-Solution $solution "Drink" $drinks $unknownIndices.Drink

                        # If the Ukranian drinks tea and the drinker of orange juice play football,
                        # return the solution
                        if ((Test-Solution $solution.Nation "Ukranian" $solution.Drink "Tea") -and
                            (Test-Solution $solution.Drink "Orange Juice" $solution.Hobby "Football")) {
                            return [Nationality]($solution.Nation[$solution[$category].IndexOf($target)])
                        }
                    }
                }
            }
        }
    }

    return $null
}

# https://www.geeksforgeeks.org/dsa/print-all-possible-permutations-of-an-array-vector-without-duplicates-using-backtracking/
Function Get-Permutations([object[]]$arr) {
    Function Permute([object[]]$arr, [int]$idx) {
        if ($idx -ge $arr.Length) { return @(, $arr.Clone()) }
        for ($i = $idx; $i -lt $arr.Length; $i++) {
            $arr[$idx], $arr[$i] = $arr[$i], $arr[$idx]
            Permute $arr ($idx + 1)
            $arr[$idx], $arr[$i] = $arr[$i], $arr[$idx]
        }
    }

    @(Permute $arr 0)
}

Function Set-Solution([hashtable]$solution, [string]$key, [string[]]$items, [string[]]$indices) {
    for ($n = 0; $n -lt $indices.Length; $n++) { $solution[$key][$indices[$n]] = $items[$n] }
}

Function Test-Solution([string[]]$items1, [string]$item1, [string[]]$items2, [string]$item2) {
    $items1.IndexOf($item1) -eq $items2.IndexOf($item2)
}
