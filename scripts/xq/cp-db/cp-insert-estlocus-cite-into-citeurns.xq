declare variable $ann := map {
  "urn:cts:croala:crije01" : "http://orcid.org/0000-0003-1457-7081",
  "urn:cts:croala:nikolamodr01" : "http://orcid.org/0000-0002-9119-399X",
  "urn:cts:croala:bunic02" : "http://orcid.org/0000-0001-5515-6545",
  "urn:cts:croala:marul01" : "http://orcid.org/0000-0002-0438-6049",
  "urn:cts:croala:crije02" : "http://orcid.org/0000-0002-2135-6343"
};

for $estlocus in collection("cp-cite-urns")//*[matches(@ana,"estlocus")]
(: let $cite := attribute locusurn { "urn:cite:croala:loci.estlocus" || replace($estlocus/@xml:id/string(), '^ana', '') } :)
let $creator := attribute creator { map:get($ann , substring-before($estlocus/@n, ".") ) }
return insert node $creator  into $estlocus