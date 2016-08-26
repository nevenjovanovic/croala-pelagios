(: call external rdf records to get name labels :)
(: for Wikidata and Pleiades :)
declare function local:pleiades($url){
  http:send-request(<http:request method='get'><http:header name="User-Agent" value="Opera"/></http:request>, $url)//*:primaryTopicOf/*/*:title
};
declare function local:wikidata($url){
  http:send-request(<http:request method='get'><http:header name="User-Agent" value="Opera"/></http:request>, $url)/*/*:Description[2]/*:label[@xml:lang='en']
};
(: use local file produced by cite-group-by-annotation-text.xq :)
copy $idx := doc("/home/neven/rad/croala-pelagios/csv/tuberoidx-placeids.xml")
modify ( 
for $p in $idx//place
order by $p
return insert node if (starts-with($p, 'http://pleiades')) then let $adr := data($p) || "/rdf" return element label { data(local:pleiades($adr)) } 
else if (starts-with($p, 'https://www.wikidata')) then let $adr := replace(data($p), 'wiki/', 'wiki/Special:EntityData/') || ".rdf" return element label { data(local:wikidata($adr)) }
else() after $p
)
return $idx