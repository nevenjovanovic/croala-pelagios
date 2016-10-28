for $c in collection("cp-cite-lemmata")//csv
let $doc := doc("/home/neven/rad/croala-pelagios/csv/cite-annotationes-cum-lemmatibus.xml")
return replace node $c with $doc