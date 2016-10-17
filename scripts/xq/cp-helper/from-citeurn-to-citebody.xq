for $e in collection("cp-cite-urns")//w
  let $loci := $e/@citeurn/string()
  let $result := collection("cp-citebody")//r[anno/entry[.=$loci]]
  return $result