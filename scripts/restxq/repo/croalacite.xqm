module namespace cite = "http://croala.ffzg.unizg.hr/cite";
import module namespace functx = "http://www.functx.com" at "functx.xqm";
declare namespace ti = "http://chs.harvard.edu/xmlns/cts";


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
for $r in collection("cp-latlexent")//record[matches(entry[2]/string(), '^[A-Z]')]
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
  let $list := collection("cp-latlexent")//record[matches(entry[2]/string(), '^[A-Z]')]
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