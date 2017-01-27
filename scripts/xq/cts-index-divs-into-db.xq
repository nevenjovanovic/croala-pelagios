(: cts-index-divs-into-db.xq :)
(: Create db with indices to div elements :)

(: annotators :)
declare variable $ann := map {
  "urn:cts:croala:crije01" : "http://orcid.org/0000-0003-1457-7081",
  "urn:cts:croala:nikolamodr01" : "http://orcid.org/0000-0002-9119-399X",
  "urn:cts:croala:bunic02" : "http://orcid.org/0000-0001-5515-6545",
  "urn:cts:croala:marul01" : "http://orcid.org/0000-0002-0438-6049",
  "urn:cts:croala:crije02" : "http://orcid.org/0000-0002-2135-6343"
};

declare function local:ntree($words, $ctsname) {
  for $f in $words
let $tree := string-join(data($f/ancestor-or-self::*[@n]/@n),'.')
return element record { 
attribute xml:id {db:node-id($f)} , 
element ctsurn { $ctsname || ":" || $tree } }
};
let $windex :=
element wlist {
for $xmlfile in collection("cp-2-texts")//*:TEI[descendant::*:w]
let $cts := $xmlfile//*:text/@xml:base
let $names := ("div", "body", "p", "l", "opener", "closer", "epigraph", "argument", "quote", "trailer", "sp", "note", "q", "s", "speaker", "titlePart")
(: to speed things up, use only words with @ana :)
for $f in $xmlfile//*:text//*[name()=$names]
let $ntree := local:ntree($f, $cts)
return $ntree
}
return db:create("cp-div-cts", $windex, "cts-divs.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })
(: return $windex :)