import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';

declare variable $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/cite-morphs2.xml";

declare function local:check($a, $name, $b) {
  if ($a/text()=$b) then cp:makeelement($a, $name) else element err { $a , ": ERROR!" }
};

let $result := element list {
  (: get csv from remote (Github repo) :)
for $file in ("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/bunic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/crijevic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/marulic-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/tubero-loci-morphologia.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/morph/modruski-loci-morphologia.csv")
let $csv := fetch:text($file)
for $parsed in csv:parse($csv, map { 'header': true() })//record[not(CTS_URN="CTS URN") and not(ANNOTATOR_INITIALS="ANNOTATOR") and not(MORPH_CITE_URN="MORPH CITE URN") and not(matches(LEMMA, "\*")) and not(matches(LEMMA_CITE_URN, "\*"))]
let $cts2 := $parsed/CTS_URN/string()
let $cts := attribute cts { $cts2 }
let $cite2 := collection("cp-cite-urns")//w[@n=$cts2]
let $citec := $cite2/@citeurn/string()
let $citeid := attribute citeid { replace($citec, "urn:cite:croala:loci.", "" ) }
let $citeurn := attribute citeurn { $citec  }

let $citemorphurn := if ($cite2) then $citeurn else attribute citeurn { "ZZZZZZ"}
let $word := cp:makeelement($parsed/Nomen, "lemma")
let $citemorph := replace($parsed/MORPH_CITE_URN/string(), "\.morph\.", ".morph")
let $morphcode := 
  collection("cp-latmorph")//record[morphcode/@citeurn=$citemorph]/label/string()
let $annotator := cp:annotator($parsed)
let $datecreated := cp:makeelement(format-date(current-date(), "[Y0001]-[M01]-[D01]"), "datecreated")
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
return file:write($fileuri, $result)