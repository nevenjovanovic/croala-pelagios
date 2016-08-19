(: from a list, add place names by renaming nodes :)
(: in tubero-commentarii :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
for $nonnames in (
  (:  "Boemorum",
"Dacico",
"Drauo",
"Europeae",
"Euxino",
"Gothos",
"Latio",
"Pesto",
"Polonorumque",
"Raxanos",
"Rhaxanorum",
"Rhipheos",
"Sarmatiae",
"Slauenos",
"Vistulaque",
"Boemiaeque",
"Boemici",
"Bohemiae",
"Bosinensium",
"Bossinensium",
"Circumistranas",
"Francorum",
"Italicae",
"Italicam",
"Quinqueeclesiarum",
"Tribuniensium",
"Varanensem",
"Visegradiensis", 
"Belgicae",
"Galliae",
"Citeriorem",
"Budensemque",
"Transistrana",
"Regiam",
"Superior",
"Nouam" :)
"Galliis",
"Galliisque"
)
for $n in db:open("tubero-commentarii")//*:w[not(@ana) and text() contains text { $nonnames } using case sensitive]
let $newn := replace($n/@n, 'w', 'placeName')
let $ana := "estlocusX"
return replace node $n with element placeName {
  attribute ana {$ana},
  attribute n {$newn},
  $nonnames
}