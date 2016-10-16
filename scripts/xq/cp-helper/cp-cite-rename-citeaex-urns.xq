(: rename values of @citeaex analytical exemplar URN :)
declare variable $flist := map {
  "urn:cts:croala:tubero.commentarii.croala-loci": "urn:cts:croala:crije01.croala789994.croala-lat2w",
  "urn:cts:croala:modruski-n.oratio-riario.croala-loci" : "urn:cts:croala:nikolamodr01.croala1394919.croala-lat2loci"
};
let $names := ("urn:cts:croala:modruski-n.oratio-riario.croala-loci", "urn:cts:croala:tubero.commentarii.croala-loci")
for $n in $names
let $newcts := map:get($flist,$n)
for $oldurn in collection("cp-cite-urns")//*:list/w[starts-with(@citeaex,$n)]
let $newurn := replace($oldurn/@citeaex, $n, $newcts)
return replace value of node $oldurn/@citeaex with $newurn