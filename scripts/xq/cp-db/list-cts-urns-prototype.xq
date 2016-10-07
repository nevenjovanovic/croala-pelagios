(: display a list of available CTS URNs with places :)
(: as a HTML table :)
(: to be converted to a function in a module :)
let $table := element tbody {
for $cts in collection("cp-cts-urns")//w
let $urn := data($cts/@n)
let $label := $cts/text()
let $ana := data($cts/@ana)
let $context := collection("cp-cts-contexts")//cite[@n=$urn]
(: put a mark tag around the label for orientation :)
let $markcontext := ft:mark($context[text() contains text {$label}])
return element tr {
  element td { $urn  },
  element td { $label },
  element td { $ana },
  element td { $markcontext }
}
}
return $table