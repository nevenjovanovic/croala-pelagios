declare default element namespace "http://www.tei-c.org/ns/1.0";
for $names in ("head", "opener", "p", "trailer")
(: think carefully so not to lose anything :)
for $t in //*:text//*[name()=$names and parent::*:div]
let $ss :=
let $para := string-join($t//text(), ' ')
for $s in tokenize(fn:normalize-space($para), '#')
return element s { fn:normalize-space($s) }
return replace node $t with element { xs:QName($names) } { $ss  }