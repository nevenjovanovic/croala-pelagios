for $w in collection("modr-morph")//*:pc
let $n := $w/@n
let $newid := "pc" || xs:string(count($w/preceding-sibling::*) + 1)
return replace value of node $n with $newid

(: return if (data($n) ne $newid ) then element r { $n , $newid } else() :)
