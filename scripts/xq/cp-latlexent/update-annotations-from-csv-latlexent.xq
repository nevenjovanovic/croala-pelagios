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
  (: get csv from remote (Google Drive) :)
for $file in file:children("/home/neven/rad/croalapelagiosxml/oznaceno")
where matches($file, "-morphologia.csv")
let $csv := file:read-text($file)
for $parsed in csv:parse($csv, map { 'header': true() })//record[not(CTS_URN="CTS URN") and not(ANNOTATOR_INITIALS="ANNOTATOR") and not(LEMMA_CITE_URN="LEMMA CITE URN") and not(matches(LEMMA, "\*")) and not(matches(LEMMA_CITE_URN, "\*"))]
let $cts := local:e($parsed/CTS_URN)
let $word2 := data(collection("cp-cts-urns")//w[@n=$parsed/CTS_URN/string()])
let $cts2 := $parsed/CTS_URN/string()
let $citemorphcts := local:e(collection("cp-cite-urns")//w[@n=$cts2]/@citeurn/string())
(: check whether everything's right; slows things down :)
let $word := local:check($parsed/Nomen, $word2)
let $lemmacite := local:e($parsed/LEMMA_CITE_URN)
let $lemma2 := collection("cp-latlexents")//record[entry[1]=$lemmacite/string()]/entry[2]
let $lemma := local:check($parsed/LEMMA, $lemma2/string())
let $annotator := local:e(
  map:get($ann, $parsed/ANNOTATOR_INITIALS)
)
let $reviewer := element entry {}
let $datecreated := local:e(current-date())
let $datereviewed := element entry {}
return element record { $cts , $word , $citemorphcts, $lemma, $lemmacite , $annotator, $reviewer, $datecreated , $datereviewed }
}
(: remove errors from result :)
return copy $n := $result
modify delete node $n//record[err]
return $n