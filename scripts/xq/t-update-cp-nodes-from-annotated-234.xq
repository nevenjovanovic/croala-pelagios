(: import annotated csv with decisions on place names :)
(: for the first 200 annotations :)
(: return decision values, update their nodes in tubero-commentarii :)
(: add ana=locus2 etc :)
declare default element namespace "http://www.tei-c.org/ns/1.0";

let $f := file:read-text("/home/neven/rad/croala-pelagios/csv/cp-cite-cts-2-202.csv")
for $r in csv:parse($f)//*:record
let $id := data($r/*:entry[1])
let $value := "estlocus" || data($r/*:entry[3])
let $node := db:open-id("tubero-commentarii", $id)
return insert node attribute {'ana'} { $value }  into $node