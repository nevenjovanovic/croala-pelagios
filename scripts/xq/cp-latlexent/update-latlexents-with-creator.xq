let $d := doc("/home/neven/rad/croala-pelagios/csv/cp-croala-latlexents.xml")
for $r in $d//record
let $creator := "http://" || $r/entry[6]/string()
let $lemma := fn:upper-case($r/entry[2]/string())
for $match in collection("cp-latlexents")//record[lemma/text()=$lemma]
return insert node $creator into $match/creator