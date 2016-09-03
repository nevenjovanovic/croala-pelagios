let $f := doc("/home/neven/rad/croala-pelagios/csv/modrtub-idx-citebodies.xml")
let $csv := element csv {
for $c in $f//r
for $a in $c/anno/entry
let $b := $c/note/entry
let $l := $c/label/entry
return element r { $a , $b , $l }
}
return csv:serialize($csv)