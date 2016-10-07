for $p in //*:text//*:w[matches(@n/string(), 'placeName')]
let $nval := replace($p/@n/string(), 'placeName', 'w')
return replace value of node $p/@n with $nval