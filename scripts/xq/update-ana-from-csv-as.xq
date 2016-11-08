(: import new estlocus annotations :)
(: test whether they match with old ones :)
(: docs should be pulled from Github :)
let $csvs := ("/home/neven/Repos/croala-pelagios/csv/bunic-deraptucerberi-loci.csv", "/home/neven/Repos/croala-pelagios/csv/tubero-commentarii-loci.csv", "/home/neven/Repos/croala-pelagios/csv/crijevic-carmina-loci.csv", "/home/neven/Repos/croala-pelagios/csv/marulic-carmina-loci.csv" )
let $source :=
for $c in $csvs
let $csv := file:read-text($c)
return csv:parse($csv, map { 'header': true() })
for $e in $source//record
let $estlocus := attribute ana { $e/estLocus/string() }
let $urn := "urn:cts:croala:" || $e/URN/string()
let $idx := collection("cp-cts-urns")//w[@n=$urn]
return if (xs:integer($idx/@xml:id)) then 
  if (db:open-id("cp-2-texts", $idx/@xml:id)/@ana) then 
  replace value of node db:open-id("cp-2-texts", $idx/@xml:id)/@ana with $estlocus/string()
  else if (db:open-id("cp-2-texts", $idx/@xml:id)) 
  then insert node $estlocus into db:open-id("cp-2-texts", $idx/@xml:id)
  else()
else()