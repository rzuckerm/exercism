<#
.SYNOPSIS
    Implement an evaluator for a very simple subset of Forth.

.DESCRIPTION
    Forth is a stack-based programming language.

    Implement a very basic evaluator for a small subset of Forth.
    Your evaluator has to support the following words:

    - '+', '-', '*', '/' (integer arithmetic)
    - 'DUP', 'DROP', 'SWAP', 'OVER' (stack manipulation)

    Your evaluator also has to support defining new words using the customary syntax: ': word-name definition ;'.

    To keep things simple the only data type you need to support is signed integers of at least 16 bits size.

    You should use the following rules for the syntax: a number is a sequence of one or more (ASCII) digits, a word is a sequence of one or more letters, digits, symbols or punctuation that is not a number.
    (Forth probably uses slightly different rules, but this is close enough.)

    Words are case-insensitive.

    Your class should have these two methods: Evaluate to evaluate the inputs, and GetStack to retrieve the current state of the stack.
    
.EXAMPLE
    $forth = [Forth]::new()
    $forth.Evaluate(@(": BIG 1000 ;", "BIG 500 + 100 swap dup"))
    $forth.GetStack()
    Returns: @(100, 1500, 100)

    First define BIG as 1000.
    Add 1000 to the stack, then 500. Do the addition (+) of those two to get 1500
    100 is now being added to the stack, then we swap 1500 and 100
    After the swap 1500 is now on top, then we call dup and create another 1500
    So the final stack is [100, 1500, 1500]
#>

Class Forth {
    [int[]]$Stack = @()
    [hashtable]$Defs = @{}
    static [hashtable]$Ops = @{
        "+" = @{Size = 2; Func = {$this.Push($this.Pop() + $this.Pop()) }}
        "-" = @{Size = 2; Func = { $this.Push(-$this.Pop() + $this.Pop()) }}
        "*" = @{Size = 2; Func = { $this.Push($this.Pop() * $this.Pop()) }}
        "/" = @{Size = 2; Func = { $this.Push($this.Div($this.Pop(), $this.Pop())) }}
        "dup" = @{Size = 1; Func = { $this.Push($this.Stack[-1]) }}
        "drop" = @{Size = 1; Func = { $this.Pop() }}
        "swap" = @{Size = 2; Func = { $this.Push(@(($this.Pop()), ($this.Pop()))) }}
        "over" = @{Size = 2; Func = { $this.Push($this.Stack[-2]) }}
    }

    Forth() {}

    [void] Evaluate([string[]]$inputs) {
        $words = $inputs.ToLower().Split()
        for ($i = 0; $i -lt $words.Length;) {
            if (($word = $words[$i++]) -eq ":") {
                $iNext = [Array]::IndexOf($words, ";", $i)
                if ($iNext -lt $i + 1 -or $words[$i] -match '^-?\d') { throw "Illegal operation" }
                $this.defs[$words[$i]] = $words[($i + 1)..($iNext - 1)] | ForEach-Object { $this.defs[$_] ?? $_ }
                $i = $iNext + 1
            }
            elseif ($this.Defs.ContainsKey($word)) { $this.Evaluate($this.Defs[$word]) }
            elseif ([Forth]::Ops.ContainsKey($word)) {
                $this.CheckStack([Forth]::Ops[$word].Size)
                & ([Forth]::Ops[$word].Func)
            }
            elseif ($word -match '^-?\d+$') { $this.Push([int]::Parse($word)) }
            else { throw "Undefined operation" }
        }
    }

    [int[]] GetStack() { return $this.Stack }

    [void] hidden CheckStack([int]$size) {
        if (-not $this.Stack.Length) { throw "Stack is empty" }
        if ($this.Stack.Length -lt $size) { throw "Not enough items in stack to perform operation" }
    }

    [int] hidden Pop() {
        $value = $this.Stack[-1]
        $this.Stack = $this.Stack | Select-Object -SkipLast 1
        return $value
    }

    [void] hidden Push([object]$value) { $this.Stack += $value }

    [int] hidden Div([int]$den, [int]$num) {
        if ($den -eq 0) { throw "Can't divided by 0" }
        return [int][Math]::Floor($num / $den)
    }
}
