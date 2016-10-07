let $tbidx := element list {
for $w in collection("modr-tb")//*:word[not(@lemma='punc1')]
let $s := data($w/parent::*/parent::*/@target) || "." || data($w/parent::*/@id) || "." || data($w/@id)
let $pos := $w/@postag
return element w { 
attribute id { db:node-id($w)},
attribute urn {
$s } ,
$pos ,
data($w/@form)
}
}
return file:write("/home/neven/rad/modruskiriarioizdanje/fons/treebank-wordlist-idx.xml", $tbidx)