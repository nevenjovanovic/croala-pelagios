declare variable $dbvalidation := map {
  'cp-loci' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng'
};
let $result := element list {
let $doc := doc("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/aetates-id-novae.xml")
    for $r in $doc//record[citebody/string()]
  let $citeno := $r/citebody/string()
  let $citeidattr := attribute xml:id { $citeno }
  let $citeurn := attribute citeurn { "urn:cite:croala:loci." || $citeno }
  return element record { 
  $citeidattr,
  $r/label ,
  element citebody { $citeurn , substring-after($r/citebody/text(), "aetas") } ,
  $r/uri ,
  $r/creator ,
  $r/datecreated
}
}
let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/aetates/aetates-id-novae-2.xml"
return file:write($fileuri, $result)
(: validate:rng-report($doc, map:get($dbvalidation, "cp-loci")) :)