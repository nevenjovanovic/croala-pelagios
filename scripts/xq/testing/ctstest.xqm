module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cts = "http://croala.ffzg.unizg.hr/cts" at '../../xqm/croalacts.xqm';

   

(: Retrieve a list of available textgroups from the croala-cts-1 db :)
(: Heading: "CroALa Textgroups in $dbname, $date" :)
(: Fields: label, CTS URN - linking to list of work CTSs, count of available texts :)
(:~ Retrieve a CTS URN from a tbody/tr/td sequence, a list of CTS URNs in croala-cts-1 db. :)
declare %unit:test %unit:ignore function test:retrieve-ctsurn-as-link() {
  let $urn := "urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div1.l6"
  let $href := "http://croala.ffzg.unizg.hr/basex/cts/" || $urn
  return unit:assert-equals(cts:getcapabilities()//tr/td/a[@href=$href]/string()[.=$urn], $urn)
};

declare %unit:test function test:retrieve-textgroups-caption() {
  let $dbname := "croala-cts-1"
  let $date := "2016-10-03T14:43:08.000Z"
  let $head := "Textgroups available in CroALa db " || $dbname || ", updated on " || $date
  return unit:assert-equals(cts:gettextgroups()//caption/string(), $head)
};

declare %unit:test %unit:ignore function test:retrieve-textgroups-heading() {
  let $label := "Label"
  let $ctsurnlabel := "CTS URN"
  let $count := "Available works"
  return unit:assert-equals(for $ t in cts:gettextgroups()//thead/tr/td return $t/string(), ($label, $ctsurnlabel, $count))
};


declare %unit:test function test:retrieve-textgroups-urn() {
  let $urn := element td {
    element a { 
    attribute href {
      "http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/urn:cts:croala:sivri01"
    } , "urn:cts:croala:sivri01" } }
  let $label := element td { "Sivrić, Antun" }
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/" || $urn
  let $count := element td { element a { 
  attribute href { $editionhref } , 
  "1" } }
  let $href := "http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/" || $urn
  return unit:assert-equals(
    for $r in cts:gettextgroups()//tbody/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r, ($label , $urn, $count))
};

declare %unit:test function test:retrieve-works-caption() {
  let $dbname := "croala-cts-1"
  let $date := "2016-10-03T14:43:08.000Z"
  let $head := "urn:cts:croala:sivri01: works available in CroALa db " || $dbname || ", updated on " || $date
  return unit:assert-equals(cts:getworks("urn:cts:croala:sivri01")//caption[parent::*:table[@class="table-striped table-hover table-centered"]]/string(), $head)
};

declare %unit:test function test:retrieve-works-headrow() {
  let $label := "Label"
  let $ctsurnlabel := "CTS URN"
  let $count := "Editions available"
  return unit:assert-equals(for $ t in cts:getworks("urn:cts:croala:sivri01")//thead[parent::*:table[@class="table-striped table-hover table-centered"]]/tr/td return $t/string(), ($label, $ctsurnlabel, $count))
};

declare %unit:test function test:retrieve-works-urn() {
  let $urn := element td {
    element a { 
    attribute href {
      "http://croala.ffzg.unizg.hr/basex/ctsopus/urn:cts:croala:sivri01.croala853690"
    } , "urn:cts:croala:sivri01.croala853690" } }
  let $label := element td { "Traduzione latina delle Anacreontiche ... e dei sonetti" }
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctsopus/" || $urn
  let $count := element td { element a { 
  attribute href { $editionhref } , 
  "1" } }
  let $href := "http://croala.ffzg.unizg.hr/basex/ctsopus/" || $urn
return unit:assert-equals(
    for $r in cts:getworks("urn:cts:croala:sivri01")//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r, ($label , $urn, $count))
    (:
    return unit:assert(
    for $r in cts:getworks()//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r)
    :)
};

declare %unit:test function test:retrieve-works-empty() {
unit:assert(
    cts:getworks("index")//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href]]/td)
};

(: Given a URL such as http://croala.ffzg.unizg.hr/basex/ctseditiones/urn:cts:croala:djurdjev02.croala866783 :)
(: retrieve list of editions with number of available nodes :)
(: edition links to a list of nodes :)
(: in the form: http://croala.ffzg.unizg.hr/basex/ctsnodi/urn:cts:croala:djurdjev02.croala866783.edition :)
(: TODO: for each edition, retrieve list of nodes :)

declare %unit:test function test:retrieve-editions-caption() {
  let $dbname := "croala-cts-1"
  let $date := "2016-10-03T14:43:08.000Z"
  let $head := "urn:cts:croala:djurdjev02.croala866783, editions available in CroALa db " || $dbname || ", updated on " || $date
  return unit:assert-equals(cts:geteditions("urn:cts:croala:djurdjev02.croala866783")//caption[parent::*:table[@class="table-striped table-hover table-centered"]]/string(), $head)
};

declare %unit:test function test:retrieve-editions-headrow() {
  let $label := "Label"
  let $ctsurnlabel := "CTS URN"
  let $count := "Nodes available"
  return unit:assert-equals(for $ t in cts:geteditions("urn:cts:croala:djurdjev02.croala866783")//thead[parent::*:table[@class="table-striped table-hover table-centered"]]/tr/td return $t/string(), ($label, $ctsurnlabel, $count))
};

declare %unit:test function test:retrieve-editions-urn() {
  let $urn := element td {
    element a { 
    attribute href {
      "http://croala.ffzg.unizg.hr/basex/ctseditio/urn:cts:croala:sivri01.croala853690.croala-lat1"
    } , "urn:cts:croala:sivri01.croala853690.croala-lat1" } }
  let $label := element td { "Traduzione latina delle Anacreontiche ... e dei sonetti, versione digitale" }
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctseditio/" || $urn
  let $count := element td { element a { 
  attribute href { $editionhref } , 
  "2014" } }
  let $href := "http://croala.ffzg.unizg.hr/basex/ctseditio/" || $urn
return unit:assert-equals(
    for $r in cts:geteditions("urn:cts:croala:sivri01.croala853690")//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r, ($label , $urn, $count))
    (:
    return unit:assert(
    for $r in cts:getworks()//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r)
    :)
};

declare %unit:test function test:retrieve-editions-index() {
unit:assert(
    cts:geteditions("index")//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href]]/td)
};

declare %unit:test function test:retrieve-editions-other() {
  let $string := random:uuid()
  let $message := "URN deest in collectione."
  return unit:assert-equals(
    cts:geteditions($string)//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr/td/string(), $message)
};

(: for an edition CTS URN, return list of available nodes :)
declare %unit:test function test:retrieve-nodes-caption() {
  let $dbname := "croala-cts-1"
  let $date := "2016-10-03T14:43:08.000Z"
  let $head := "Edition urn:cts:croala:djurdjev02.croala866783.croala-lat1; text nodes available in CroALa db " || $dbname || ", updated on " || $date
  return unit:assert-equals(cts:getnodes("urn:cts:croala:djurdjev02.croala866783.croala-lat1")//caption[parent::*:table[@class="table-striped table-hover table-centered"]]/string(), $head)
};

declare %unit:test function test:retrieve-nodes-other() {
  let $string := random:uuid()
  let $message := "CTS URN deest in collectione."
  return unit:assert-equals(
    cts:getnodes($string)//caption[parent::*:table[@class="table-striped table-hover table-centered"]]/string(), $message)
};

declare %unit:test function test:retrieve-nodes-headrow() {
  let $ctsurnlabel := "Nodus CTS URN"
  return unit:assert-equals(for $ t in cts:getnodes("urn:cts:croala:djurdjev02.croala866783.croala-lat1")//thead[parent::*:table[@class="table-striped table-hover table-centered"]]/tr/td[1] return $t/string(), ($ctsurnlabel))
};

declare %unit:test function test:retrieve-nodes-urn() {
  let $nodeurl := "http://croala.ffzg.unizg.hr/basex/cts/urn:cts:croala:adamp01.croala1105795.croala-lat1:text.body.div2"
  let $node := element td {
    element a { 
    attribute href {
      $nodeurl
    } , "urn:cts:croala:adamp01.croala1105795.croala-lat1:text.body.div2" } }
return unit:assert-equals(
    for $r in cts:getnodes("urn:cts:croala:adamp01.croala1105795.croala-lat1")//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr/td[1][a/@href=$nodeurl]/string() return $r, $node/string())
    (:
    return unit:assert(
    for $r in cts:getworks()//tbody[parent::*:table[@class="table-striped table-hover table-centered"]]/tr[td[2]/a[@href=$href]/string()[.=$urn]]/td return $r)
    :)
};

(: given a URL, retrieve passage :)
declare %unit:test function test:retrieve-passage-urn() {
  let $ctsurn := "urn:cts:croala:sivri01.croala853690.croala-lat1:text.body.div2.div6.div2.div2.l6"
  return unit:assert-equals(cts:getpassage($ctsurn)[name()="l"]/string(), "Vel Beronicei (58) verticis alma coma ,")
};

(: what to do for a nonexisting URN :)
(: display message :)
declare %unit:test function test:nonexisting-urn() {
  let $string := random:uuid()
  let $message := "CTS URN deest in collectione."
  return unit:assert-equals(cts:getpassage($string)//string(), $message )
};