element list {
let $d := collection("cp-cite-lemmata")
for $r in $d//record
let $cts :=  attribute cts { $r/entry[1]/string() }
let $seg :=  $r/entry[2]/string()
let $citeurn := $r/entry[3]/string()
let $citeid := substring-after($citeurn, "urn:cite:croala:loci.")
let $citeurnattr := attribute citeurn { $citeurn }
let $citeidattr := attribute citeid { $citeid }
let $citelemma := attribute citeurn { $r/entry[5]/string() }
let $lemma := element lemma { $citelemma , $r/entry[4]/string() }
let $creator := element creator { $r/entry[6]/string() }
let $datecreated := element datecreated { $r/entry[8]/string() }
return element record {
  $citeidattr ,
  element seg {
  $cts,
  $seg
},
  $lemma,
$creator ,
$datecreated
}
}