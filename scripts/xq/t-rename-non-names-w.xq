(: from a list, rename non-place name nodes :)
(: in tubero-commentarii :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
for $nonnames in ("Alia", "Vrbes", "Inter")
for $n in db:open("tubero-commentarii")//*:placeName[contains(text(),$nonnames)]
return rename node $n as 'w'