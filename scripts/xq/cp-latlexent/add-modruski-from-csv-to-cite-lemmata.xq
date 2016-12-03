import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
let $result :=
let $file := file:read-text("/home/neven/rad/croalapelagiosxml/oznaceno/modruski-loci-morphologia.csv")
let $csv := csv:parse($file, map { 'header': true() })
for $r in $csv//record
let $lemma := $r/LEMMA/string()
let $lemmaciteurn := $r/LEMMA_CITE_URN/string()
let $cts := $r/CTS_URN/string()
let $word := $r/Nomen/string()
let $citeid := "ana" || $r/SEQUENCE/string()
let $citeurn := "urn:cite:croala:loci." || $citeid
let $creator := "http://orcid.org/0000-0001-5515-6545"
let $datecreated := cp:makeelement(format-date(current-date(), "[Y0001]-[M01]-[D01]"), "datecreated")
return element record {
  attribute citeid { $citeid },
  element seg {
    attribute citeurn { $citeurn },
    attribute cts { $cts },
    $word
  },
  element lemma {
    attribute citeurn {
      $lemmaciteurn
    },
    $lemma
  },
  element creator { $creator },
  $datecreated
}

return insert node $result as last into db:open("cp-cite-lemmata")//list