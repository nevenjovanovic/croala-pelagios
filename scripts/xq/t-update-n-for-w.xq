for $w in //*:w[matches(@n,'placeName') and text()='Per']
let $n := replace($w/@n,'placeName', 'w')
return replace value of node $w/@n with $n