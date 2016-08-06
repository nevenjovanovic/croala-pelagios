for $p in ("div1", "ref", "milestone", "pb", "back")
for $i in //*:text//*[name()=$p]
return delete node $i