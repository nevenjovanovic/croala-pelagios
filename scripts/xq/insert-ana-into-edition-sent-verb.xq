let $a := doc("/home/neven/rad/modruskiriarioizdanje/fons/treebank-wordlist-idx.xml")
let $b := collection("modr-editio-sv-idx")//*:list
for $i in $a//w
let $urn := $i/@urn
let $form := data($i)
let $pos := data($i/@postag)
let $hit := $b//w[@urn=$urn and text()=$form]
let $form2 := data($hit)
return if ($hit) then 
(:  :)
(: element r { $pos , $form , $form2 } :)
insert node attribute ana { $pos } into  db:open-id("modr-morph", data($hit/@id))
else()