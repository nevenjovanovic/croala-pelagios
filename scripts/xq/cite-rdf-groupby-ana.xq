declare function local:lnk($link){
  let $linktext := replace($link, "http://croala.ffzg.unizg.hr/basex/cts/", "")
  return element a {
    attribute href {$link},
    $linktext
  }
};
let $t := element tbody {
for $r in collection("croala-cite-loc-rdf")//*:Description
let $locus := $r/@*:about
let $text := $r/*:label
let $annorec := $r/*:hasTarget[1]/@*:resource
let $annoex := $r/*:hasTarget[2]/@*:resource
let $annobod := for $b in $r/*:hasBody
return local:lnk(replace(data($b/@*:resource), 'loci.ana', 'loci.ana-nota'))
order by xs:integer($r/*:item/text())
return element tr {
  element td { local:lnk(data($locus))}, 
  element td { $annobod }
}
}
return $t