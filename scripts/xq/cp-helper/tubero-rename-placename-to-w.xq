declare namespace tei="http://www.tei-c.org/ns/1.0";
for $p in //*:text//*:placeName
return rename node $p as 'tei:w'