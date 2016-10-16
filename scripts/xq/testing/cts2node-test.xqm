module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../xqm/croalacite.xqm';

(: check whether necessary dbs are present :)

declare %unit:test function test:find-dbs() {
  for $dbs in ("cp-2-texts", "cp-cts-urns", "cp-cite-urns", "cp-loci", "cp-aetates", "cp-latlexent", "cp-croala-latlexents", "cp-latmorph")
  return unit:assert(db:info($dbs))
};

(: check whether a CTS URN is valid for CroALa :)

declare %unit:test function test:valid-cts() {
  let $results :=
  for $cts in ("urn:cts:croala:crije01.croala789994.croala-lat2w:front1.div1.opener1.s1.w7", "urn:cts:croala:crije01.croala789994.croala-lat2w", "urn:cts:croala:crije01.croala789994.croala-lat2w:", "urn:cts:croala:", "nešto", ())
  return cite:validate-cts($cts)
  return unit:assert-equals($results, (true(), true(), false(), false(), false()))
};

(: check whether a CTS or a CITE URN exists in our databases :)

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
  let $definition := "Rome, the mother city"
  return unit:assert-equals(
    for $tr in cite:geturn($urn)//tbody[parent::table]/tr[td[1]/string()[.=$urn]]
    return $tr/td/string(), ($urn, $label, $definition))
};

declare %unit:test function test:retrieve-citeurnmorph() {
  let $urn := "urn:cite:croala:latmorph.morph.143.1"
  let $label := "n-s---nnc"
  let $definition := "adiectivum, singularis, neutrum, nominativus, comparativus"
  return unit:assert-equals(
    for $tr in cite:geturn($urn)//tbody[parent::table]/tr[td[1]/string()[.=$urn]]
    return $tr/td/string(), ($urn, $label, $definition))
};

declare %unit:test function test:citeurn-croala-latlexent() {
  let $urn := "urn:cite:croala:latlexent.lex61578.1"
  let $label := "Bossina"
  let $definition := "Name of a state in East-Central Europe, Bosnia (Bosna)."
  return unit:assert-equals(
    for $tr in cite:geturn($urn)//tbody[parent::table]/tr[td[1]/string()[.=$urn]]
    return $tr/td/string(), ($urn, $label, $definition))
};

declare %unit:test function test:retrieve-citeurn-thead() {
  let $urn := "urn:cite:perseus:latlexent.lex7232.1"
  let $urnhead := "URN"
  let $label := "Name"
  let $definition := "Short definition"
  return unit:assert-equals(
    for $tr in cite:geturn($urn)//thead[parent::table]/tr[1]
    return $tr/td/string(), ($urnhead, $label, $definition))
};

declare %unit:test function test:ask-name() {
  let $urn := "urn:cite:perseus:latlexent.lex7232.1"
  let $label := "Roma"
  let $definition := "Rome, the mother city"
  return unit:assert-equals(
    for $tr in cite:queryname($label)//tbody[parent::table]/tr[td[1]/string()[.=$urn]]
    return $tr/td/string(), ($urn, $label, $definition))
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
    for $tr in cite:queryname($label)//tbody[parent::table]/tr[td[1]/string()[.=$urn]]
    return $tr/td/string(), ($urn, $label, $definition))
};