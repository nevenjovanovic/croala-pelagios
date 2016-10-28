let $db := db:open("cp-latlexents", "cp-croala-latlexents.xml")//csv
return file:write("/home/neven/rad/croala-pelagios/csv/cp-croala-latlexents.xml", $db)