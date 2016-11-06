module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../xqm/croalacite.xqm';
import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../xqm/croalapelagios.xqm';

(: check whether necessary dbs are present :)

declare %unit:test function test:find-dbs() {
  for $dbs in ("cp-2-texts", "cp-cts-urns", "cp-cite-urns", "cp-loci", "cp-aetates", "cp-latlexent", "cp-croala-latlexents", "cp-latmorph")
  return unit:assert(db:exists($dbs), true())
};

(: check whether a CTS URN is valid for CroALa :)

declare %unit:test function test:valid-cts() {
  let $results :=
  for $cts in ("urn:cts:croala:crije01.croala789994.croala-lat2w:front1.div1.opener1.s1.w7", "urn:cts:croala:crije01.croala789994.croala-lat2w", "urn:cts:croala:crije01.croala789994.croala-lat2w:", "urn:cts:croala:", "nešto", ())
  return cite:validate-cts($cts)
  return unit:assert-equals($results, (true(), true(), false(), false(), false()))
};

(: check whether a CITE URN is valid for CroALa :)

declare %unit:test function test:valid-cite() {
  let $results :=
  for $cts in ("urn:cite:croala:loci.ana.435", "urn:cite:croala:loci.ana.435.2", "urn:cts:croala:nikolamodr01.croala1394919.croala-lat2loci:body1.head1.s1.w9", "Roma", "nešto", ())
  return cite:validate-cite($cts)
  return unit:assert-equals($results, (true(), true(), false(), true(), false()))
};

(: check whether a CTS or a CITE URN exists in our databases :)
declare %unit:test function test:urn-exists() {
  let $results :=
  for $cts in (
    "urn:cts:croala:nikolamodr01.croala1394919.croala-lat2loci:body1.head1.s1.w9", 
    "urn:cts:croala:neven01.croala12345678.croala-lat2loci:body1.head1.s1.w9", 
    "Roma", 
    "nešto", 
    ()
  )
  return cite:urn-exists($cts)
  return unit:assert-equals($results, ( 
    "1035767",
    "URN deest in collectionibus nostris.", 
    "urn:cite:croala:loci.ana-nota.5214", 
    "URN deest in collectionibus nostris."))
};

declare %unit:test function test:openctsurn () {
  let $ctsadr := "urn:cts:croala:crije02.croala292491.croala-lat2w:body.div1.div1.l196.w3"
  return unit:assert(cp:openurn ($ctsadr))
};

declare %unit:test function test:openctsurn-fail () {
  let $ctsadr := "urn:cts:croala:crije02.croala292491.croala-lat2w:body.div1.div1.l196"
  return unit:assert(cp:openurn ($ctsadr))
};

(: for each record in cp-cts-urns, return node in cp-2-texts; compare text() with td2/text() :)
declare %unit:test function test:open-each-cts () {
  for $c in collection("cp-cts-urns")//w
  let $ctsadr := $c/@n
  let $text := $c/text()
  return unit:assert-equals(cp:openurn ($ctsadr)//td[2]/text(), $text)
};