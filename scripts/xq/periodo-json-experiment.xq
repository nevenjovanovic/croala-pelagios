let $d := let $file := file:read-text("/home/neven/rad/croalapelagiosxml/d.json")
let $json := json:parse($file)
return $json
let $defs := element defs {
for $t in $d//*:definitions/*
let $start := xs:integer(data($t/*:start/*:in/*:year))
where $start > -800 and $start < 1950
order by $start
return $t
}
return db:create("croala-periodo", $defs, "periodo.xml", map { 'ftindex': true(), 'chop': false(), 'intparse' : true() })
