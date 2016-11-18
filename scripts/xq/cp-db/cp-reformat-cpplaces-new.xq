declare variable $dbvalidation := map {
  'cp-loci' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng'
};
copy $doc := doc("/home/neven/Repos/croala-pelagios/csv/cpplaces2.xml")
modify (
  for $r in $doc//record
  let $citeno := $r/citebody/string()
  let $citeid := "locid" || $citeno
  let $citeurn := attribute citeurn { "urn:cite:croala:loci." || $citeid }
  let $citeidattr := attribute citeid { $citeid }
  return ( insert node $citeidattr into $r , 
  insert node $citeurn into $r/citebody )
)
return file:write("/home/neven/Repos/croala-pelagios/csv/cpplaces.xml", $doc)
(: validate:rng-report($doc, map:get($dbvalidation, "cp-loci")) :)