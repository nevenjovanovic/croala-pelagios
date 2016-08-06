for $p in ("argument", "div", "head", "opener", "p", "quote", "trailer")
for $n in ("abbr", "add", "corr", "gloss", "mentioned", "name", "num", "q", "sic", "term")
for $i in //*:text//*[name()=$p]/*[name()=$n]
let $text := data($i)
return replace node $i with $text