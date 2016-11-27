let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/latlexents/cp-croala-latlexents.xml"
let $db := db:open("cp-latlexents", "cp-croala-latlexents.xml")//csv
return file:write($fileuri, $db)