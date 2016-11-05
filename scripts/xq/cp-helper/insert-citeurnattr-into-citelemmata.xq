for $r in collection("cp-cite-lemmata")//record
let $citeid := $r/@citeid/string()
let $segciteurn := "urn:cite:croala:loci." || $citeid
let $segciteurnattr := attribute citeurn { $segciteurn }
return insert node $segciteurnattr into $r/seg