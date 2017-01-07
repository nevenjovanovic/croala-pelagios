(: cp-cts-index-placename-into-db.xq :)
(: Create db with indices to cp elements with @n and @ana :)
(: cp includes two files :)

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
return element w { 
attribute xml:id {db:node-id($f)} , 
attribute n { $ctsname || ":" || $tree } , 
attribute aex { $ctsname || ".lexis:" || $tree } , 
$f/@ana , 
attribute creator { map:get($ann, substring-before($ctsname, "."))},
data($f) }
};
let $windex :=
element wlist {
for $xmlfile in collection("cp-2-texts")//*:TEI[descendant::*:w]
let $cts := $xmlfile//*:text/@xml:base
let $names := ("placeName", "name", "w", "tei:w")
(: to speed things up, use only words with @ana :)
for $f in $xmlfile//*:text//*[name()=$names and @ana]
let $ntree := local:ntree($f, $cts)
return $ntree
}
return db:create("cp-cts-urns", $windex, "cts-urns.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })
(: return $windex :)