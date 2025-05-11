<#
.SYNOPSIS
    Given students' names along with the grade that they are in, create a roster for the school.
.DESCRIPTION
    Add a student's name to the roster for a grade
    "Add Jim to grade 2."
    "OK."
    Get a list of all students enrolled in a grade
    "Which students are in grade 2?"
    "We've only got Jim just now."
    Get a sorted list of all students in all grades. Grades should sort as 1, 2, 3, etc., and students within a grade should be sorted alphabetically by name.
    "Who all is enrolled in school right now?"
    "Grade 1: Anna, Barb, and Charlie. Grade 2: Alex, Peter, and Zoe. Grade 3…"
    Note that all our students only have one name. (It's a small town, what do you want?)
.EXAMPLE
    $roster = [Roster]::new()
    $roster.AddStudent(1,'Billy')
    $roster.AddStudent(1,'Josh')
    $roster.AddStudent(2,'Allison')
    $roster.GetRoster()
    $roster.GetRoster(2)

    This will create a new roster and add 3 students to it.
    When no arguments are supplied to the GetRoster method, all students will be returned.
    When a grade number is supplied to the GetRoster method, students from that grade will be returned.
#>

class Student {
    [int]$Grade
    [string]$Name

    Student([int]$Grade, [string]$Name) {
        $this.Grade = $Grade
        $this.Name = $Name
    }
}

class Roster {
    [Student[]]$Students

    [bool] AddStudent([int]$Grade, [string]$Name) {
        if ($Name -in $this.Students.Name) { return $false }
        $this.Students += [Student]::new($Grade, $Name)
        return $true
    }

    [Student[]] GetRoster() {
        return $this.Students | Sort-Object -property Grade, Name
    }

    [Student[]] GetRoster([int]$Grade) {
        return $this.Students | Where-Object { $_.Grade -eq $Grade } | Sort-Object -property Name
    }
}
