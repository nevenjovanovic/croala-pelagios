declare function local:e($e){
  element entry { data($e) }
};
declare function local:check($a, $b) {
  if ($a/text()=$b) then local:e($a) else element err { $a , ": ERROR!" }
};
for $file in file:children("/home/neven/rad/croalapelagiosxml/oznaceno")
where matches($file, "-morphologia.csv")
let $csv := file:read-text($file)
for $parsed in csv:parse($csv, map { 'header': true() })//record[not(CTS_URN="CTS URN") and not(ANNOTATOR_INITIALS="ANNOTATOR") and not(LEMMA_CITE_URN="LEMMA CITE URN") and not(matches(LEMMA, "\*")) and not(matches(LEMMA_CITE_URN, "\*"))]
let $cts := local:e($parsed/CTS_URN)
let $word2 := data(collection("cp-cts-urns")//w[@n=$parsed/CTS_URN/string()])
let $word := local:check($parsed/Nomen, $word2)
let $lemmacite := local:e($parsed/LEMMA_CITE_URN)
let $lemma2 := collection("cp-latlexents")//record[entry[1]=$lemmacite/string()]/entry[2]
let $lemma := local:check($parsed/LEMMA, $lemma2/string())
let $morph := local:e($parsed/MORPH_CITE_URN)
let $annotator := local:e($parsed/ANNOTATOR_INITIALS)
let $reviewer := element entry {}
let $datecreated := local:e(current-date())
let $datereviewed := element entry {}
return element new { $cts, $word , $lemmacite , $lemma, $annotator, $reviewer, $datecreated , $datereviewed }
