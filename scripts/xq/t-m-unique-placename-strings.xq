(: return unique placename strings from the index :)
for $loci in
let $e := collection("tub-com-placename-idx")//*:w
return distinct-values($e)
order by $loci
return $loci