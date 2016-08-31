(: create XML to display CITE body from CITE URN :)
(: version 2, based on Modruški :)
let $csv := file:read-text("/home/neven/rad/croala-pelagios/csv/modridx-citebodies.csv")
let $cdb := csv:parse($csv)
let $result := element list {
for $c in $cdb//record
let $note := element note { $c/entry[1] }
let $citeanas := element anno { for $e in tokenize($c/entry[2], ' ') return element entry { $e } }
let $placeuris := element place { for $p in tokenize($c/entry[3], ' ') return element entry { $p } }
let $label := element label { $c/entry[4] }
let $period := element period { element entry { "http://n2t.net/ark:/99152/p0qhb66pk6z" } }
let $periodlabel := element periodlabel { element entry { 
  "Renaissance (Italy less Sicily, Sardinia, Tuscany, Umbria, 1350-1549)"
} }
let $creator := element creator { element entry { "http://orcid.org/0000-0002-9119-399X" } }
return element r {
  $note ,
  $citeanas ,
  $placeuris ,
  $label ,
  $period ,
  $periodlabel ,
  $creator
}
}
return $result