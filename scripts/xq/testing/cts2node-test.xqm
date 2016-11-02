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
    "urn:cite:perseus:latlexent.lex7935.1", 
    "urn:cite:croala:latlexent.lex35575.1", 
    "urn:cite:croala:loci.ana.435", 
    "urn:cite:croala:nesto.ana.123", 
    "urn:cite:croala:loci.ana.435.2", 
    "urn:cts:croala:nikolamodr01.croala1394919.croala-lat2loci:body1.head1.s1.w9", 
    "urn:cts:croala:neven01.croala12345678.croala-lat2loci:body1.head1.s1.w9", 
    "Roma", 
    "nešto", 
    ()
  )
  return cite:urn-exists($cts)
  return unit:assert-equals($results, (
    element entry { "Steganos" }, 
    element entry { "Adriaticum"}, 
    <w n="urn:cts:croala:nikolamodr01.croala1394919.croala-lat2loci:body1.head1.s1.w9" citeurn="urn:cite:croala:loci.ana.435" citeaex="urn:cts:croala:nikolamodr01.croala1394919.croala-lat2loci.lexis:body1.head1.s1.w9">sancti</w>,
    "URN deest in collectionibus nostris." ,    
    "URN deest in collectionibus nostris.", 
    "1035767",
    "URN deest in collectionibus nostris.", 
    "urn:cite:croala:loci.ana-nota.5214", 
    "URN deest in collectionibus nostris."))
};

(: given CTS value of @n in cp-placename-idx, open node in cp-2-texts, display parent of node, mark node with a special element :)

(: given CTS value of @n in cp-placename-idx, return @cite value from cp-cite-urns, format as a hyperlink :)

(: given CITE value of @cite from cp-cite-urns, return everything from other dbs connected with that CITE value, format as rows in a table :)

(: Retrieve a specific CITE URN from the cp-latlexent db :)
(: Heading: "CroALa Textgroups in $dbname, $date" :)
(: Fields: label, CTS URN - linking to list of work CTSs, count of available texts :)
(:~ Retrieve a CTS URN from a tbody/tr/td sequence, a list of CTS URNs in croala-cts-1 db. :)
declare %unit:test function test:retrieve-citeurn() {
  let $urn := "urn:cite:perseus:latlexent.lex7232.1"
  let $label := "Roma"
  return unit:assert(cite:geturn($urn)//tbody/tr[td[1]/input/@value=$urn]/td[2][text()=$label])
};

declare %unit:test function test:retrieve-citeurnmorph() {
  let $urn := "urn:cite:croala:latmorph.morph.143.1"
  let $label := "a-s---nnc"
  let $definition := "adiectivum, singularis, neutrum, nominativus, comparativus"
  return unit:assert(
    cite:geturn($urn)//tbody[parent::table]/tr[td[1]/input/@value=$urn]/td[2][.=$label])
};

declare %unit:test function test:citeurn-croala-latlexent() {
  let $urn := "urn:cite:croala:latlexent.lex61578.1"
  let $label := "Bossina"
  let $definition := "Name of a state in East-Central Europe, Bosnia (Bosna)."
  return unit:assert-equals(
    for $tr in cite:geturn($urn)//tbody[parent::table]/tr[td[1]/input[@value=$urn]]
    return $tr/td[2]/string(), $label)
};

declare %unit:test function test:retrieve-citeurn-thead() {
  let $urn := "urn:cite:perseus:latlexent.lex7232.1"
  let $urnhead := "URN"
  let $label := "Name"
  let $definition := "Short definition"
  return unit:assert-equals(
    let $tr := cite:geturn($urn)//thead[parent::table]/tr
    return $tr/td/string(), ($urnhead, $label, $definition))
};

declare %unit:test function test:ask-name() {
  let $urn := "urn:cite:perseus:latlexent.lex7232.1"
  let $label := "Roma"
  let $definition := "Rome, the mother city"
  return unit:assert-equals(
    for $tr in cite:queryname($label)//tbody[parent::table]/tr[td[1]/input[@value=$urn]]
    return $tr/td[2]/string(), $label)
};

declare %unit:test function test:ask-name-thead() {
  let $name := "Rom"
  let $urnhead := "URN"
  let $label := "Name"
  let $definition := "Short definition"
  return unit:assert-equals(
    for $tr in cite:queryname($name)//thead[parent::table]/tr[1]
    return $tr/td/string(), ($urnhead, $label, $definition))
};


declare %unit:test function test:name-croala-latlexent() {
  let $urn := "urn:cite:croala:latlexent.lex32295.1"
  let $label := "Dacicum"
  let $definition := "Name of the province Dacia."
  return unit:assert-equals(
    for $tr in cite:queryname($label)//tbody[parent::table]/tr[td[1]/input[@value=$urn]]
    return $tr/td[3]/string(), $definition)
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