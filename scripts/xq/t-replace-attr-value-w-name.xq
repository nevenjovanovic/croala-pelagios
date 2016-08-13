for $nodenames in ("w", "name")
for $loc in collection("tubero-commentarii")//*:text//*[name()=$nodenames and matches(@n,'placeName')]
let $place := replace($loc/@n,'placeName',$nodenames)
return replace value of node $loc/@n with $place