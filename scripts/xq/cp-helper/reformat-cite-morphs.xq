element list {
let $d := collection("cp-cite-morphs")
for $r in $d//record
let $citeurn := $r/entry[3]/string()
let $citeid := substring-after($citeurn, "urn:cite:croala:loci.")
let $citeurnattr := attribute citeurn { $citeurn }
let $cts :=  attribute cts { $r/entry[1]/string() }
let $seg :=  $r/entry[2]/string()

let $citeidattr := attribute citeid { $citeid }
let $citemorph := attribute citeurn { $r/entry[5]/string() }
let $morph := element morph { $citemorph , $r/entry[4]/string() }
let $creator := element creator { replace($r/entry[6]/string(), 'orcid', 'http://orcid') }
let $datecreated := element datecreated { $r/entry[8]/string() }
return element record {
  $citeidattr ,
  element seg {
  $cts,
  $citeurnattr ,
  $seg
},
  $morph,
$creator ,
$datecreated
}
}