declare function local:queryents ($q) {
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
where $r/entry[2][matches(string(), '^' || $q )]
return element tr {
  element td { $r/entry[1] },
  element td { $r/entry[2] },
  element td { $r/entry[3] }
}
}
}
};

local:queryents("Rom")