for $e in collection("cp-cts-cite-idx")//record/entry[4]
  where $e[starts-with(., "urn:cts:croala:crije01.croala789994.croala-lat2w:")]
  let $newe := replace($e/string(), "\.placeName", ".w")
  return replace value of node $e with $newe