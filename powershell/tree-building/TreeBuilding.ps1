<#
.SYNOPSIS
    Refactor a tree building algorithm.

.DESCRIPTION
    The code below are ugly, confusing and slow.
    Not to mention it also failed all the test that need to raise error.
    Feel free to rework it however you want to pass the test suite.
#>

# this stub is adapted from the python track
Class Record {
    $RecordId
    $ParentId

    Record($RecordId, $parentId) {
        $this.RecordId = $RecordId
        $this.ParentId = $parentId
    }
}

Class Node {
    [int] $NodeID
    [Node[]] $Children = @()

    Node($id) { $this.NodeID = $id }
    [bool] IsLeaf() { return -not $this.Children.Count }
}

Function Build-Tree() {
    <#
    .DESCRIPTION
    Building tree function

    .PARAMETER Records
    Records used to build tree
    #>
    [CmdletBinding()]
    Param(
        [Record[]] $Records
    )
    $nodes = @{}
    $sortedRecords = $Records | Sort-Object RecordId
    for ($i = 0; $i -lt $sortedRecords.Count; $i++) {
        $record = $sortedRecords[$i]
        if ($record.RecordId -ne $i) { throw "Record id is invalid or out of order." }
        if ($record.RecordId -lt $record.ParentId) { throw "Node record id should be greater than parent id." }

        $nodes[$record.RecordId] = [Node]::new($record.RecordId)
        if ($record.RecordId) {
            if ($record.RecordId -eq $record.ParentId) { throw "Only root should have equal record and parent id (0)." }
            $nodes[$record.ParentId].Children += $nodes[$record.RecordId]
        }
    }

    return $nodes[0]
}
