for $w in //*[@ana='estlocus0' and not(name()='name')]
let $ana := $w/@ana
return delete node $ana