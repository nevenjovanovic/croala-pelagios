import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';

let $result := element list {
let $aetas_id := ("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/bunic-aetates-id.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/crijevic-aetates-id.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/marulic-aetates-id.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/tubero-aetates-id.csv","https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/modruski-aetates-id.csv")
for $a in $aetas_id
let $csv := fetch:text($a)
for $r in csv:parse($csv, map { 'header': true() })//record
let $cite_aetas := if (number($r/AETATIS_CITE_URN)) then "urn:cite:croala:loci.aetas" || format-number($r/AETATIS_CITE_URN, "99999") else "ERR"
let $cite_urn := if (number($r/SEQUENCE)) then "urn:cite:croala:loci.ana" || format-number($r/SEQUENCE, "999999") else "ERR"
where number($r/AETATIS_CITE_URN) and not($r/ANNOTATOR_INITIALS[.="ANNOTATOR"])
return element record { 
attribute xml:id { substring-after($cite_urn, "croala:loci.")},
cp:makeelement ($cite_urn, "citeurn"),
cp:makeelement( $cite_aetas, "citeaetas") , 
cp:makeelement($r/CTS_URN, "ctsurn")  , 
cp:annotator($r) }
}
  let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/aetates/cp-cite-aetates.xml"
return file:write($fileuri, $result)
