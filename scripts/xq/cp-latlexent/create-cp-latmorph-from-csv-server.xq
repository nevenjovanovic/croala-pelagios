(: from a csv of postags, create cite inventory for Latin morphology :)
(: on server :)
let $i := file:read-text("/home/croala/croala-pelagios/csv/citeposlist.csv")
let $csv := csv:parse($i)
return db:create("cp-latmorph", $csv, "latmorph")
(: return $csv :)