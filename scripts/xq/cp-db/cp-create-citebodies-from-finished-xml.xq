(: from an XML file with finished identification :)
(: create a list of CITE Bodies URNs :)
(: let $f := doc("/home/croala/croala-pelagios/csv/modrtub-idx-citebodies.xml") :)
let $f := doc("/home/neven/rad/croala-pelagios/csv/modrtub-idx-citebodies.xml")

let $list := element list {
for $c in $f//r
let $a := $c/anno
(: the following should be changed to ana-nota-loci, as opposed to :)
(: ana-nota-temporis :)
let $b := element citebodies { $c/note/entry }
let $p := $c/place
let $l := element placelabel { $c/label/entry }
return if ($p) then element w { $p , $l, $b } else()
}
return db:create("cp-places", $list, "cp-placeuris.xml", map {'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })