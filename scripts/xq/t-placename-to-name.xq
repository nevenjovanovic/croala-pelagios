(: rename placename elements with @ana estlocus0 :)
(: to name; keep @ana :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
for $i in //*:placeName[@ana='estlocus0']
return rename node $i as 'name'