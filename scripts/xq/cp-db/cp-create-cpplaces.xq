(: pull CSV from Github repo, create XML source for the cp-loci db:)
let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/loci/cpplaces.xml"
let $file := fetch:text("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/loci-id-novi.csv")
let $csv := csv:parse($file, map { 'header': true() })//record
let $list := element list { $csv }
return file:write($fileuri, $list)
(: return $list :)