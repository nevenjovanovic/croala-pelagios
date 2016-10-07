(: group on placeuris :)
let $f := doc("/home/neven/rad/croala-pelagios/csv/modrtub-idx-citebodies.xml")
let $list := element list {
for $c in $f//r
let $a := $c/anno
let $b := element citebody { $c/note/entry/string() }
let $p := $c/place
let $l := $c/label/entry/string()
group by $p
return if ($p) then element w { 
element label { $l } , 
element uri { for $uri in tokenize($p, 'https?://')[2] return $uri } , $b ,
element creator {
    "http://orcid.org/0000-0002-9119-399X"
},
element datecreated {
    "2016-09-03T18:13:50Z"
} } else()
}
return file:write("/home/neven/rad/croalapelagiosxml/cpplaces.xml", $list)