(: create db with CITE annotation + CITE Body URN pointing towards lemma :)
(: basic: Cite annotation, CITE Body URN :)
(: control: CTS URN of CITE annotation, lemma label :)
(: resp: creator, timestamp created :)
(: read in csv, get relevant fields :)
let $source :=
let $csv := file:read-text("/home/neven/rad/croalapelagiosxml/oznaceno/modruski-lemmata.csv")
return csv:parse($csv)
let $target := element csv {
for $r in $source//record
let $word := $r/entry[2]
let $cts := $r/entry[5]
let $cite := $r/entry[7]
let $lemmalabel := $r/entry[9]
let $citelemma := $r/entry[10]
return element record {
  $cts ,
  $word ,
  $cite ,
  $lemmalabel ,
  $citelemma
} }
return  db:create("cp-cite-lemmata", $target, "cite-lemmata.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })