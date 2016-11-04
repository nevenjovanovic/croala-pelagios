let $db := ("cp-cite-urns", "cp-cite-morphs", "cp-cts-urns", "cp-loci", "cp-aetates", "cp-latlexents", "cp-latmorph", "cp-cite-lemmata", "cp-2-texts")
for $d in $db
let $url := replace("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('REPLACEXXX')", "REPLACEXXX", $d)
let $c := try { doc($url) } catch * { $err:description }
return if (matches($c, "bxerr")) then element r { substring-after($c, "Information:") } else element {$d} { $c//databaseproperties/timestamp }