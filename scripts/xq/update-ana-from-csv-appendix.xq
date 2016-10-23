(: import NC appendix :)
(: find in MM all w which are not estlocus :)
(: test whether they match with NC :)
let $source :=
let $csv := file:read-text("/home/neven/rad/croalapelagiosxml/oznaceno/marulic-carmina-appendix-nc.csv")
return csv:parse($csv, map { 'header': true() })
for $e in $source//record/Nomen
let $estlocus := attribute ana { $e/../estLocusX/string() }
let $target := collection("cp-2-texts")//*:text[@xml:base="urn:cts:croala:marul01.croala754085.croala-lat2w"]//*:w[not(@ana) and .=$e/string()]
return if ($target) then insert node $estlocus into $target
else()