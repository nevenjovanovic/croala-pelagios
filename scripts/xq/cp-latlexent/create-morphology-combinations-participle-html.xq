declare variable $retro := element li {
    attribute class {"drilldown-back"},
    element a { 
      attribute href { "#"} , 
       element span {
         attribute class {"glyphicon glyphicon-chevron-left"},
         attribute aria-hidden {"true"}
       },
       " Retro" }
  };
  declare variable $porro := 
       element span {
         attribute class {"glyphicon glyphicon-play-circle"},
         attribute aria-hidden {"true"}
       };
declare variable $tenses :=  map { "p" : "Praesens activum", "pd": "Praesens deponens", "r": "Perfectum passivum", "rd": "Perfectum deponens", "f": "Futurum activum", "fd": "Futurum deponens" };
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

let $p1 := element ul {
  attribute class {"drilldown-sub"} ,
  $retro,
for $tense in ("p", "pd", "r", "rd", "f", "fd")
return element li {
  element a {
    attribute href { "#"},
    map:get($tenses, $tense) , " " , $porro
  },
  element ul {
    attribute class {"drilldown-sub"},
    $retro,
for $num in ("s", "p")
return element li {
  element a {
    attribute href { "#"},
    "Numerus " || map:get($number, $num) , " " , $porro
  },
  element ul {
    attribute class {"drilldown-sub"},
    $retro,
for $gend in ("m", "f", "n")
return element li {
  element a {
    attribute href { "#"},
    "Genus " || map:get($gender, $gend) , " " , $porro
  },
  element ul {
    attribute class {"drilldown-sub"},
    $retro,
for $case in ("n", "g", "d", "a", "v", "b")
return element li {
  element a {
    attribute href {"http://croala.ffzg.unizg.hr/basex/cite/urn:cite:croala:latmorph.morph."},
    "Casus " || map:get($cases, $case)
  }
} 
}
}
}
}
}
}
}
return $p1