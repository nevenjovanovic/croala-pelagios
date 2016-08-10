(: from a given address :)
(: open sentence in the CTS edition :)
let $address := "http://croala.ffzg.unizg.hr/cts/urn:cts:croala:tubero.commentarii.croala-verba:body1.2.div6.p1.s6.w2"
let $ctsadr := substring-after($address, '/cts/')
for $w in db:open("tub-com-idx")//*:w[@n=$ctsadr]
let $pre := data($w/@xml:id)
let $text := data(db:open-pre("tubero-commentarii", $pre)/parent::*:s)
let $settext := normalize-space($text)
return replace(replace($settext, ' ([,).])', '$1'), '([(]) ', '$1')