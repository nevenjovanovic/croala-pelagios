(: for a given CITE URN, display record :)
(: to be made into cp:openciteurn function :)
(: relies on the cp-citebody db :)
let $citeurn := "urn:cite:croala:loci.ana.14879"
(: let $idx := collection("cp-citebody") :)
let $idx := doc("/home/neven/rad/croala-pelagios/csv/modrtub-idx-citebodies.xml")
for $r in $idx//r[anno/entry[.=$citeurn]]
let $citebodyurn := $r/note/entry
let $placeref := for $e in $r/place/entry return element a { attribute href {$e}, for $txt in tokenize($e, '/')[last()] return $txt }
let $placereflabel := data($r/label/entry)
let $periodref := for $p in $r/period/entry return element a { attribute href {$p} , $r/periodlabel/entry }
let $creator := $r/creator/entry
return element div {
  attribute class {"table-responsive"},
  element head { "Note for " , element b { $citeurn } },
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    element thead {
      element tr {
        element td { "CITE Body URN"},
        element td { "Place Reference"},
        element td { "Place Referred To"},
        element td {"Period Referred To"},
        element td { "Note Created By"},
        element td { "Created On"}
      }
    },
    element tbody {
    element tr { 
  element td { data($citebodyurn)},
  element td { $placeref },
  element td { $placereflabel } ,
  element td { $periodref },
  element td { element a { attribute href {$creator}, replace($creator, 'http://' , '')} },
  element td { "02/07/2016" }
}
}}
}