(: create a db with contexts of CTS URNs :)
declare namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';
(: pretty printing of text :)
declare function cp:prettyp($settext) {
  replace(replace($settext, ' ([,).:;?!])', '$1'), '([(]) ', '$1')
};

(: from a CTS URN retrieve text in s parent element :)
declare function cp:openurn ($ctsadr) {
let $w := db:open("cp-cts-urns")//*:w[@n=$ctsadr]
let $word := $w/text()
let $pre := data($w/@xml:id)
let $text := data(db:open-id("cp", $pre)/parent::*:s)
(: let $text := data(db:open-id("tubero-commentarii", $pre)/parent::*:s) :)
let $settext := normalize-space($text)
return cp:prettyp($settext)
};
(: create context for CTS URN :)
let $ctscontext := element list {
for $cite in collection("cp-cts-urns")//*:w
let $cts := $cite/@n
let $label := $cite/text()
let $context := cp:openurn($cts)
return element cite {
  $cts,
  attribute label { $label },
  $context
}
}
return db:create("cp-cts-contexts", $ctscontext, "cp-cts-contexts.xml", map {'chop': false(), 'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })