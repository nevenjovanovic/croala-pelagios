(: from a fork of latlexent, create cite inventory for words :)
let $xml := "/home/neven/rad/croala-pelagios/csv/cp-croala-latlexents.xml"
return db:add("cp-latlexents", $xml)