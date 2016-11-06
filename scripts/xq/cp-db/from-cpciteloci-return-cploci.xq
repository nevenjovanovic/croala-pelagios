for $r in collection("cp-cite-loci")//locus/@citeurn/string()
let $n := $r
let $l := collection("cp-loci")//record[citebody/@citeurn=$n]
return $l