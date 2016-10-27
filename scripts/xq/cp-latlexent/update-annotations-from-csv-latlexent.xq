declare function local:e($e){
  element entry { data($e) }
};
for $file in file:children("/home/neven/Documents/xlscsv")
let $csv := file:read-text($file)
for $parsed in csv:parse($csv, map { 'header': true() })//record[not(CTS_URN="CTS URN") and not(ANNOTATOR_INITIALS="ANNOTATOR")]
let $cts := local:e($parsed/CTS_URN)
let $word := local:e($parsed/Nomen)
let $lemmacite := local:e($parsed/LEMMA_CITE_URN)
let $lemma := local:e($parsed/LEMMA)
let $morph := local:e($parsed/MORPH_CITE_URN)
let $annotator := local:e($parsed/ANNOTATOR_INITIALS)
let $reviewer := element entry {}
let $datecreated := local:e(current-date())
let $datereviewed := element entry {}
return element new { $cts, $word , $lemmacite , $lemma, $annotator, $reviewer, $datecreated , $datereviewed }