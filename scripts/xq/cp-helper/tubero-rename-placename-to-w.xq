declare default element namespace "http://www.tei-c.org/ns/1.0";
for $p in collection("cp-tokenize")//*:text//*:placeName
return rename node $p as 'w'