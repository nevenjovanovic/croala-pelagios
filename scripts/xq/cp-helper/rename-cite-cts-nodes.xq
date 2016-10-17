for $e in collection("cp-cts-cite-idx")//record/entry[4]
  where $e[starts-with(., "urn:cts:croala:tubero.commentarii.croala-loci:")]
  let $newe := replace($e/string(), "urn:cts:croala:tubero.commentarii.croala-loci:", "urn:cts:croala:crije01.croala789994.croala-lat2w:")
  return replace value of node $e with $newe