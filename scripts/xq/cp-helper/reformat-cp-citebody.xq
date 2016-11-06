element list {
for $r in collection("cp-citebody")//r
let $l := $r/note/entry/string()
let $id := attribute xml:id { substring-after($l, "urn:cite:croala:loci.") }
let $locusurn := attribute citeurn { $l }
let $n := $r/anno/entry/string()
let $creator := $r/creator/entry/string()
return element record {
  $id ,
  element locus { $locusurn },
  element notes { for $noteurn in $n return element note {
    attribute citeurn { $noteurn }
  } },
  element creator { $creator },
  element datecreated { format-date(current-date(), "[Y0001]-[M01]-[D01]") }
}
}