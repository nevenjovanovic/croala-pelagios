let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/cite-lemmata.xml"
let $db := db:open("cp-cite-lemmata")//list
return file:write($fileuri, $db)