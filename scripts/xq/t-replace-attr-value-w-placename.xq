for $strings in ("w", "locus")
for $loc in collection("tubero-commentarii")//*:text//*:placeName[matches(@n,$strings)]
let $place := replace($loc/@n,$strings,'placeName')
return replace value of node $loc/@n with $place