(: todo -- return CTS address for div / div / para / sentence etc :)
(: 30 queries -- 8099 ms :)
let $queries := for $n in 1 to 30
for $csv in csv:parse(file:read-text("/home/neven/rad/croala-pelagios/csv/tuberoidx-loci.csv"))//*:record[$n]/*:entry[1]
return $csv
for $q in $queries
let $results := element r {
for $f in db:open("tub-com-idx")//*:w
where data($f[text() contains text { data($q) } using fuzzy ])
return element placeName { $f/@n , $f/text()  }
}
for $r in $results//*:placeName
where $r[matches(text(), '^[A-Z]')]
return $r
