for $w in collection("cp-placename-idx")//*:w[@ana='estlocusX']
let $ana := $w/@ana
let $urn := $w/@n
let $label := collection("cp-cite-urns")//*:cite[@n=$urn]/string()
let $context := collection("cp-cts-contexts")//*:cite[@n=$urn]/string()
return element record { $ana , $urn , 
element label { $label },
element context {$context }
}