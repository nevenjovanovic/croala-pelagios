(: change name of fields :)

let $csv := element csv {
for $doc in collection("cp-croala-latlexents")//w
let $entries :=
for $string in $doc/*/string() return element entry { $string }
return element record { $entries }
}
return file:write("/home/neven/rad/croala-pelagios/csv/cp-croala-latlexents.xml", $csv)