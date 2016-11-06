element list {
for $a in collection("cp-aetates")//w
let $label := $a/label
let $urn := $a/citebody/string()
let $citeid := attribute xml:id { substring-after($urn, "urn:cite:croala:loci.") }
let $citeurn := attribute citeurn { $urn }
let $uri := element uri {
  $citeurn , $a/uri/string()
}
let $creator := $a/creator
let $datec := $a/datecreated
return element record {
  $citeid ,
  $label ,
  $uri ,
  $creator ,
  $datec
}
}