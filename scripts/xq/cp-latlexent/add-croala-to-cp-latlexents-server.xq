(: add to db CroALa additions to the inventory of Latin words :)
let $xml := "/home/croala/croala-pelagios/csv/cp-croala-latlexents.xml"
return db:add("cp-latlexents", $xml)