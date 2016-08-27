(: for a given CITE URN, display record :)
(: to be made into cp:openciteurn function :)
(: relies on the cp-citebody db :)
let $citeurn := "urn:cite:croala:loci.ana.89403"
let $idx := collection("cp-citebody")
for $r in $idx//r[anno/entry[.=$citeurn]]
let $citebodyurn := $r/note
let $placeref := element a { attribute href {$r/place}, data($r/label) }
let $periodref := $r/period/a
let $creator := "http://orcid.org/0000-0002-9119-399X"
return element div {
  attribute class {"table-responsive"},
  element head { "Note for " , element b { $citeurn } },
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    element thead {
      element tr {
        element td { "CITE Body URN"},
        element td { "Place Reference"},
        element td {"Period Referred To"},
        element td { "Note Created By"},
        element td { "Created On"}
      }
    },
    element tbody {
    element tr { 
  element td { data($citebodyurn)},
  element td { $placeref },
  element td { $periodref },
  element td { element a { attribute href {$creator}, replace($creator, 'http://' , '')} },
  element td { "02/07/2016" }
}
}}
}