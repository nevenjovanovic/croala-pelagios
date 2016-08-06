declare default element namespace "http://www.tei-c.org/ns/1.0";
declare function local:sentence($q){
  for $s in tokenize(fn:normalize-space($q), '#')
return element s { fn:normalize-space($s) }
};
(: there are two types of quotes :)
for $names in ("argument", "quote")
for $t in //*:text//*[name()=$names]
return if ($t/*:p) then
let $ss :=
let $para := string-join($t//text(), ' ')
return local:sentence($para)
return replace node $t with element { xs:QName($names) } { element { xs:QName("p") } { $ss  } }
else 
let $ss :=
let $para := string-join($t/text(), ' ')
return local:sentence($para)
return replace node $t with element { xs:QName($names) }  { $ss  }