(: compare strings in cp-cts-urns and cp-2-texts :)
for $query in db:open("cp-cite-urns")//w
let $node := replace($query/@xml:id, "ana", "")
let $w1 := data($query/form)
let $w2 := data(db:open-id("cp-2-texts", xs:int($node)))
return if ($w1 = $w2) then "OK" else ($w1, $w2)