for $d in db:open("tubero-commentarii","tubero-commentarii-rezar-p-s-w-placename-n.xml")//*:body/*:div[matches(@n,'[0-9]+')]
let $nvalue := $d/name() || data($d/@n)
return replace value of node $d/@n with $nvalue