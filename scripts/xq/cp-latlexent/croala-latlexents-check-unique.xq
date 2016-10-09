(: check whether URNs are unique :)

let $doc := "../../../csv/croala-latlexent.xml"
let $urns :=
for $r in doc($doc)//w
return $r/citebody/string()
for $duplicate in $urns[index-of($urns, .)[2]]
return $duplicate