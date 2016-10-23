(: produce new csv for linguistic annotation :)
let $el := ("estlocus1", "estlocus2", "estlocus3", "estlocus4")
let $csv := element csv {
for $w in collection("cp-cts-urns")//*:w[@ana=$el]
let $node := $w/@xml:id
let $urn := $w/@n
let $source := db:open-id("cp-2-texts",$node)
let $context := normalize-space(data($source/..))
order by $urn , $node
return element record {
  element entry { $w/@ana/string() },
  element entry { $w/text() } ,
  element entry { $context },
  element entry { "LEMMA"},
  element entry { "LEMMA CITE URN"},
  element entry { "MORPH CITE URN"},
  element entry { "ANNOTATOR"},
  element entry { $urn/string()},
  element entry { $w/@xml:id/string()}
}
}
return csv:serialize($csv)