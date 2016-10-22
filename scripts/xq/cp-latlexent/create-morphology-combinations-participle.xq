declare variable $tenses :=  map { "ppa" : "praesens activum", "ppd": "praesens deponens", "rpp": "perfectum passivum", "rpd": "perfectum deponens", "fpa": "futurum activum", "fpd" : "futurum deponens" };
declare variable $number := map {"s": "singularis", "p" : "pluralis"};
declare variable $gender := map {"m": "masculinum", "f": "femininum", "n": "neutrum"};
declare variable $cases := map {
  "n": "nominativus",
"g": "genitivus",
"d": "dativus",
"a": "accusativus",
"v": "vocativus",
"b": "ablativus"
};

let $p1 := element m {
for $tense in map:keys($tenses)
for $num in ("s", "p")
for $gend in ("m", "f", "n")
for $case in ("n", "g", "d", "a", "v", "b")
return element p { "v-" || $num || $tense || $gend || $case || '-,"participium, ' || map:get($tenses, $tense) || ", " || map:get($number, $num) || ", " || map:get($gender, $gend) || ", " || map:get($cases, $case) || '"' }
}


for $c in $p1//p
let $id := replace(generate-id($c), "id", "")
return "urn:cite:croala:latmorph.morph." || $id || ".1," || $c