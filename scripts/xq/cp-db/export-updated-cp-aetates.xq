let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/aetates/"
return db:export($fileuri, "cp-aetates")