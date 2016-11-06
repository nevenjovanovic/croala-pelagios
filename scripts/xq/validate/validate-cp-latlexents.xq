let $dbvalidation := map {
  'cp-latlexents' :  'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cplatlexents.rng',
  'cp-latmorph' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cplatmorph.rng',
  'cp-loci' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng',
  'cp-cite-lemmata' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpcitelemmata.rng',
  'cp-cite-urns' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpciteurns.rng',
  'cp-cite-morphs':  'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpcitemorphs.rng'
}
for $dbname in map:keys($dbvalidation)
for $doc in db:open($dbname)
let $result := validate:rng-report($doc, map:get($dbvalidation, $dbname))
let $valid := <report>
  <status>valid</status>
</report>
return if ($result=$valid) then format-date(current-date(), "[Y0001]-[M01]-[D01]") || " The db " || $dbname || " validates successfully."
else  format-date(current-date(), "[Y0001]-[M01]-[D01]") || " The db " || $dbname || " did not validate. Please inspect!"