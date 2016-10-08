module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace refs = "http://www.refs.com" at '../../xqm/refs.xqm';

(: test whether files have a /TEI/teiHeader/encodingDesc/refsDecl/@n="CTS":)
declare %unit:test function test:refsDecl() {
  unit:assert(
    refs:addrefs("refsDeclproba")/*:TEI/*:teiHeader/*:encodingDesc/*:refsDecl[@n="CTS"] )
};

(: test whether the refsDecl has as many cRefPatterns as there are levels :)

(: are the cRefPattern elements ordered from deepest to the shallowest? :)

(: does the match pattern contain (\w+) regexp? :)

(: does the replacementPattern contain $[1-9] which represents depth of a level? :)

(: is there a cRefPattern/@n attribute with a lowercase value? :)

(: is there a paragraph translating matchPattern and level hierarchy into human readable information? :)

