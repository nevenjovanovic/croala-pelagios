(: XQuery module for CroALa-Pelagios :)
module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';
import module namespace functx = "http://www.functx.com" at "functx.xqm";

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

(: helper function - message  :)
declare function cp:deest(){
  element tr {
    element td { "URN deest in collectionibus nostris." }
  }
};

(: helper function for header, with meta :)
declare function cp:htmlheadserver($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, CroALa / Pelagios" />
<link rel="icon" href="/basex/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/cp.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/font-awesome-4.7.0/css/font-awesome.min.css"/>
</head>

};

(: helper function - footer :)
declare function cp:footerserver () {
let $f := <footer class="footer">
<div class="container">
<h3> </h3>
<h1 class="text-center"><span class="glyphicon glyphicon-leaf" aria-hidden="true"></span> <a href="http://croala.ffzg.unizg.hr">CroALa et</a> Pelagios</h1>
<div class="row"> 
<div  class="col-md-6">
<h3 class="text-center"><a href="http://www.ffzg.unizg.hr"><img src="/basex/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</h3> 
<p class="text-center"><i class="fa fa-github fa-lg"></i>
            <span class="network-name">Github</span>: <a href="https://github.com/nevenjovanovic/croala-pelagios">croala-pelagios</a></p>
</div>

<div  class="col-md-6">
<p class="text-center"> <a href="http://commons.pelagios.org/"><img src="/basex/static/gfx/pelagiosini.png"/></a></p></div></div>
</div>
</footer>
return $f
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
(: pretty printing of CTS URN list with link :)
declare function cp:prettycts($ctsadr, $word) {
  element tr {
    element td { 
    element a { 
    attribute href { "http://croala.ffzg.unizg.hr/basex/ctsp/" || $ctsadr } , 
    $ctsadr } },
    element td { $word }
}
};

declare function cp:simple_link($link, $word){
  element a {
    attribute href { $link },
    $word
  }
};

declare function cp:prettylink($link, $word, $prefix) {
    element td { 
    element a { 
    attribute href { $prefix || $link } , 
    $word } }
};

(: helper function - list of all documents with place annotations :)

declare function cp:list_corpus($cts_set){
  let $doc_urns := distinct-values(
  for $cts in $cts_set
  let $base := functx:substring-before-last($cts, ":")
  return $base )
  return ("corpus" , $doc_urns )
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

(: open a CITE URN for a place, display CITE body "content" :)
declare function cp:openciteurn_locid($citeurn){
  (: for a given CITE URN, display record :)
let $idx := collection("cp-loci")
for $r in $idx//record[citebody[@citeurn=$citeurn]]
let $nomen := $r/nomen
let $label := $r/label
let $uri := $r/uri
let $creator := $r/creator
let $datecreated := $r/datecreated
return element div {
  attribute class {"table-responsive"},
  element head { "Note for " , element b { $citeurn } },
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    element thead {
      element tr {
        element td { "CITE Body URN"},
        element td { "Latin Place Name"},
        element td { "Standard Place Name"},
        element td { "Note Created By"},
        element td { "Created On"}
      }
    },
    element tbody {
    element tr { 
  cp:prettylink("", $citeurn, $uri),
  element td { data($nomen) },
  element td { data($label) } ,
  element td { element a { attribute href {$creator}, replace($creator, 'http://' , '')} },
  element td { data($datecreated) }
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
  let $all_estlocus := $set//*[matches(@ana,"^estlocus")]
  return element tr { 
  attribute class { "success"},
  element td { "ALL VALUES"},
  element td { count($all_estlocus) }
}
};

declare function cp:estlocus_tot($set, $urn) {
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    attribute id { "estlocus" },
    element caption {
      element b { "Codes" } , ": 0 = not a place; 1 = definitely a place; 2 = part of a multi-word expression denoting place; 3 = rhetorical (figurative) reference; 4 = a complex case; X = requires further work."
    },
    element thead {
      element tr {
        element th { "ESTLOCUS"},
        element th { "TOTAL IN CORPUS"}
      }
      
    },
    element tbody {
      cp:estlocus_grand_tot($set),
      for $count in $set//*[matches(@ana,"^estlocus")]
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

declare function cp:estlocus_index($cts_urn, $value){
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    attribute id { $value },
    element caption { $cts_urn } ,
  element thead {
    element tr {
      element th { "CTS URN"},
      element th { "Word"}
    }
  },
  element tbody {
    let $set := if ($cts_urn="corpus") then db:open("cp-cts-urns")//*:w[@ana=$value]
    else if (starts-with($cts_urn, "urn:cts:croala")) then db:open("cp-cts-urns")//*:w[starts-with(@n, $cts_urn) and @ana=$value]
    else element b { "URN deest in collectionibus nostris." }
  for $w in $set
  let $word := if ($w/string()) then $w/string() else ()
  let $cts_urn_seg := if ($w/@n) then $w/@n/string() else ()
  return if ($cts_urn_seg) then
  cp:prettycts($cts_urn_seg, $word)
  else element tr {
    element td { $word }
  }
}
}
};

declare function cp:group_lemmata($set){
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    attribute id { "lemmata" },
    element caption { $set } ,
  element thead {
    element tr {
      element th { "Lemma"},
      element th { "Occurrences"}
    }
  },
  element tbody {
    let $result_set := if ($set="corpus") then db:open("cp-cite-lemmata")//*:record
    else if (starts-with($set, "urn:cts:croala")) then db:open("cp-cite-lemmata")//*:record[starts-with(seg/@cts, $set)]
    else element b { "CITE URN deest in collectionibus nostris." }
  return if ($result_set/lemma) then
  for $r in $result_set  
  let $lemma := $r/lemma
  let $lemma_cite := $r/lemma/@citeurn/string()
  group by $lemma
  order by $lemma
  return element tr {
    cp:prettylink(distinct-values($lemma_cite), $lemma, "http://croala.ffzg.unizg.hr/basex/cite/"),
    cp:prettylink($set || "/" || distinct-values($lemma_cite), count($r), "http://croala.ffzg.unizg.hr/basex/cpciteindex/")}
  else element tr{
    element td { $result_set }
  }
}
}
};

(: return counts of lemmata and lemmatized words :)

declare function cp:count_lemma_all($cts){
  let $set := if ($cts="corpus") then db:open("cp-cite-lemmata")//record[lemma] else if (starts-with($cts, "urn:cts:croala:")) then db:open("cp-cite-lemmata")//record[lemma and starts-with(seg/@cts, $cts)] else element b { "CTS URN abest in collectionibus nostris" }
let $r := $set
let $lemmatized_count := count($r)
let $lemma_count := count(distinct-values($r/lemma/@citeurn))
return element tr {
  cp:prettylink($cts, $cts, "http://croala.ffzg.unizg.hr/basex/cp-cite-lemmata/" ),
  element td { if ($lemma_count=0) then $r else $lemma_count },
  element td { if ($lemma_count=0) then "" else $lemmatized_count },
  element td { if ($lemma_count=0) then "" else format-number($lemmatized_count div $lemma_count, ".00") }
}
};

(: display counts of lemmata for corpus and all docs :)

declare function cp:count-lemmata(){
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    attribute id { "lemmata" },
    element caption { "Counts of lemmata in the whole corpus and in individual documents." } ,
  element thead {
    element th { "Document"},
    element th { "Lemmata"},
    element th { "Lemmatized words"},
    element th { "Average frequency of lemmata"}
  },
  element tbody {
  
for $d in cp:list_corpus(db:open("cp-cite-lemmata")//record/seg/@cts)
return cp:count_lemma_all($d)
}
}
};

declare function cp:index_lemmata($cts, $cite_urn){
  element h3 { $cts || ": " || db:open("cp-latlexents")//record/lemma[@citeurn=$cite_urn]/string() },
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    attribute id { "list_occurrences" },
    element caption { $cite_urn || ": " || db:open("cp-latlexents")//record/lemma[@citeurn=$cite_urn]/string() } ,
  element thead {
    element tr {
      element th { "Occurrence" },
      element th { "CTS URN"}
    }
  },
  element tbody {
  for $r in db:open("cp-cite-lemmata")//record[starts-with(seg/@cts,$cts) and lemma/@citeurn=$cite_urn]
  return element tr {
    element td { $r/seg/string()},
    cp:prettylink( $r/seg/@cts/string(), $r/seg/@cts/string(), "http://croala.ffzg.unizg.hr/basex/ctsp/" )
  }
}
}
};

(: return count of places identified in corpus and in each document :)
declare function cp:count_places($corpus) {
  let $count_places := if ($corpus="corpus") then db:open("cp-cite-loci")//record/citelocus 
  else if (starts-with($corpus, "urn:cts:croala")) then db:open("cp-cite-loci")//record[starts-with(ctsurn, $corpus)]/citelocus 
  else element b { "CTS URN abest in collectionibus nostris."}
  let $total := count($count_places)
  let $distinct := count(distinct-values($count_places))
  return if ($total <= 1) then 
  element table {
  element tbody {
    element tr { 
    element td { $count_places }
  }
} }
 else 
 element table {
    attribute class {"table-striped  table-hover table-centered"},
  element thead {
    element tr {
      element th { $corpus },
      element th {}
    }
  },
  element tbody {
  element tr {
    element td { "Identified places" },
    cp:prettylink( $corpus, $distinct, "http://croala.ffzg.unizg.hr/basex/cp-loci-id/" )
  },
  element tr {
    element td { "Mentions of places" },
    element td { $total }
  }
} }
};

declare function cp:report_count_places(){
  for $d in cp:list_corpus(db:open("cp-cite-loci")//record/ctsurn)
  return element div { 
  attribute class { "table-responsive" } ,
  cp:count_places($d)
}
};

declare function cp:loci-id-index($cts){
  let $list_places := if ($cts="corpus") then db:open("cp-cite-loci")//record/citelocus 
  else if (starts-with($cts, "urn:cts:croala")) then db:open("cp-cite-loci")//record[starts-with(ctsurn, $cts)]/citelocus 
  else element b { "CTS URN abest in collectionibus nostris."}
  for $place in distinct-values($list_places)
  let $place_record := db:open("cp-loci")//record[citebody/@citeurn=$place]
  let $place_label := $place_record/label
  let $place_uri := $place_record/uri
  let $occurrences := if ($cts="corpus") then db:open("cp-cite-loci")//record[citelocus=$place] else if (starts-with($cts, "urn:cts:croala:")) then db:open("cp-cite-loci")//record[citelocus=$place and starts-with(ctsurn, $cts)] else ()
  let $count_occurrences := count($occurrences)
  let $list_cts := $occurrences/ctsurn
  order by $place_label
  return if (count($list_places) <= 1) then 
    element tr { 
    element td { $place }
  }
 else 
 
    element tr {
      element td { if ($place_label) then cp:simple_link($place_uri , $place_label/string()) else "NOMEN LOCI DEEST" },
      element td { cp:simple_link("http://croala.ffzg.unizg.hr/basex/cite/" || $place , $place) }, 
  element td { $count_occurrences },
  element td { for $c in $list_cts return cp:simple_link("http://croala.ffzg.unizg.hr/basex/ctsp/" || $c , functx:substring-after-last($c, ":")) }
}
};

declare function cp:openciteurn_ana($urn) {
  
};

declare function cp:opencite_morph($urn) {
  if (starts-with($urn, "urn:cite:croala:latmorph.morph")) then
  for $r in collection("cp-latmorph")//record[morphcode/@citeurn=$urn]
  let $morph_set := db:open("cp-cite-morphs")//record[morph/@citeurn=$urn]
  let $morph_set_count := count($morph_set)
  return 
  element tr {
    element td { $urn },
    element td { data($r/morphcode) },
    element td { data($r/label)},
    cp:prettylink($urn , $morph_set_count, "http://croala.ffzg.unizg.hr/basex/cp-morph-cite/" )
  }
  else cp:deest()
};

declare function cp:opencite_latlexent($urn){
  if (starts-with($urn, "urn:cite:croala:latlexent.lex")) then
  for $r in collection("cp-latlexents")//record[lemma/@citeurn=$urn]
  let $lemma_set := db:open("cp-cite-lemmata")//record[lemma/@citeurn=$urn]
  let $lemma_set_count := count($lemma_set)
  return 
  element tr {
    element td { $urn },
    element td { data($r/lemma) },
    cp:prettylink($urn , $lemma_set_count, "http://croala.ffzg.unizg.hr/basex/cp-lemma-cite/" ),
    cp:prettylink("", replace(data($r/creator), "http://", ""), data($r/creator)),
    element td { data($r/datecreated) }
  }
  else cp:deest()
};

declare function cp:opencite_aetas($urn) {
  
};

declare function cp:open_citeurn($urn){
  if (starts-with($urn, "urn:cite:croala:loci.locid" )) 
  then cp:openciteurn_locid($urn)
  else if (starts-with($urn, "urn:cite:croala:loci.ana" )) then cp:openciteurn_ana($urn)
  else if (starts-with($urn, "urn:cite:croala:latmorph"))  then cp:opencite_morph($urn)
  else if (starts-with($urn, "urn:cite:croala:latlexent")) then cp:opencite_latlexent($urn)
  else if (starts-with($urn, "urn:cite:croala:aetas")) then cp:opencite_aetas($urn)
  else element b { "URN deest in collectionibus nostris." } 
   

};