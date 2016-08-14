(: from a list, add place names by renaming nodes :)
(: in tubero-commentarii :)
declare default element namespace "http://www.tei-c.org/ns/1.0";
for $nonnames in (
  "Boemorum",
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
"Vistulaque"
)
for $n in db:open("tubero-commentarii")//*:w[text() contains text { $nonnames } using case sensitive]
return rename node $n as 'placeName'