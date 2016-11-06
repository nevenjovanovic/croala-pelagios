element list {
for $a in collection("cp-aetates")//w
let $label := $a/label
let $urn := $a/citebody/string()
let $citeid := attribute xml:id { substring-after($urn, "urn:cite:croala:loci.") }
let $urnint := substring-after($urn , "urn:cite:croala:loci.aetas")
let $citeurn := attribute citeurn { $urn }
let $uri := element uri { $a/uri/string()
}
let $citebody := element citebody { $citeurn , $urnint }
let $creator := $a/creator
let $datec := $a/datecreated
return element record {
  $citeid ,
  $label ,
  $citebody ,
  $uri ,
  $creator ,
  $datec
}
}