(: cp-create-cts-index-estlocus1.xq :)
(: use a prepared CSV file :)
(: create a db indexing cite URNs and their CTS URNs :)
let $csv := file:read-text("/home/croala/croala-pelagios/csv/cp-cite-cts-estlocus1-0825.csv")
let $cdb := csv:parse($csv)
let $citedbxml := element cite {
for $c in $cdb//record
let $sequence := $c/entry[1]
let $label := $c/entry[2]
let $context := $c/entry[4]
let $ctsurn := $c/entry[5]
let $citeana := $c/entry[7]
order by xs:integer($sequence)
return element record {
  $sequence , $label , $context , $ctsurn , $citeana
}
}
return db:create("cp-cts-cite-idx", $citedbxml, "cp-cts-cite-list.xml", map { 'ftindex': true(), 'chop': false(), 'intparse' : true() }) 