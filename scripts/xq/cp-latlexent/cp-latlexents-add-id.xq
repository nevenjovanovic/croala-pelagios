for $r in collection("cp-latlexents")//record
let $id := generate-id($r)
let $citeurn2 := attribute citeid { replace($id, 'id', 'lex') }
return insert node $citeurn2 into $r/uri