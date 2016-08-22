let $d := let $file := file:read-text("/home/neven/rad/croalapelagiosxml/d.json")
let $json := json:parse($file)
return $json
for $t in $d//*[*:stop]
let $start := xs:integer(data($t/*:start/*:in/*:year))
where $start > 0 and $start < 1950
order by $start
return element p { $t/name() , $start }