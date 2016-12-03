import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';
(: from a list of lemmatized words, create new lemma entries for ones missing in cp-latlexents; XML :)
let $doc := doc("/home/neven/rad/croala-pelagios/csv/cite-lemmata01.xml")
let $lemmalist :=
for $r in $doc//record[lemma[not(@citeurn)]]
let $lemma := upper-case($r/lemma/string())
return distinct-values($lemma)
for $l at $pos in $lemmalist
let $id := 50105 + $pos
let $citeid := "lex" || $id
let $citeurn := "urn:cite:croala:latlexent." || $citeid
let $datecreated := cp:makeelement(format-date(current-date(), "[Y0001]-[M01]-[D01]"), "datecreated")
return element record {
  attribute citeid { $citeid  },
  element lemma {
    attribute citeurn { $citeurn },
    $l
  },
  element creator {
    "http://orcid.org/0000-0002-9119-399X"
  },
  $datecreated
}