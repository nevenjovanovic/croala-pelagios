let $set := element t { for $r in db:open("tub-com-placename-idx")//*:w
return $r }
let $countelem := count($set//*:w)
let $countnuniq := count(distinct-values($set//*:w/@n))
return if ($countelem = $countnuniq) then "OK: both " || $countelem
else element c { $countelem , $countnuniq }