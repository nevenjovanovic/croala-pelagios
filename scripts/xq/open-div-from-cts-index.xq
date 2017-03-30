declare function local:wordtree($word, $ctsname) {
let $tree := string-join(data($word/ancestor-or-self::*[@n]/@n),'.')
return attribute href { 
element ctsurn { "http://croala.ffzg.unizg.hr/basex/ctsp/" || substring-before($ctsname, ":") || ":" || $tree } }
};

declare function local:plus($div, $ctsdiv){
  let $names := ("l", "s")
  for $l in $div//*[name()=$names]
  let $wnames := ("w", "tei:w", "name")
let $lines := for $w in $l/*[name()=$wnames]
let $ctsurn := local:wordtree($w, $ctsdiv)
return if ($w/@ana) then element a { $ctsurn , "+" } else "-"
return element p { $lines }
};

declare function local:openctsdiv($ctsdiv){
  let $divnode := collection("cp-div-cts")//record[ctsurn=$ctsdiv]
  let $pre := $divnode/@xml:id
  return db:open-id("cp-2-texts", $pre)
};
for $ctsdiv in ("urn:cts:croala:crije02.croala292491.croala-lat2w:body.div1.div1", "urn:cts:croala:crije02.croala292491.croala-lat2w:body.div1")
return local:plus(local:openctsdiv($ctsdiv), $ctsdiv)