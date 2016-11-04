let $upper := (
  for $r in db:open("cp-latlexents")//csv/record[not(matches(entry[2]/text(), '\s'))]/entry[2]
  return fn:upper-case($r/string())
)
return element list {
for $l in distinct-values($upper)
return element record {
  element lemma { $l },
  element uri { "urn:cite:croala:latlexent.lex" }
}
}