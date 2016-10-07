let $csv2 := element csv {
let $cr := collection("cp-tokenize")
for $w in $cr//*:TEI/*:text//*:w[matches(@ana,'estlocus')]
let $context := string-join(for $wpc in $w/../* return data($wpc), ' ')
let $n := $w/@n
let $estlocus := $w/@ana/string()
let $urn := replace(db:path($w), '.xml', '')
let $exclude := ("TEI", "text")
let $path := string-join(
  for $a in $w/ancestor::*[not(name()=$exclude)]/@n/string()
  return concat($a , "."))
return element entry { 
element loc { $estlocus },
$w ,
element con { $context } ,
element id { $urn || ":" || $path || $n },
element nodeid { db:node-id($w)}
 }
}
return file:write("/home/neven/rad/croala-pelagios/csv/marul01.croala754085.croala-loci.csv" , csv:serialize($csv2))
(:  return csv:serialize($csv2) :)