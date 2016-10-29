(: XQuery module for CroALa-Pelagios :)
module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';
(: pretty printing of text :)
declare function cp:prettyp($settext, $ctsadr, $word) {
  element tr {
    element td { element b { $ctsadr } },
    element td { $word },
    element td {
  replace(replace($settext, ' ([,).:;?!])', '$1'), '([(]) ', '$1')
}
}
};
(: pretty printing of CTS URN list :)
declare function cp:prettycts($ctsadr, $word) {
  element tr {
    element td { 
    element a { 
    attribute href { "http://croala.ffzg.unizg.hr/basex/cts/" || $ctsadr } , 
    $ctsadr } },
    element td { $word }
}
};

declare function cp:prettylink($link, $word, $prefix) {
    element td { 
    element a { 
    attribute href { $prefix || $link } , 
    $word } }
};

(: list all CTS URNs :)
declare function cp:listurn () {
  for $address in db:open("cp-placename-idx")//*:w
let $ctsadr := data($address/@n)
let $word := $address/text()
order by $word
return cp:prettycts($ctsadr, $word)
};

(: from a CTS URN retrieve text in s parent element :)
declare function cp:openurn ($ctsadr) {
let $w := db:open("cp-cts-urns")//*:w[@n=$ctsadr]
return if ($w) then
let $word := $w/text()
let $pre := xs:integer($w/@xml:id)
let $text := data(db:open-id("cp-2-texts", $pre)/parent::*)
let $settext := normalize-space($text)
return cp:prettyp($settext, $ctsadr, $word)
else element tr {
  element td { "Nodus videtur deesse in indice nostro." }
}
};

(: make node quickly :)
declare function cp:td($node) {
  element td {
    data($node)
  }
};
(: pretty printing of a URN list :)
(: send to /$domain/$urn, where the CITE body or CTS is displayed :)
declare function cp:prettycitebody($citeurn , $cts, $domain) {
  element td {
    element a { 
    attribute href { "http://croala.ffzg.unizg.hr/basex/" || $domain || $cts } , 
    data($citeurn) }
  }
};
(: list CITE URNs linking to their bodies, and their CTS equivalents :)
declare function cp:citelist(){
let $citedb := collection("cp-cts-cite-idx")
let $citelistbody := element tbody { for $r in $citedb//record
let $ctsurn := cp:prettycitebody($r/entry[4], "ctsp/", $r/entry[4])
let $citeurn := cp:prettycitebody($r/entry[5], "cite/", $r/entry[5])
let $label := cp:td($r/entry[2])
let $citeanaex := element td { "CITE Analytical exemplar" }
return element tr {
  $label , $citeurn , $ctsurn
}
}
return $citelistbody
};

(: open a CITE URN, display CITE body "content" :)
declare function cp:openciteurn($citeurn){
  (: for a given CITE URN, display record :)
(: to be made into cp:openciteurn function :)
(: relies on the cp-citebody db :)
let $idx := collection("cp-citebody")
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
};

declare function cp:listcitebodies(){
  (: for a given CITE URN, display record :)
(: to be made into cp:openciteurn function :)
(: relies on the cp-citebody db :)
let $citeurn := element div {
  attribute class {"table-responsive"},
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    element thead {
      element tr {
        element td { "CITE Body URN"},
        element td { "Place Reference"},
        element td { "Place Referred To"},
        element td {"Period Referred To"},
        element td { "Note Created By"},
        element td { "File Last Modified On"}
      }
    },
    element tbody {
let $idx := collection("cp-citebody")
for $r in $idx//r
let $citebodyurn := $r/note/entry
let $placeref := for $e in $r/place/entry return element a { attribute href {$e}, for $txt in tokenize($e, '/')[last()] return $txt }
let $placereflabel := data($r/label/entry)
let $periodref := for $p in $r/period/entry return element a { attribute href {$p} , $r/periodlabel/entry }
let $creator := $r/creator/entry
order by $placereflabel
return 
    element tr { 
  element td { data($citebodyurn)},
  element td { $placeref },
  element td { $placereflabel } ,
  element td { $periodref },
  element td { element a { attribute href {$creator}, replace($creator, 'http://' , '')} },
  element td { file:last-modified("/home/croala/croala-pelagios/csv/modrtub-idx-citebodies.xml") }
}
}}
}
return $citeurn
};

declare function cp:listciteplaces(){
  (: display all available CITE URNs for places :)
(: relies on the cp-loci db :)
let $citeurn := element div {
  attribute class {"table-responsive"},
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    element thead {
      element tr {
        element td { "CITE Body URN"},
        element td { "Place Reference"},
        element td { "Place Referred To"},
        element td { "Note Created By"},
        element td { "Note Last Modified On"}
      }
    },
    element tbody {
let $idx := collection("cp-loci")
for $r in $idx//w
let $citebodyurn := data($r/citebody)
let $placeref := data($r/uri)
let $placereflabel := data($r/label)
let $creator := data($r/creator)
order by $placereflabel
return 
    element tr { 
  element td { $citebodyurn },
  element td { $placereflabel } ,
  element td { $placeref },
  element td { element a { attribute href {$creator}, replace($creator, 'http://' , '')} },
  element td { db:info("cp-loci")//databaseproperties/timestamp/string() }
}
}}
}
return $citeurn
};

declare function cp:listciteperiods(){
  (: display all available CITE URNs for periods :)
(: relies on the cp-aetates db :)
let $citeurn := element div {
  attribute class {"table-responsive"},
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    element thead {
      element tr {
        element td { "CITE Body URN"},
        element td { "Period Reference"},
        element td { "Period Referred To"},
        element td { "Note Created By"},
        element td { "Note Last Modified On"}
      }
    },
    element tbody {
let $idx := collection("cp-aetates")
for $r in $idx//w
let $citebodyurn := data($r/citebody)
let $placeref := data($r/uri)
let $placereflabel := data($r/label)
let $creator := data($r/creator)
order by $placereflabel
return 
    element tr { 
  element td { $citebodyurn },
  element td { $placereflabel } ,
  element td { $placeref },
  element td { element a { attribute href {$creator}, replace($creator, 'http://' , '')} },
  element td { db:info("cp-aetates")//databaseproperties/timestamp/string() }
}
}}
}
return $citeurn
};