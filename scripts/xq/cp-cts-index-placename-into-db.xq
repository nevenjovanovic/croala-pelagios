(: cp-cts-index-placename-into-db.xq :)
(: Create db with indices to cp elements with @n and @ana :)
(: cp includes two files :)
declare function local:ntree($words, $ctsname) {
  for $f in $words
let $tree := string-join(data($f/ancestor-or-self::*[@n]/@n),'.')
return element w { 
attribute xml:id {db:node-id($f)} , 
attribute n { $ctsname || ":" || $tree } , 
attribute aex { $ctsname || ".lexis:" || $tree } , 
$f/@ana , 
data($f) }
};
let $windex :=
element wlist {
for $xmlfile in collection("cp-2-texts")//*:TEI[descendant::*:w]
let $cts := $xmlfile//*:text/@xml:base
let $names := ("placeName", "name", "w", "tei:w")
for $f in $xmlfile//*:text//*[name()=$names]
let $ntree := local:ntree($f, $cts)
return $ntree
}
return db:create("cp-cts-urns", $windex, "cts-urns.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })