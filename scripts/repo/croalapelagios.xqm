(: XQuery module for CroALa-Pelagios :)
module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';

declare variable $cp:ann := map {
  "ZS" : "http://orcid.org/0000-0003-1457-7081",
  "NJ" : "http://orcid.org/0000-0002-9119-399X",
  "AS" : "http://orcid.org/0000-0001-5515-6545",
  "NČ" : "http://orcid.org/0000-0002-0438-6049",
  "NJ/NČ" : "http://orcid.org/0000-0002-0438-6049",
  "AS/NČ" : "http://orcid.org/0000-0002-0438-6049",
  "CROALA/NČ" : "http://orcid.org/0000-0002-0438-6049",
  "AŽ" : "http://orcid.org/0000-0002-2135-6343"
};

declare function cp:makeelement($e, $name){
  element {$name} { data($e) }
};

declare function cp:annotator ($parsed) { 
  cp:makeelement(
  map:get($cp:ann, upper-case($parsed/ANNOTATOR_INITIALS)), "creator"
)
};

declare function cp:input-field2($id, $r){
  element input { 
      attribute size { "15"},
      attribute id { $id },
      attribute value { $r } } , 
    element button { 
      attribute class { "btn" } ,
      attribute aria-label { "Recordare!"},
      attribute data-clipboard-target { "#" || $id },
      element span { 
        attribute class { "glyphicon glyphicon-copy"},
        attribute aria-hidden {"true"},
        attribute aria-label { "Recordare!" }
      }
    }
};

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

declare function cp:listciteplaces($lemma){
  (: display all available CITE URNs for places :)
(: relies on the cp-loci db :)
let $citeurn := element div {
  attribute class {"table-responsive"},
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    element thead {
      element tr {
        element td { "CITE Body URN"},
        element td { "CITE ID Part"},
        element td { "Latin Lemma"},
        element td { "Place Referred To"},
        element td { "URI"}
      }
    },
    element tbody {
     
let $idx := collection("cp-loci")//record[matches(nomen/text(), $lemma)]
return if ($idx) then
for $r in $idx
let $lemma := element td { data($r/nomen) }
let $citeid := replace($r/@citeid/string(), "locid", "")
let $citevalue := element td { $r/citebody/@citeurn/string() }
let $id := generate-id($r)
let $citebodyurn := element td { cp:input-field2($id, $citeid) }
let $placeref := element td { 
element a {
  attribute href { data($r/uri) } , replace(data($r/uri), "http://", "") } }
let $placereflabel := element td { data($r/label) }
order by $lemma
return 
    element tr { 
    $citevalue ,
    $citebodyurn ,
    $lemma ,
    $placereflabel ,
    $placeref
}

else element tr { 
element td { "Lemma deest in collectionibus nostris." }
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
        element th { "CITE URN"},
        element th { "Period Reference"},
        element th { "Period Referred To"}
      }
    },
    element tbody {
let $idx := collection("cp-aetates")
for $r in $idx//record
let $citebodyurn := data($r/@xml:id)
let $id := generate-id($r)
let $citebodyurn2 := element td { cp:input-field2($id, $citebodyurn) }
let $placeref := data($r/uri)
let $placereflabel := data($r/label)
order by $placereflabel
return 
    element tr { 
   $citebodyurn2 ,
  element td { $placereflabel } ,
  element td { element a { attribute href {$placeref}, replace($placeref, 'http://' , '')} }
}
}}
}
return $citeurn
};

declare function cp:estlocus_grand_tot($set) {
  let $all_estlocus := $set//*:w[matches(@ana,"^estlocus")]
  return element tr { 
  element th { "ALL VALUES"},
  element th { count($all_estlocus) }
}
};

declare function cp:estlocus_tot($set, $urn) {
  element table {
    attribute class {"table"},
    element thead {
      element tr {
        element th { "ESTLOCUS"},
        element th { "TOTAL IN CORPUS"}
      },
      cp:estlocus_grand_tot($set)
    },
    element tbody {
      for $count in $set//*:w[matches(@ana,"^estlocus")]
      let $estlocus := $count/@ana
      group by $estlocus
      order by $estlocus
      return element tr {
        element td { replace($estlocus, "estlocus", "est locus ") },
        cp:prettylink($estlocus, count($count), "http://croala.ffzg.unizg.hr/basex/cp-loci/" || $urn || "/")
      }
    }
  }
};

declare function cp:estlocus_xml_totals(){
  for $doc in db:open("cp-2-texts")//*:TEI[descendant::*:w[matches(@ana,"estlocus")]]
  let $urn := $doc//*:text/@xml:base/string()
  let $path := db:path($doc)
  return element div {
    attribute class {"table-responsive"},
  element h1 { $urn } , 
  cp:estlocus_tot(db:open("cp-2-texts", $path), $urn)
}
};