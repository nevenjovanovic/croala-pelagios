for $p in //*:text//*:placeName[not(@ana)]
return insert node attribute ana {"estlocusX" } into $p