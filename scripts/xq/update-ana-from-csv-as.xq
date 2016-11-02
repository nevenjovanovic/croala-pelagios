(: import AS new annotations :)
(: find in JB doc all w :)
(: test whether they match with AS :)
let $source :=
let $csv := file:read-text("/home/neven/Repos/croala-pelagios/csv/bunic-deraptucerberi-loci.csv")
return csv:parse($csv, map { 'header': true() })
for $e in $source//record
let $estlocus := attribute ana { $e/estLocus/string() }
let $urn := "urn:cts:croala:" || $e/URN/string()
let $idx := collection("cp-cts-urns")//w[@n=$urn]
return if (db:open-id("cp-2-texts", $idx/@xml:id)/@ana) then replace value of node db:open-id("cp-2-texts", $idx/@xml:id)/@ana with $estlocus/string()
else if (db:open-id("cp-2-texts", $idx/@xml:id)) then insert node $estlocus into db:open-id("cp-2-texts", $idx/@xml:id)
else()