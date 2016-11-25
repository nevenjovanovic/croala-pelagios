(: pull CSV from Github repo, create XML source for the cp-loci db:)
let $file := fetch:text("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/croala-aetates-myth.csv")
let $csv := csv:parse($file, map { 'header': true() })//record
let $list := element list { $csv }
return file:write("/home/neven/rad/croala-pelagios/csv/aetates/myth-periods1.xml", $list)
(: return $list :)