import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';
(: from a list of lemmatized words, create new lemma entries for ones missing in cp-latlexents; CSV result :)
let $doc := doc("/home/neven/rad/croala-pelagios/csv/cite-lemmata01.xml")
let $lemmalist :=
for $r in $doc//record[lemma[not(@citeurn)]]
let $lemma := upper-case($r/lemma/string())
return distinct-values($lemma)
let $csv := element csv {
for $l at $pos in $lemmalist
let $id := 50105 + $pos
let $citeid := "lex" || $id
let $citeurn := "urn:cite:croala:latlexent." || $citeid
let $datecreated := cp:makeelement(format-date(current-date(), "[Y0001]-[M01]-[D01]"), "entry")
return element record {
  element entry { $citeurn  },
  element entry { $l
  },
  element entry { "TBA"},
  element entry {
    "http://orcid.org/0000-0002-9119-399X"
  },
  $datecreated
}
}
return csv:serialize($csv)