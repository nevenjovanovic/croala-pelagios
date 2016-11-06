for $r in collection("cp-citebody")//note/entry/string()
let $n := $r
let $l := collection("cp-loci")//record[citebody/@citeurn=$n]
return $l