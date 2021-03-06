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
    for $tr in cite:geturn($urn)//tbody[parent::table]/tr[td[1][input/@value=$urn]]
    return $tr/td[2]/string(), ($label))
};

declare %unit:test function test:retrieve-citeurnmorph() {
  let $urn := "urn:cite:croala:latmorph.morph.143.1"
  let $label := "a-s---nnc"
  let $definition := "adiectivum, singularis, neutrum, nominativus, comparativus"
  return unit:assert-equals(
    for $tr in cite:geturn($urn)//tbody[parent::table]/tr[td[1][input/@value=$urn]]
    return $tr/td[2]/string(), ($label))
};

declare %unit:test function test:citeurn-croala-latlexent() {
  let $urn := "urn:cite:croala:latlexent.lex61578.1"
  let $label := "Bossina"
  let $definition := "Name of a state in East-Central Europe, Bosnia (Bosna)."
  return unit:assert-equals(
    for $tr in cite:geturn($urn)//tbody[parent::table]/tr[td[1][input/@value=$urn]]
    return $tr[td[1]/input/@value=$urn]/td[2]/string(), ($label))
};

(: are we displaying a page at basex/cp/cp-lemmata :)
(: is there a function in the croalacite.xqm module? :)
(: is there a table with CITE latlexent URNs? :)
(: can the table be sorted? :)
(: can we retrieve a specific entry from the table? :)

declare %unit:test function test:cp-lemmata-exists (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cp/cp-lemmata")
  return unit:assert($doc//blockquote/div/table[@id="lemmata" and @class="table-striped  table-hover table-centered"]/tbody/tr[492][parent::tbody and td[1]/a/@href]/td[6][text()])
};

declare %unit:test function test:cite-lemmmata-exists(){
  let $r := cite:getlemmata()
  return unit:assert(cite:listlemmata($r)//tr[492][parent::tbody and td[1]/a/@href]/td[6][text()])
};