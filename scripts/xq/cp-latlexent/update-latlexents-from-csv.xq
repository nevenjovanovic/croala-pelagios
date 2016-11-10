declare function local:e($e, $name){
  element { $name } { data($e) }
};

let $csv := fetch:text("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/latlexents/cp-croala-latlexents-novi.csv")
let $result := element csv {
for $parsed in csv:parse($csv, map { 'header': true() })//record
let $urn := replace($parsed/CITE_URN, "\.1$", "")
let $citeid := substring-after($urn, "urn:cite:croala:latlexent.")
let $citeidattr := attribute citeid { $citeid }
let $cite := attribute citeurn { $urn }
let $lemma := element lemma { $cite, upper-case($parsed/Latin_lemma/string()) }
let $createdby := $parsed/Created_by
let $createdon := $parsed/Created_on
return element record {
  $citeidattr, 
  $lemma ,
  local:e(normalize-space($createdby), "creator") ,
  local:e($createdon, "datecreated")
}
}
for $r in $result//record
 let $db := db:open("cp-latlexents")//list/record/lemma/text()
where $r[lemma[not(text()=$db)]]
return insert node $r as last into $db/ancestor::list