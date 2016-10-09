(: create lexical entities from place identifications :)
element list {
for $w in //w
let $lemma := $w/label
let $urn := replace($w/citebody, 'loci.ana-nota.', 'latlexent.lex') || ".1"
let $creator := $w/creator
let $datecreated := current-date()
order by $lemma
return element w {
  element citebody { $urn },
  $lemma ,
  element shortdef { "" },
  $creator ,
  element datecreated { $datecreated }
}
}