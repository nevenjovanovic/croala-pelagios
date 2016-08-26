(: create first list of CITE objects :)
(: create a list from qualified place references :)
declare namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';

(: pretty printing of text :)
declare function cp:prettyp2($settext) {
    element td {
  replace(replace($settext, ' ([,).:;?!])', '$1'), '([(]) ', '$1')
}
};

(: from a CTS URN retrieve text in s parent element :)
declare function cp:openurn2 ($nodeid) {
let $text := db:open-id("tubero-commentarii", $nodeid)/parent::*:s
let $settext := normalize-space(data($text))
return cp:prettyp2($settext)
};

let $citelist :=
element csv {
for $i in collection("tub-com-placename-idx")//*:w[@ana='estlocus1']
let $sq := data($i/@xml:id)
let $cts := data($i/@n)
let $label := $i/text()
let $citerecord := "urn:cite:croala:loci." || $sq
let $citebodyrecord := "urn:cite:croala:loci.ana." || $sq
let $isplace := data($i/@ana)
let $txt := cp:openurn2($sq)
order by xs:integer($sq)
return element tr {
  element td { $sq },
  element td { $label },
  element td { $isplace },
  $txt,
  element td { $cts },
  element td { $citerecord },
  element td { $citebodyrecord }
}
}
return csv:serialize($citelist)