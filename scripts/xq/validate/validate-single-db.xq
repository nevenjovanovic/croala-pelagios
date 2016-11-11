let $dbvalidation := map {
  'cp-cite-morphs':  'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpcitemorphs.rng',
  'cp-latlexents' :  'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cplatlexents.rng'}
for $dbname in map:keys($dbvalidation)
for $doc in db:open($dbname)
let $result := validate:rng-report($doc, map:get($dbvalidation, $dbname))
return $result