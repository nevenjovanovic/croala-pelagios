let $csv := element csv {
for $pn in db:open("cpoe", "marul-mar-carmina-w-n.xml")//*:text//*:placeName
let $string := $pn/string()
let $urn := "urn:cts:croala:marulic-m.carmina.croala-lat.loci:" || $pn/@n
let $ana := $pn/@ana
let $node := db:node-id($pn)
let $context := db:open-id("cpoe",$node)/..
order by $pn
return element record {
  element f { $string },
  element f { data($ana)},
  element f { data($context)},
  element f { data($urn)}
}
}
return file:write("/home/neven/rad/croalapelagiosxml/maruluscarmina.csv", csv:serialize($csv))