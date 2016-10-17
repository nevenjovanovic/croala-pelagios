let $r := collection("cp-croala-latlexents")
return file:write("/home/neven/rad/croala-pelagios/csv/cp-croala-latlexents-10-10.csv", csv:serialize($r/csv))