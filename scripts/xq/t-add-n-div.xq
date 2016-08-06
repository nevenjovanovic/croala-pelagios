(: phase 2 - insert @n into divs on all levels :)
for $n in (
"div",
"trailer",
"docAuthor",
"docTitle",
"front",
"titlePart",
"opener",
"s",
"w",
"p",
"pc",
"body",
"head"
)
for $e in //*:text//*[name()=$n and not(@n)]
let $name := $e/name()
let $precsib := count($e/preceding-sibling::*[name()=$name]) + 1
return insert node attribute n { $name || $precsib } into $e