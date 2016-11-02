let $csv := file:read-text("/home/neven/Repos/croala-pelagios/csv/inventory_import.csv")
let $lemmas := csv:parse($csv)//record/entry[2]
let $count := count($lemmas)
let $distinct := count(distinct-values($lemmas))
return element r { $count , $distinct , $count - $distinct }