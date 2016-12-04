import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';

let $result := element list {
let $locid := ("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/bunic-loci-id.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/crijevic-loci-id.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/marulic-loci-id.csv", "https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/tubero-loci-id.csv","https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/modruski-loci-id.csv")
for $l in $locid
let $csv := fetch:text($l)
for $r in csv:parse($csv, map { 'header': true() })//record
let $cite_locus := if (number($r/LOCI_CITE_URN)) then "urn:cite:croala:loci.locid" || format-number($r/LOCI_CITE_URN, "99999") else "ERR"
let $cite_urn := if (number($r/SEQUENCE)) then "urn:cite:croala:loci.ana" || format-number($r/SEQUENCE, "999999") else "ERR"
where number($r/LOCI_CITE_URN) and not($r/ANNOTATOR_INITIALS[.="ANNOTATOR"])
return element record { 
attribute xml:id { substring-after($cite_urn, "croala:loci.")},
cp:makeelement ($cite_urn, "citeurn"),
cp:makeelement( $cite_locus, "citelocus") , 
cp:makeelement($r/CTS_URN, "ctsurn")  , 
cp:annotator($r) }
}
return file:write("/home/neven/rad/croala-pelagios/csv/loci/cp-cite-loci.xml", $result)
