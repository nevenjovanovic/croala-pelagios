copy $cr := doc("/home/neven/rad/croalapelagiosxml/crijev-i-carm-1678-w2.xml")
modify
for $e in $cr//*:text//*[text()]
let $pc := ft:mark($e[text() contains text "\W"])
return replace node $e with $pc
return $cr