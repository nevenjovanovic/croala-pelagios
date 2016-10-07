(: create CITE URNs from @xml:id :)
let $citeindex := element list {
for $cite in collection("cp-cts-urns")//*:w
let $cts := $cite/@n
let $label := $cite/text()
let $citeana := "urn:cite:croala:loci.ana." || $cite/@xml:id
let $citeaex := replace($cts, "-loci:", "-loci.lexis:")
return element w {
  $cts,
  attribute citeurn { $citeana },
  attribute citeaex { $citeaex },
  $label
}
}
return db:create("cp-cite-urns", $citeindex, "cp-citeurns.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })