(: return a list of placeName CTS URNs :)
declare function local:prettyp($ctsadr, $word) {
  element tr {
    element td { 
    element a { 
    attribute href { "http://croala.ffzg.unizg.hr/basex/cts/" || $ctsadr } , 
    $ctsadr } },
    element td { $word }
}
};
for $address in db:open("tub-com-placename-idx")//*:w
let $ctsadr := data($address/@n)
let $word := $address/text()
order by $word
return local:prettyp($ctsadr, $word)