(: Takes 191099 ms time! :)
import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at "../../repo/croalapelagios.xqm";
import module namespace functx = "http://www.functx.com" at "../../repo/functx.xqm";

(: create CITE URNs from @xml:id :)
let $citeindex := element list {
for $cite in collection("cp-cts-urns")//*:w[matches(@ana, "^estlocus")]
let $cts := $cite/@n
let $cts_context := cp:openurn($cts)
let $estlocus := $cite/@ana[matches(., "^estlocus")]
let $cite_id := attribute xml:id { "ana" || $cite/@xml:id }
let $citeana := "urn:cite:croala:loci.ana" || $cite/@xml:id
let $citeestlocus := "urn:cite:croala:loci.estlocus" || $cite/@xml:id
let $citeaex_a := functx:substring-before-last($cts, ":")
let $citeaex_b := functx:substring-after-last($cts, ":")
let $citeaex := $citeaex_a || "-toponym:" || $citeaex_b
let $creator := $cite/@creator
return element w {
  $cite_id ,
  attribute citeurn { $citeana },
  attribute locusurn { $citeestlocus },
  $cts,
  $estlocus ,
  attribute citeaex { $citeaex },
  $creator ,
  element form { data($cts_context//td[2]) } ,
  element context { data($cts_context//td[3]) }
}
}
(: return db:create("cp-cite-urns", $citeindex, "cp-citeurns.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() }) :)
return $citeindex