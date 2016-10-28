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

let $result := element csv {
for $file in file:children("/home/neven/rad/croalapelagiosxml/oznaceno")
where matches($file, "-morphologia.csv")
let $csv := file:read-text($file)
for $parsed in csv:parse($csv, map { 'header': true() })//record[not(CTS_URN="CTS URN") and not(ANNOTATOR_INITIALS="ANNOTATOR") and not(MORPH_CITE_URN="MORPH CITE URN") and not(matches(LEMMA, "\*")) and not(matches(LEMMA_CITE_URN, "\*"))]
let $cts := local:e($parsed/CTS_URN)
let $cts2 := $parsed/CTS_URN/string()
let $citemorphcts := local:e(collection("cp-cite-urns")//w[@n=$cts2]/@citeurn/string())
let $word := local:e($parsed/Nomen)
let $citemorph := local:e($parsed/MORPH_CITE_URN)
let $morphcode := local:e(
  collection("cp-latmorph")//record[entry[1]=$citemorph]/entry[3]
)
let $annotator := local:e(
  map:get($ann, $parsed/ANNOTATOR_INITIALS)
)
let $datecreated := local:e(current-date())
return element record { 
$cts ,
$word,
$citemorphcts ,
$morphcode ,
$citemorph,
$annotator,
element entry {},
$datecreated ,
element entry {}
}
}
return replace node collection("cp-cite-morphs")//csv with $result