(: change n values in name elements with @ana estlocus0 :)
(: to nameX; keep @ana :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
for $i in //*:name[@ana='estlocus0']
where matches($i/@n, 'placeName')
let $ana2 := replace($i/@n, 'placeName', 'name')
return replace value of node $i/@n with $ana2