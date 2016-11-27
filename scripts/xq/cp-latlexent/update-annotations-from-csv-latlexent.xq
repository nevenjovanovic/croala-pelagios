import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';


declare function local:check($a, $name, $b) {
  if ($a/text()=$b) then cp:makeelement($a, $name) else element err { $a , ": ERROR!" }
};
declare variable $path := substring-before(file:base-dir(), 'scripts/') || "csv/cite-lemmata.xml"
;

let $result := element list {
  (: get csv from remote (Github repo) :)
for $file in ("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/bunic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/crijevic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/marulic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/tubero-loci-morphologia.csv")
let $csv := fetch:text($file)
for $parsed in csv:parse($csv, map { 'header': true() })//record[not(CTS_URN="CTS URN") and not(ANNOTATOR_INITIALS="ANNOTATOR") and not(LEMMA_CITE_URN="LEMMA CITE URN") and not(matches(LEMMA, "\*")) and not(matches(LEMMA_CITE_URN, "\*"))]

let $cts2 := $parsed/CTS_URN/string()
let $cite2 := collection("cp-cite-urns")//w[@n=$cts2]
let $citec := $cite2/@citeurn/string()
let $citeid := attribute citeid { replace($citec, "urn:cite:croala:loci.", "" ) }
let $citeurn := attribute citeurn { $citec  }
let $citelabel := data($cite2)
let $cts := attribute cts { $cts2 }
let $word2 := data(collection("cp-cts-urns")//w[@n=$cts2])
(: check whether everything's right; slows things down :)
let $word := local:check($parsed/Nomen, $word2, "lemma")
let $lemmalabel := $parsed/LEMMA/string()
let $lemma2 := collection("cp-latlexents")//record[lemma/text()=upper-case($lemmalabel)]
let $lemmacite := $lemma2/lemma/@citeurn
let $annotator := cp:annotator($parsed)
let $datecreated := cp:makeelement(format-date(current-date(), "[Y0001]-[M01]-[D01]"), "datecreated")
return element record { 
$citeid ,
element seg { $citeurn , $cts, $citelabel } , 
element lemma { $lemmacite, $lemmalabel }, 
$annotator, 
$datecreated
 }
}
(: remove errors from result :)
return copy $n := $result
modify delete node $n//record[err]
(: return validate:rng-report($n, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpcitelemmata.rng')
 :)
return file:write($path, $n)