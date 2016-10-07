let $cr := collection("cpoe")
let $csv := file:read-text("/home/neven/rad/croalapelagiosxml/c-nomina.csv")
for $r in csv:parse($csv)//record/entry[1]
for $w in $cr//*:w[matches(.,$r)]
let $n := $w/@n
let $pln := element placeName { $w/@n , attribute ana {"estlocusX"} , $w/string() }
return replace node $w with $pln