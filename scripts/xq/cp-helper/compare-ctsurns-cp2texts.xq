(: compare strings in cp-cts-urns and cp-2-texts :)
for $query in db:open("cp-cts-urns")//w
let $node := $query/@xml:id
let $w1 := data($query)
let $w2 := data(db:open-id("cp-2-texts", $node))
return if ($w1 = $w2) then () else ($w1, $w2)