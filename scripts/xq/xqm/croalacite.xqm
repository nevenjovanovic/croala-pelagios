module namespace cite = "http://croala.ffzg.unizg.hr/cite";
import module namespace functx = "http://www.functx.com" at "functx.xqm";
declare namespace ti = "http://chs.harvard.edu/xmlns/cts";

declare function cite:validate-cts($cts){
  let $result :=
  if (not(ends-with($cts, ":"))) then
    if (matches($cts, "urn:cts:croala:[a-z0-9.\-]+:[a-z0-9.\-]+$")) then true()
    else if  (matches($cts, "urn:cts:croala:[a-z0-9.\-]+$")) then true()
    else false()
  else false()
  return $result
};


declare function cite:geturn($urn) {
  element table {
    element thead {
      element tr {
        element td { "URN"},
        element td { "Name"},
        element td { "Short definition"}
      }
    },
    element tbody {
let $dbs := (collection("cp-latlexent"), collection("cp-latmorph"), collection("cp-croala-latlexents"))
for $r in $dbs//record
where $r/entry[1][string()=$urn]
return element tr {
  element td { $r/entry[1]/string() },
  element td { $r/entry[2]/string() },
  element td { $r/entry[3]/string() }
}
}
}
};

declare function cite:queryname ($q) {
  let $dbs := (collection("cp-latlexent"), collection("cp-croala-latlexents"))
  let $list := $dbs//record
  let $result := $list[entry[2][matches(string(), '^' || $q )]]
  return if ($result) then
  element table {
    element thead {
      element tr {
        element td { "URN"},
        element td { "Name"},
        element td { "Short definition"}
      }
    },
    element tbody {

for $r in $result
return element tr {
  element td { $r/entry[1]/string() },
  element td { $r/entry[2]/string() },
  element td { $r/entry[3]/string() }
}
}
}
else element p { "Nomen deest in collectionibus nostris." }
};