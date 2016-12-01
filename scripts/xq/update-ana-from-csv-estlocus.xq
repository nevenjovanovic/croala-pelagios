(: import new estlocus annotations :)
(: test whether they match with old ones :)
(: csv files are pulled from Github :)
let $csvs := ("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/bunic-deraptucerberi-loci.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/tubero-commentarii-loci.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/crijevic-carmina-loci.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/marulic-carmina-loci.csv" )
let $source :=
for $c in $csvs
let $csv := fetch:text($c)
return csv:parse($csv, map { 'header': true() })
for $e in $source//record
let $estlocus := attribute ana { $e/estLocus/string() }
let $urn := "urn:cts:croala:" || $e/URN/string()
let $idx := collection("cp-cts-urns")//w[@n=$urn]
let $text_loc := if ($idx) then db:open-id("cp-2-texts", $idx/@xml:id) else()
return if ($text_loc) then 
  if ($text_loc/@ana) then 
  replace value of node $text_loc/@ana with $estlocus/string()
  else insert node $estlocus into $text_loc
else()