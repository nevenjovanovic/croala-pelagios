(: create a db with contexts of CTS URNs :)
import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../xqm/croalapelagios.xqm';

(: create context for CTS URN :)
let $ctscontext := element list {
for $cite in collection("cp-cts-urns")//*:w
let $cts := $cite/@n
let $label := $cite/text()
let $context := cp:openurn($cts)
return element cite {
  $cts,
  attribute label { $label },
  $context
}
}
return db:create("cp-cts-contexts", $ctscontext, "cp-cts-contexts.xml", map {'chop': false(), 'ftindex' : true() , 'autooptimize' : true() , 'intparse' : true() })