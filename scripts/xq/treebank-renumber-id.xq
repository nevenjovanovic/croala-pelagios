for $w in //*:word
let $newid := xs:string(count($w/preceding-sibling::*) + 1)
return replace value of node $w/@id with $newid