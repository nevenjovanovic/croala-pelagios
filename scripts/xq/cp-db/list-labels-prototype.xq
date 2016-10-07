(: display a list of available labels with CTS URNs where they occur :)
(: as a HTML table :)
(: to be converted to a function in a module :)
declare namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';
(: pretty printing of CTS URN list :)
declare function cp:prettycts($ctsadr) {
    element a { 
    attribute href { "http://croala.ffzg.unizg.hr/basex/cts/" || $ctsadr } , 
    $ctsadr }

};

let $table := element tbody {
for $cts in collection("cp-cts-urns")//w
let $urn := data($cts/@n)
let $label := $cts/text()
group by $label
order by $label
return element tr {
  element td { $label },
  element td { for $ u in $urn return cp:prettycts($u)  }
}
}
return $table