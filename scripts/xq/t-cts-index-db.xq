(: Create db with indices to tubero-commentarii w elements :)
declare function local:ntree($words) {
  for $f in $words
let $ctsname := "urn:cts:croala:tubero.commentarii.croala-verba:"
let $tree := string-join(data($f/ancestor-or-self::*[@n]/@n),'.')
return element w { attribute xml:id {db:node-id($f)} , attribute n { $ctsname || $tree } , data($f) }
};
let $windex :=
element wlist {
for $f in db:open("tubero-commentarii")//*:w
let $ntree := local:ntree($f)
return $ntree
}
return db:create("tub-com-idx", $windex, "tub-com-idx.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })