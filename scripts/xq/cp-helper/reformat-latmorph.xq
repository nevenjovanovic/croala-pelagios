element list {
for $r in collection("cp-latmorph")//record
let $citeid := $r/morphcode/@citeid
let $citeurn := $r/morphcode/@citeurn
let $morphcode := $r/morphcode/string()
let $label := $r/label
return element record {
  $citeid ,
  element morphcode {
    $citeurn ,
    $morphcode
  } ,
  $label
}
}