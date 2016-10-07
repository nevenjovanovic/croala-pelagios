(: list p and p-equivalent (head etc) elements :)
declare namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';

(: pretty printing of text :)
declare function cp:prettyp2($settext) {
    element td {
  replace(replace($settext, ' ([,).:;?])', '$1'), '([(]) ', '$1')
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
return 
 element r { 
 element s { $sq } , 
 element c { $cts }
}
}
return csv:serialize($citelist)