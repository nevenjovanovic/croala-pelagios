(: import annotated csv with decisions on place names :)
(: for the first 102 annotations :)
(: return 0s, rename their nodes in tubero-commentarii :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $limit := 103
let $f := file:read-text("/home/neven/rad/croala-pelagios/csv/cp-cite-cts-102.csv")
for $r in csv:parse($f)//*:record[position()<$limit and *:entry[3][text() eq "0"]]
let $id := data($r/*:entry[1])
return rename node db:open-id("tubero-commentarii", $id) as 'name'