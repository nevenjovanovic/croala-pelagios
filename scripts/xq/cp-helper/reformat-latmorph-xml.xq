element list {
let $d := "/home/neven/Repos/croala-pelagios/csv/latmorph.xml"
for $r in doc($d)//record
let $citeurn := $r/entry[1]/string()
let $citeid := substring-before(substring-after($citeurn, "croala:latmorph."), ".")
let $citeurnattr := attribute citeurn { $citeurn }
let $citeidattr := attribute citeid { $citeid }
let $morphcode := $r/entry[2]/string()
let $label := $r/entry[3]/string()
return element record {
  element morphcode {
  $citeidattr ,
  $citeurnattr,
  $morphcode
},
element label {
  $label
}
}
}