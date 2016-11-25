declare variable $dbvalidation := map {
  'cp-loci' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng'
};
let$result := element list {
let $doc := doc("/home/neven/rad/croala-pelagios/csv/cpplaces2.xml")
  for $r in $doc//record
  let $citeno := $r/citebody/string()
  let $citeid := "locid" || $citeno
  let $citeurn := attribute citeurn { "urn:cite:croala:loci." || $citeid }
  let $citeidattr := attribute citeid { $citeid }
  return element record {
    $citeidattr,
    $r/nomen ,
    $r/label,
    $r/uri,
    element citebody { $citeurn , $r/citebody/text() },
    $r/creator,
    $r/datecreated
  }
}
return file:write("/home/neven/rad/croala-pelagios/csv/cpplaces.xml", $result)
(: validate:rng-report($doc, map:get($dbvalidation, "cp-loci")) :)