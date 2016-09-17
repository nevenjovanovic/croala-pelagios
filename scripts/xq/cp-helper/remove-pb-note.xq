(: copy $cr := doc("/home/neven/rad/croalapelagiosxml/crijev-i-carm-1678-n.xml") :)
copy $cr := doc("/home/neven/rad/croala-r/basex/txts/marul-mar-carmina.xml")
modify
let $nonodes := ("pb", "note", "del")
for $e in $cr//*:TEI/*:text//*[name()=$nonodes]
return delete node $e
return file:write("/home/neven/rad/croalapelagiosxml/marul-mar-carmina-nonote.xml", $cr)