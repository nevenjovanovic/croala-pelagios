(: Create db with indices to tubero-commentarii placeName elements :)
(: tubero-commentarii includes two files :)
declare function local:ntree($words, $ctsname) {
  for $f in $words
let $tree := string-join(data($f/ancestor-or-self::*[@n]/@n),'.')
return element w { 
attribute xml:id {db:node-id($f)} , 
attribute n { $ctsname || $tree } , 
$f/@ana , 
data($f) }
};
declare variable $flist := map {
  "tubero-commentarii-rezar-p-s-w-placename-n.xml": "urn:cts:croala:tubero.commentarii.croala-loci:",
  "modr-n-oratio-riar-jovanovic-loci.xml": "urn:cts:croala:modruski-n.oratio-riario.croala-loci:"
};
let $windex :=
element wlist {
  for $xmlfile in map:keys($flist)
  let $cts := map:get($flist,$xmlfile)
for $f in db:open("tubero-commentarii", $xmlfile)//*:text//*[name()='placeName' or name()='w' and @ana]
let $ntree := local:ntree($f, $cts)
return $ntree
}
return db:create("tub-com-placename-idx", $windex, "tub-com-idx.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })