declare default element namespace "http://www.tei-c.org/ns/1.0";

let $f := collection("cp-tokenize")//*:TEI
let $omit := ("witness", "pc", "abbr")
for $t in $f//*:text//*[not(name()=$omit)]/text()
let $ss :=
for $s in ft:tokenize($t,map { 'case': 'sensitive' })
return element w { $s }
return replace node $t with $ss
(: return $ss :)