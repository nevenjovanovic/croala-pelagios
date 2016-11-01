let $values := collection("cp-latlexents")//record/entry[1]
for $duplicate in $values[index-of($values, .)[2]]
return $duplicate