(: create first list of CITE objects :)
declare namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';

(: pretty printing of text :)
declare function cp:prettyp2($settext) {
    element td {
  replace(replace($settext, ' ([,).;])', '$1'), '([(]) ', '$1')
}
};

(: from a CTS URN retrieve text in s parent element :)
declare function cp:openurn2 ($nodeid) {
let $text := data(db:open-id("tubero-commentarii", $nodeid)/parent::*:s)
let $settext := normalize-space($text)
return cp:prettyp2($settext)
};

let $citelist :=
element csv {
for $i in collection("tub-com-placename-idx")//*:w
let $sq := data($i/@xml:id)
let $cts := data($i/@n)
let $label := $i/text()
let $citerecord := "urn:cite:croala:loci." || $sq
let $isplace := "=TRUE()"
let $txt := cp:openurn2($sq)
order by xs:integer($sq)
return element tr {
  element td { $sq },
  element td { $label },
  element td { $isplace },
  $txt,
  element td { $cts },
  element td { $citerecord }
}
}
return csv:serialize($citelist)