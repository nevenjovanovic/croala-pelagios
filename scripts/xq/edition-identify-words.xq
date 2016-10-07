let $windex := element list {
for $w in collection("modr-morph")//*:w
let $s := data($w/parent::*/parent::*/@n) || "." || data($w/parent::*/@n) || "." || data($w/@n)
return element w { 
attribute id { db:node-id($w)},
attribute urn {
$s } ,
$w/text()
}
}
return db:create("modr-editio-sv-idx", $windex, "modr-sv-idx.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })