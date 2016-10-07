(: group on placeuris :)
let $f := doc("/home/neven/rad/croala-pelagios/csv/modrtub-idx-citebodies.xml")
let $list := element list {
for $c in $f//r
let $a := $c/anno
let $b := $c/note/entry
let $p := $c/period/entry
let $l := $c/periodlabel/entry
group by $p
return if ($p) then element w { 
element label { distinct-values($l) } , 
element uri { $p } , 
element citebody {
  replace($b[1], 'ana-nota', 'ana-nota-aetas')
} ,
element creator {
    "http://orcid.org/0000-0002-9119-399X"
},
element datecreated {
    "2016-09-03T18:13:50Z"
} } else()
}
return file:write("/home/neven/rad/croalapelagiosxml/cpperiods.xml", $list)