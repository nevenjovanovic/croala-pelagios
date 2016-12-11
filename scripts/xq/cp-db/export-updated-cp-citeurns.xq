(: export XML source from CITE list :)
let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/cp-citeurns.xml"
let $db := db:open("cp-cite-urns", "cp-citeurns.xml")//list
return file:write($fileuri, $db)