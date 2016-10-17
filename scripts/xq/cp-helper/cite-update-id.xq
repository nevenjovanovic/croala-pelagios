for $e in collection("cp-cts-cite-idx")//record
  let $xmlid := collection("cp-cts-urns")//w[@n=$e/entry[4]/string()]/@xml:id/string()
  let $id := $e/entry[1]
  return replace value of node $id with $xmlid