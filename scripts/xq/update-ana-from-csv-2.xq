(: import NC appendix :)
(: find in MM all w which are not estlocus :)
(: test whether they match with NC :)
let $source :=
let $csv := file:read-text("/home/neven/rad/croalapelagiosxml/oznaceno/marulic-carmina-loci-nc.csv")
return csv:parse($csv, map { 'header': true() })
for $e in $source//record/Nomen
let $estlocus := attribute ana { $e/../estLocus/string() }
let $urn := $e/../URN/string()
let $idx := collection("cp-cts-urns")//w[@n=$urn]
return if ($idx/@ana/string() != $estlocus/string() ) then replace value of node db:open-id("cp-2-texts", $idx/@xml:id)/@ana with $estlocus/string()
else()