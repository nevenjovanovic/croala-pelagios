let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/loci/cp-cite-loci.xml"
let $db := db:open("cp-cite-loci", "cp-cite-loci.xml")//list
return file:write($fileuri, $db)