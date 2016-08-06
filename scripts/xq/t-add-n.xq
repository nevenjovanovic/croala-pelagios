(: phase 1 - insert @n into children of last div where they don't exist :)
for $n in (
"opener",
"argument",
"quote",
"p",
"pc",
"s",
"w"
)
for $e in //*:text/*:body/*:div//*[name()=$n and not(@n)]
let $name := $e/name()
let $precsib := count($e/preceding-sibling::*[name()=$name]) + 1
return insert node attribute n { $name || $precsib } into $e