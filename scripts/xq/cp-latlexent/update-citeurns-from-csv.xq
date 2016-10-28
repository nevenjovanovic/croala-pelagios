declare function local:openurn ($ctsadr) {
let $w := db:open("cp-cts-urns")//*:w[@n=$ctsadr]
return if ($w) then
let $pre := xs:integer($w/@xml:id)
let $node := db:node-id(db:open-id("cp-2-texts", $pre)) 
return $node 
else "NODUS_DEEST!"
};

declare function local:e($e){
  element entry { data($e) }
};
declare function local:check($a, $b) {
  if ($a/text()=$b) then local:e($a) else element err { $a , ": ERROR!" }
};
declare variable $ann := map {
  "ZS" : "orcid.org/0000-0003-1457-7081",
  "NJ" : "orcid.org/0000-0002-9119-399X",
  "AS" : "orcid.org/0000-0001-5515-6545",
  "NČ" : "orcid.org/0000-0002-0438-6049",
  "AŽ" : "orcid.org/0000-0002-2135-6343"
};

let $result := element list {
for $file in file:children("/home/neven/rad/croalapelagiosxml/oznaceno")
where matches($file, "-morphologia.csv")
let $csv := file:read-text($file)
for $parsed in csv:parse($csv, map { 'header': true() })//record[not(CTS_URN="CTS URN") and not(ANNOTATOR_INITIALS="ANNOTATOR") and not(MORPH_CITE_URN="MORPH CITE URN") and not(matches(LEMMA, "\*")) and not(matches(LEMMA_CITE_URN, "\*"))]
let $cts := $parsed/CTS_URN/string()
let $node := 
let $n := attribute n { $cts }
let $w := db:open("cp-cite-urns")//*:w[@n=$cts]
let $citeurn := 
if ($w) then $w/@citeurn
    else attribute citeurn { "urn:cite:croala:loci.ana." || local:openurn($cts) }
let $citeaex := attribute citeaex {
  replace($cts, ":([^:]+)$", ".lexis:$1")
}
let $nomen := $parsed/Nomen/string()
return element w {
  $n,
  $citeurn,
  $citeaex ,
  $nomen
}
return $node }
return replace node collection("cp-cite-urns")//list with $result