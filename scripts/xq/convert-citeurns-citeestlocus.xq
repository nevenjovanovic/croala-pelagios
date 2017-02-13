(: convert material from cp-cite-urns to format for joining with cp-cite-loci :)
let $list := element list {
for $r in collection("cp-cite-urns")//w[matches(@ana, "estlocus")]
let $xmlid := $r/@xml:id
let $ctsurn := $r/@n
let $citeurn := $r/@citeurn
let $locusurn := $r/@locusurn
let $creator := $r/@creator
let $record := element record {
  $xmlid,
  element citeurn { $citeurn/string()},
  element locusurn { $locusurn/string()},
  element ctsurn { $ctsurn/string()},
  element creator { $creator/string()}
}
return $record
}
return $list