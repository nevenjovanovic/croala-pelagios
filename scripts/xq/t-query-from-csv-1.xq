(: todo -- return CTS address for div / div / para / sentence etc :)
declare function local:ntree($words) {
  for $f in $words
let $tree := string-join(data($f/ancestor-or-self::*[@n]/@n),'.')
return attribute n { $tree }
};


let $queries := for $n in 1 to 20
for $csv in csv:parse(file:read-text("/home/neven/rad/croala-pelagios/csv/tuberoidx-loci.csv"))//*:record[$n]/*:entry[1]
return $csv
for $q in $queries
let $results := element r {
for $f in db:open("tubero-commentarii")//*:w
let $ntree := local:ntree($f)
return element placeName { $ntree , data($f[text() contains text { $q } using fuzzy ]) } }
for $r in $results//*:placeName
return $r[matches(text(), '^[A-Z]')]