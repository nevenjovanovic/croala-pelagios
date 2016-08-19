(: import annotated csv with decisions on place names :)
(: for the first 427 annotations :)
(: for placeName nodes in tubero-commentarii, update @ana attribute values :)
(: if they are different :)
(: if @ana is missing, add it :)
(: for nodes which are not placeName, do nothing :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $limit := 427
let $f := file:read-text("/home/neven/rad/croala-pelagios/csv/t-cite-427.csv")
for $r in csv:parse($f)//*:record[position()<=$limit]
let $id := data($r/*:entry[1])
let $ana := data($r/*:entry[3])
let $tubnode := db:open-id("tubero-commentarii", $id)
return if ($tubnode/name()='placeName' and $tubnode/@ana) then 
 if ($tubnode/@ana!=$ana) then replace value of node $tubnode/@ana  with $ana
else()
else if ($tubnode/name()='placeName') then insert node attribute ana { $ana } into $tubnode
else()