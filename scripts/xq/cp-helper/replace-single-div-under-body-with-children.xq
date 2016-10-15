for $t in //*:text/*:body/*:div[last() and position()=1]
let $children := $t/*
return replace node $t with $children