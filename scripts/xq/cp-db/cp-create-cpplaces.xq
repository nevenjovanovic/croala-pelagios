(: pull CSV from Github repo, create XML source for the cp-loci db:)
let $file := fetch:text("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/loci/loci-id-novi.csv")
let $csv := csv:parse($file, map { 'header': true() })//record
let $list := element list { $csv }
return file:write("/home/neven/Repos/croala-pelagios/csv/cpplaces2.xml", $list)
(: return $list :)