element list {
for $r in collection("cp-latlexents")//record
let $citeid := $r/uri/@citeid
let $citebody := $r/uri/string()
let $lemma := element lemma {
  attribute citeurn { $citebody },
  $r/lemma/string()
}
let $creator := $r/creator
let $datec := $r/datecreated
return element record {
  $citeid ,
  $lemma ,
  $creator ,
  $datec
}
}