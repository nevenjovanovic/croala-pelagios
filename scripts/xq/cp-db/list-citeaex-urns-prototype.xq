(: display a list of available CITE AEx URNs with composite labels :)
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
for $cts in collection("cp-cite-urns")//w
let $urn := data($cts/@citeaex)
let $label := $cts/text()
return element tr {
  element td { $label },
  element td { $urn  },
  element td { "composite label" }
}
}
return $table