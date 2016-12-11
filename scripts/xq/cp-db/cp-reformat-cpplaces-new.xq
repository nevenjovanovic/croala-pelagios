declare variable $dbvalidation := map {
  'cp-loci' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng'
};
let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/loci/cpplaces.xml"
let $resulturi := substring-before(file:base-dir(), 'scripts/') || "csv/loci/cpplaces2.xml"
let $result := element list {
let $doc := doc($fileuri)
  for $r in $doc//record
  let $citeno := $r/citebody/string()
  let $citeid := "locid" || $citeno
  let $citeurn := attribute citeurn { "urn:cite:croala:loci." || $citeid }
  let $citeidattr := attribute citeid { $citeid }
  return if ($citeno) then element record {
    $citeidattr,
    $r/nomen ,
    $r/label,
    $r/uri,
    element citebody { $citeurn , $r/citebody/text() },
    $r/creator,
    $r/datecreated
  }
  else()
}
return if (validate:rng-report($result, map:get($dbvalidation, "cp-loci"))=<report>
  <status>valid</status>
</report>) 
then file:write($resulturi, $result) 
else validate:rng-report($result, map:get($dbvalidation, "cp-loci"))