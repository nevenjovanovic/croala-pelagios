let $csv2 := element csv {
let $cr := collection("cp-tokenize")
let $csv := file:read-text("/home/neven/rad/croalapelagiosxml/c-nomina.csv")
for $r in csv:parse($csv)//record/entry[1]
for $w in $cr//*:text//*:w[matches(.,$r)]
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
element id { $urn || ":" || $path || $n }
 }
}
return file:write("/home/neven/rad/croala-pelagios/csv/crije02.croala292491-estlocusx.csv" , csv:serialize($csv2))
 (: return $csv2 :)