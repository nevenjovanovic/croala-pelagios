(: CroALa Pelagios :)
(: List available CITE URNs of lemmata with links to indices of occurrences :)

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at "../../repo/croalacite.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Lemmata locorum in CroALa';
declare variable $content := "Display available lemmas and CITE URNs of annotated place names from our texts, with links to indices of individual occurrences.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar, place name, URN, lemmatization, lemma";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cp-cite-lemmata/{$urn}")
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
  function page:pelaglistcitelemmatadoc($urn)
{
  (: HTML template starts here :)

<html>
{ cp:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Index lemmatum. <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://commons.pelagios.org/">Pelagii</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a> and the <a href="https://github.com/nevenjovanovic/croala-pelagios/wiki#the-team">CroALa-Pelagios team</a>.</p>
<p>Lemmatized words and frequency of their occurrences in {$urn}. Links lead to a CITE annotation for each lemma.</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{croala:infodb('cp-cite-lemmata')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	<div class="table-responsive">

  <!-- function here -->
{ cp:group_lemmata($urn) }
  
     </div>
</blockquote>
     <p/>
     </div>
<hr/>
{ croala:footerserver() }
</body>
</html>
};

return




