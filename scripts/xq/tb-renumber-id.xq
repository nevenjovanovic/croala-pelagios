for $w in collection("modr-tb")//*:word
let $n := $w/@id
let $newid := "w" || xs:string(count($w/preceding-sibling::word) + 1)
return replace value of node $n with $newid