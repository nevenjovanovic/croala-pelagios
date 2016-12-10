let $dbvalidation := map {
  'cp-latlexents' :  'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cplatlexents.rng',
  'cp-latmorph' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cplatmorph.rng',
  'cp-loci' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng',
  'cp-aetates' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpperiods.rng',
  'cp-cite-lemmata' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpcitelemmata.rng',
  'cp-cite-urns' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpciteurns.rng',
  'cp-cts-urns' :  'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpctsurns.rng',
  'cp-cite-morphs':  'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpcitemorphs.rng',
  'cp-cite-loci' : 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpciteloci-record.rng',
  'cp-cite-aetates' :  'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpciteaetatis-record.rng'
}
for $dbname in map:keys($dbvalidation)
for $doc in db:open($dbname)
let $result := validate:rng-report($doc, map:get($dbvalidation, $dbname))
let $valid := <report>
  <status>valid</status>
</report>
return if ($result=$valid) then format-date(current-date(), "[Y0001]-[M01]-[D01]") ||  " Document " || db:path($doc) || " in the db " || $dbname || " validates successfully."
else  format-date(current-date(), "[Y0001]-[M01]-[D01]") || " Document " || db:path($doc) || " in the db " || $dbname || " did not validate. Please inspect!"