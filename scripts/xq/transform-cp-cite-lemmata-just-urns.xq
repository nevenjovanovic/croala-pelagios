let $lemma2 := element list {
for $r in collection("cp-cite-lemmata")//record
let $id := $r/@citeid/string()
let $citeurn := element citeurn { $r/seg/@citeurn/string()}
let $citelemma := element citelemma { $r/lemma/@citeurn/string()}
let $ctsurn := element ctsurn { $r/seg/@cts/string()}
let $creator := $r/creator
let $datecre := $r/datecreated
return element record {
  attribute xml:id { $id },
  $citeurn ,
  $citelemma ,
  $ctsurn ,
  $creator ,
  $datecre
}
}
return file:write("/home/neven/rad/croala-pelagios/csv/cite-lemmata-urns.xml", $lemma2)