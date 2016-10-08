module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../xqm/croalacite.xqm';

   

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