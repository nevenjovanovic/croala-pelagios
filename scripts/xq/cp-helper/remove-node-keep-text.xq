(: copy $cr := doc("/home/neven/rad/croalapelagiosxml/crijev-i-carm-1678-w.xml") :)
copy $cr := doc("/home/neven/rad/croalapelagiosxml/marul-mar-carmina-nonote.xml")
modify
let $keeptext := ("corr", "q")
for $e in $cr//*:text//*:l/*[name()=$keeptext]
let $string := " " || $e/string() || " "
return replace node $e with $string
return file:write("/home/neven/rad/croalapelagiosxml/marul-mar-carmina-nonote-noq.xml", $cr)