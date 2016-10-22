declare variable $tenses :=  map { "p" : "praesens", "r": "perfectum", "f": "futurum" };
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
for $tense in ("p", "r", "f")
for $num in ("s", "p")
for $gend in ("m", "f", "n")
for $case in ("n", "g", "d", "a", "v", "b")
return element p { "v-" || $num || $tense || "p" || "." || $gend || $case || '-,"participium, ' || map:get($tenses, $tense) || ", " || map:get($number, $num) || ", " || map:get($gender, $gend) || ", " || map:get($cases, $case) || '"' }
}
let $combos := element m {
for $p2 in $p1/p
let $act := ("a", "d")
let $pas := ("p", "d")
return if (matches($p2, '^v-.[pf]')) then
  for $item in $act return element n { replace($p2, '\.', $item) }
else for $item in $pas return element n { replace($p2, '\.', $item) }
}
for $c in $combos//n
let $id := replace(generate-id($c), "id", "")
let $cd := replace($c, '...d.*participium,', '$0 deponens,')
return "urn:cite:croala:latmorph.morph." || $id || ".1," || $cd