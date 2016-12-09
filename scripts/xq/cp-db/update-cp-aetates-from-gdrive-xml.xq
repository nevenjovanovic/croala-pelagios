let $result := element list {
(: from the reformatted XML from G drive, update cp-aetates db :)
let $doc := doc("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/aetates-id-novae-2.xml")
for $r in $doc//record
let $r2 := collection("cp-aetates")//record
return if ($r = $r2) then () else $r
}
return insert node $result into db:open("cp-aetates")