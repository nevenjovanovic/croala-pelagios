(: create db with CITE annotation + CITE Body URN pointing towards lemma :)
(: basic: Cite annotation, CITE Body URN :)
(: control: CTS URN of CITE annotation, lemma label :)
(: resp: creator, timestamp created :)
(: read in csv, get relevant fields :)
let $source := "/home/croala/croala-pelagios/csv/cite-lemmata.xml"
return  db:create("cp-cite-lemmata", $source, (), map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })