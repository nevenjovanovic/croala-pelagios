module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../xqm/croalacite.xqm';
import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../xqm/croalapelagios.xqm';

(: Do we have a cp-cite-morphs db? :)
declare %unit:test function test:find-dbs() {
  unit:assert(db:exists("cp-cite-morphs"))
};
(: Do we have CITE annotations there? :)
declare %unit:test function test:find-morphs-records() {
  unit:assert(collection("cp-cite-morphs")//record[parent::csv]/entry)
};
(: Function: retrieve all CITE morphological annotations from the db :)
declare %unit:test function test:retrieve-morphs-records() {
  unit:assert(cite:getmorphanno()//entry[parent::record])
};
(: Function: display matches for first letters with morphological annotations :)
(: Function: display CITE URN, form, morphological code, value of code :)
declare %unit:test function test:retrieve-morphs-table() {
  let $csv := cite:getmorphanno()
  return unit:assert(
    cite:getmorphtable($csv)//tr[parent::tbody]/td[2][text()="Abduam"]
  )
};
(: There are no empty td[3] returned :)
(: Ordered by description, alphabetically :)
declare %unit:test function test:no-empty-td3() {
  let $csv := cite:getmorphanno()
  return unit:assert(
    cite:getmorphtable($csv)//tr[1][parent::tbody]/td[3][not(.="")]
  )
};

(: First cell contains a element, href leads to CTS URN :)
declare %unit:test function test:link-to-cts() {
  let $csv := cite:getmorphanno()
  let $citeurn := "urn:cite:croala:loci.ana.999038"
  let $link := "http://croala.ffzg.unizg.hr/basex/ctsp/urn:cts:croala:bunic02.croala1761880.croala-lat2w:body.div3.l187.w2" 
  return unit:assert(
    cite:getmorphtable($csv)//tr[parent::tbody]/td[1]/a[@href=$link and text()=$citeurn]
  )
};

declare %unit:test function test:link-to-cite() {
  let $csv := cite:getmorphanno()
  let $citeurn := "nomen, singularis, femininum, accusativus"
  let $link := "http://croala.ffzg.unizg.hr/basex/cite/urn:cite:croala:latmorph.morph.1.1" 
  return unit:assert(
    cite:getmorphtable($csv)//tr[parent::tbody]/td[3]/a[@href=$link and text()=$citeurn]
  )
};

(: There is a page at croala.ffzg.unizg.basex/cp/cp-morph :)

declare %unit:test function test:open-cpmorph-url() {
  let $url := "http://croala.ffzg.unizg.hr/basex/cp/cp-morph"
  return unit:assert(
    doc($url)
  )
};

(: On the page there is a table with a "cp-morph" id :)

declare %unit:test function test:find-cpmorph-url-table() {
  let $url := "http://croala.ffzg.unizg.hr/basex/cp/cp-morph"
  return unit:assert(
    doc($url)//table[@id="cp-morph"]
  )
};

(: In the table there is a row with certain values :)
declare %unit:test function test:find-cpmorph-url-row() {
  let $url := "http://croala.ffzg.unizg.hr/basex/cp/cp-morph"
  let $citeurn := "nomen, singularis, femininum, accusativus"
  let $link := "http://croala.ffzg.unizg.hr/basex/cite/urn:cite:croala:latmorph.morph.1.1"
  return unit:assert(
    doc($url)//table[@id="cp-morph"]/tbody/tr/td[3]/a[@href=$link and text()=$citeurn]
  )
};