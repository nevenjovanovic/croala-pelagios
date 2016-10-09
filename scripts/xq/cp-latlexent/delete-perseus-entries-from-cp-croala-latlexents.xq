(: from cp-croala-latlexents remove urn:cite:perseus:latlexent nodes :)
for $w in collection("cp-croala-latlexents")//w
where $w/citebody[matches(.,"urn:cite:perseus:")]
return delete node $w