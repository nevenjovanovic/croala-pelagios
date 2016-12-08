(: pull updated CSV from Github repo - source: G drive - create XML source for the cp-loci db:)
let $file := fetch:text("https://github.com/nevenjovanovic/croala-pelagios/raw/master/csv/aetates/aetates-id-novae.csv")
let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/aetates/aetates-id-novae.xml"
let $csv := csv:parse($file, map { 'header': true() })//record
let $list := element list { $csv }
return file:write($fileuri, $list)
(: return $list :)