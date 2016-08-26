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
return local:lnk(data($b/@*:resource))
order by xs:integer($r/*:item/text())
return element tr {
  element td { local:lnk(data($locus))}, 
  element td { local:lnk(data($annoex))}, 
  element td { $annobod }
}
}
let $tbody2 := element tbody {
for $citebod in distinct-values($t//td[3]/a)
for $row in $t/tr
where $row/td[3]/a[contains(text(),$citebod)]
return element tr { element td { $citebod } , $row/td[1] }
}
let $tbody3 := element tbody { for $t in $tbody2//tr
let $ana2 := $t/td[1]
group by $ana2
return element tr { element td {$ana2} , element td { data($t/td[2]/a) } }
}
return csv:serialize($tbody3)