Function Invoke-Parser {
    <#
    .SYNOPSIS
    Refactor a Markdown parser.

    .DESCRIPTION
    The markdown exercise is a refactoring exercise.
    There is code that parses a given string with [Markdown syntax][markdown] and returns the associated HTML for that string.
    Even though this code is confusingly written and hard to follow, somehow it works and all the tests are passing!
    Your challenge is to re-write this code to make it easier to read and maintain while still making sure that all the tests keep passing.

    .PARAMETER Markdown
    A string of markdown text to be parsed into HTML.

    .EXAMPLE
    Invoke-Parser -Markdown "__Exercism__ is awesome"
    Returns: "<p><strong>Exercism</strong> is awesome</p>"
    #>
    [CmdletBinding()]
    Param(
        [string]$Markdown
    )

    # Convert \\n to newline
    $html = $Markdown -replace "\\n", "`n"

    # Headers
    $html = $html -replace '^(#{1,6}) (.*)', { $l = $_.Groups[1].Length; "<h$l>$($_.Groups[2])</h$l>" }

    # Bold
    $html = $html -replace '__(.*)__', '<strong>$1</strong>'

    # Italics
    $html = $html -replace '_(.*)_', '<em>$1</em>'

    # List items
    $html = $html -replace '(?m)^\* (.*)', '<li>$1</li>'

    # Unordered lists
    $html = $html -replace '(?s)(<li>.*</li>)', '<ul>$1</ul>'

    # Paragraphs
    $html -replace '(?m)^(?!<h[1-6]>|<li>|<ul>)(.*)', '<p>$1</p>' -replace "`n", ""
}
