let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/croala-latlexents-2.xml"
let $db := db:open("cp-latlexents")//list
return file:write($fileuri, $db)