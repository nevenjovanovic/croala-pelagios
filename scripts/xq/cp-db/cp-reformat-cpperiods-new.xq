declare variable $dbvalidation := map {
  'cp-loci' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng'
};
let $result := element list {
let $doc := doc("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/myth-periods1.xml")
    for $r in $doc//record
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
return file:write("/home/neven/rad/croala-pelagios/csv/cpperiods-myth-2.xml", $result)
(: validate:rng-report($doc, map:get($dbvalidation, "cp-loci")) :)