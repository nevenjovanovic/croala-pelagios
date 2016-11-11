declare function local:e($e, $name){
  element {$name} { data($e) }
};
declare function local:check($a, $name, $b) {
  if ($a/text()=$b) then local:e($a, $name) else element err { $a , ": ERROR!" }
};
declare variable $ann := map {
  "ZS" : "http://orcid.org/0000-0003-1457-7081",
  "NJ" : "http://orcid.org/0000-0002-9119-399X",
  "AS" : "http://orcid.org/0000-0001-5515-6545",
  "NČ" : "http://orcid.org/0000-0002-0438-6049",
  "AŽ" : "http://orcid.org/0000-0002-2135-6343"
};

let $result := element list {
  (: get csv from remote (Github repo) :)
for $file in ("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/bunic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/crijevic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/marulic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/tubero-loci-morphologia.csv")
let $csv := fetch:text($file)
for $parsed in csv:parse($csv, map { 'header': true() })//record[not(CTS_URN="CTS URN") and not(ANNOTATOR_INITIALS="ANNOTATOR") and not(MORPH_CITE_URN="MORPH CITE URN") and not(matches(LEMMA, "\*")) and not(matches(LEMMA_CITE_URN, "\*"))]
let $cts2 := $parsed/CTS_URN/string()
let $cts := attribute cts { $cts2 }
let $cite2 := collection("cp-cite-urns")//w[@n=$cts2]
let $citec := $cite2/@citeurn/string()
let $citeid := attribute citeid { replace($citec, "urn:cite:croala:loci.", "" ) }
let $citeurn := attribute citeurn { $citec  }

let $citemorphurn := if ($cite2) then $citeurn else attribute citeurn { "ZZZZZZ"}
let $word := local:e($parsed/Nomen, "lemma")
let $citemorph := replace($parsed/MORPH_CITE_URN/string(), "\.morph\.", ".morph")
let $morphcode := 
  collection("cp-latmorph")//record[morphcode/@citeurn=$citemorph]/label/string()
let $annotator := local:e(
  map:get($ann, $parsed/ANNOTATOR_INITIALS), "creator"
)
let $datecreated := local:e(format-date(current-date(), "[Y0001]-[M01]-[D01]"), "datecreated")
return element record { 
$citeid ,
element seg { $cts ,
$citemorphurn ,
data($word) } ,
element morph {
  attribute citeurn { $citemorph } ,
$morphcode
 },
$annotator,
$datecreated
}
}
(: return validate:rng-report($result, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpcitemorphs.rng') :)
return file:write("/home/neven/Repos/croala-pelagios/csv/cite-morphs2.xml", $result)