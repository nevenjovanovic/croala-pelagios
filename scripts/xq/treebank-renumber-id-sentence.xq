for $tb in collection("modr-tb")//*:treebank
order by db:path($tb)
for $w in $tb/*:sentence
let $newid := "s" || xs:string(count($w/preceding-sibling::sentence) + 1)
return replace value of node $w/@id with $newid