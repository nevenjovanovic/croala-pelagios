let $csv2 := element csv {
let $cr := collection("cp-tokenize")
for $w in $cr//*:text//*:w[@ana='estlocusX']
let $context := string-join(for $wpc in $w/../* return data($wpc), ' ')
let $n := $w/@n
let $urn := replace(db:path($w), '.xml', '')
let $exclude := ("TEI", "text")
let $path := string-join(
  for $a in $w/ancestor::*[not(name()=$exclude)]/@n/string()
  return concat($a , "."))
return element entry { 
element loc { "estlocusX" },
$w ,
element con { $context } ,
element id { $urn || ":" || $path || $n },
element nodeid { db:node-id($w)}
 }
}
return file:write("/home/neven/rad/croala-pelagios/csv/crije01.croala789994-estlocusx.csv" , csv:serialize($csv2))
(:  return csv:serialize($csv2) :)