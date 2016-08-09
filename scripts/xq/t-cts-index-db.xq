(: Create db with indices to tubero-commentarii w elements :)
declare function local:ntree($words) {
  for $f in $words
let $tree := string-join(data($f/ancestor-or-self::*[@n]/@n),'.')
return element w { attribute xml:id {db:node-id($f)} , attribute n { $tree } , data($f) }
};

for $f in db:open("tubero-commentarii")//*:w
let $ntree := local:ntree($f)
return $ntree
