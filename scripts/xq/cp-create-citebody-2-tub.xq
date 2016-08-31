let $doc1 := doc("/home/neven/rad/croala-pelagios/csv/cpidx-citeobjects-withlabels.xml")
let $result := element list {
for $r in $doc1//r
let $newnote := element note { element entry { data($r/note)} }
let $newplace := element place { element entry { data($r/place) } }
let $newlabel := element label { element entry { data($r/label)}}
let $newperiod := element period { element entry { data($r/period/a/@href)} }
let $periodlabel := element periodlabel { element entry { data($r/period/a) } }
let $creator := element creator { element entry { "http://orcid.org/0000-0002-9119-399X" }}
return element r {
  $newnote ,
  $r/anno ,
  $newplace ,
  $newlabel ,
  $newperiod ,
  $periodlabel ,
  $creator
}
}
return $result