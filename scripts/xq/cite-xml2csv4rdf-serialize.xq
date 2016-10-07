(: from XML prepare CSV for RDF, convert list into space separated string :)
copy $xml := doc("/home/neven/rad/croala-pelagios/csv/tuberoidx-citeobjects.xml")
modify (
  for $p in $xml//anno
  let $annos := string-join($p/*, ' ')
  return replace value of node $p with $annos
)
return csv:serialize($xml)