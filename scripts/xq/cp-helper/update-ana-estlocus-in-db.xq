(: update @ana attributes from CSV with annotations :)
(: for cpoe db :)
let $f := file:read-text("/home/neven/rad/croala-pelagios/csv/marulic-carmina-loci.csv")
for $pn in csv:parse($f, map { 'header': true() })//record
let $n := substring-after($pn/URN,'urn:cts:croala:marulic-m.carmina.croala-lat.loci:')
let $estloc := $pn/estLocus/string()
let $node := db:open("cpoe","marul-mar-carmina-w-n.xml")//*[@n=$n]
return replace value of node $node/@ana with $estloc