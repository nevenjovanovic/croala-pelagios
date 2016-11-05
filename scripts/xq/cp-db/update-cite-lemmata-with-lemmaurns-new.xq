for $r in collection("cp-cite-lemmata")//record
let $lemma := $r/lemma
let $searchterm := fn:upper-case($lemma/string())
let $newlemmaurn := collection("cp-latlexents")//record[lemma/string()=$searchterm]/uri/string()
return replace value of node $lemma/@citeurn with $newlemmaurn