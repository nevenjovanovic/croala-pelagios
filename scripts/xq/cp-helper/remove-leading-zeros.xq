for $r in //record[matches(citeurn, "ana0+")]
let $newid := replace($r/citeurn, "ana0+","ana")
return replace value of node $r/citeurn with $newid