(: from a fork of latlexent, create cite inventory for words :)
let $i := file:read-text("/home/neven/rad/croala-pelagios/csv/inventory_import.csv")
let $csv := csv:parse($i)
return db:create("cp-latlexents", $csv, "perseus-latlexents", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })