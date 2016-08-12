(: get unique cts addresses from a list of places :)
(: open the index db at the cts :)
(: open the document db at the node connected with the cts :)
(: rename the node :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
for $n in
let $doc := doc("/home/neven/rad/croala-pelagios/csv/tuberoidx-placenames3-300.xml")
return distinct-values($doc//*:placeName/@n)
let $node := db:open("tub-com-idx")//*:w[@n=$n]/@xml:id
return rename node db:open-id("tubero-commentarii", $node) as 'placeName'