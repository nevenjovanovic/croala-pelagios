(: from a temporary finished XML :)
(: group on perioduris :)
(: create db cp-periods :)
(: let $f := doc("/home/neven/rad/croala-pelagios/csv/modrtub-idx-citebodies.xml") :)
let $f := doc("/home/croala/croala-pelagios/csv/modrtub-idx-citebodies.xml")
let $list := element list {
for $c in $f//r
let $a := $c/anno
let $b := element citebody { $c/note/entry }
let $p := $c/period
let $l := $c/periodlabel
group by $p
return element w { 
element period { $p } , 
element label { distinct-values($l) } ,
element citebodies {
for $cb in $b/entry let $sq := xs:integer(substring-after($cb , "-nota.")) order by $sq return $cb }
}
}
return 
db:create("cp-periods", $list, "cp-periods.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })