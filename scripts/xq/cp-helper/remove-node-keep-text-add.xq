copy $cr := doc("/home/neven/rad/croalapelagiosxml/crijev-i-carm-1678-w2.xml")
modify
let $keeptext := ("add")
for $e in $cr//*:text//*[name()=$keeptext]
let $string := $e/string()
return replace node $e with $string
return file:write("/home/neven/rad/croalapelagiosxml/crijev-i-carm-1678-w.xml", $cr)