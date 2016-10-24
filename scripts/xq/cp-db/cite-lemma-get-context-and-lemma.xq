(: test whether cp-cite-lemmata connects the right information :)
(: use CTS URN to retrieve context from cp-2-texts :)
(: use CITE Body URN to retrieve lemma :)
(: control with word and lemma :)
declare function local:openid ($nodeid) {
  normalize-space(data(db:open-id("cp-2-texts", $nodeid/@xml:id)/..))
};
for $r in collection("cp-cite-lemmata")//record
let $urn := $r/entry[1]/string()
let $nodeid := collection("cp-cts-urns")//w[@n=$urn]
let $context := local:openid($nodeid)
let $cite := $r/entry[3]
let $lemma := $r/entry[4]
let $citelemma := $r/entry[5]
let $citelemmalabel := collection("cp-latlexents")//record[entry[1]=$citelemma]
return $citelemmalabel