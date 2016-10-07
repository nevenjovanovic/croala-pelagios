for $w in collection("modr-morph")//*:w
let $n := $w/@n
let $newid := "w" || xs:string(count($w/preceding-sibling::*) + 1)
(: return if (data($n) ne $newid ) then element r { $n , $newid } else() :)
return replace value of node $n with $newid