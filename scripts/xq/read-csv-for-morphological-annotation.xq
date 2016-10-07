(: prepare words for morphological annotation :)
let $f := file:read-text("/home/neven/rad/croala-pelagios/csv/marul01.croala754085.croala-loci.csv")
for $r in csv:parse($f)//record[matches(entry[1]/string(), 'estlocus[1-4]')]
return 
$r/entry[2]/string()