(: CroALa Pelagios :)
(: search for a lemma in our collection :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../../repo/croalacite.xqm';

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Verbum in CroALa';
declare variable $content := "Lemma used for annotating, identified by a CITE URN.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar, lemma, lexicon, lexical analysis";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("citelemma/{$urn}")
  %output:method(
  "xhtml"
)
  %output:omit-xml-declaration(
  "no"
)
  %output:doctype-public(
  "-//W3C//DTD XHTML 1.0 Transitional//EN"
)
  %output:doctype-system(
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
)
  function page:croalapelagioscitelemma($urn)
{
  (: HTML template starts here :)

<html>
{ cp:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Index locorum in <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://commons.pelagios.org/">Pelagii</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a> and the <a href="https://github.com/nevenjovanovic/croala-pelagios/wiki#the-team">CroALa-Pelagios team</a>.</p>
<p>Lemma identificatur ope indiculi CITE URN.</p>
<p>Functio nominatur: {rest:uri()}.</p>
<p>Iconem <span class="glyphicon glyphicon-copy" aria-hidden="true"></span> preme ut copiam indiculi CITE URN accipias.</p>
</div>
<div class="col-md-6">
{croala:infodb('cp-latlexents')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">

{ cite:queryname($urn) }

</blockquote>
     <p/>
     </div>
<hr/>
{ cp:footerserver() }
<script type="text/javascript" src="/basex/static/dist/js/clipboard2.js"></script>
</body>
</html>
};

return
