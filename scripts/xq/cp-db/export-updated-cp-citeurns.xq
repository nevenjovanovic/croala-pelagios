let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/cp-citeurns.xml"
let $db := db:open("cp-cite-urns", "cp-citeurns.xml")//csv
return file:write($fileuri, $db)