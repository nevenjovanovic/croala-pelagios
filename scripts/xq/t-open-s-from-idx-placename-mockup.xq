(: from a given address of placeName :)
(: open sentence in the CTS edition :)
declare function local:prettyp($settext, $ctsadr, $word) {
  element tr {
    element td { $ctsadr },
    element td { $word },
    element td {
  replace(replace($settext, ' ([,).;])', '$1'), '([(]) ', '$1')
}
}
};
for $address in ("http://croala.ffzg.unizg.hr/cts/urn:cts:croala:tubero.commentarii.croala-loci:body1.1.div1.p1.s1.placeName28","http://croala.ffzg.unizg.hr/cts/urn:cts:croala:modruski-n.oratio-riario.croala-loci:body1.div1.p3.s10.placeName8")
let $ctsadr := substring-after($address, '/cts/')
let $w := db:open("tub-com-placename-idx")//*:w[@n=$ctsadr]
let $word := $w/text()
let $pre := data($w/@xml:id)
let $text := data(db:open-pre("tubero-commentarii", $pre)/parent::*:s)
let $settext := normalize-space($text)
return local:prettyp($settext, $ctsadr, $word)