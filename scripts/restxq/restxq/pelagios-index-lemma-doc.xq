(: CroALa Pelagios :)
(: List total counts of lemmata and lemmatized words with links to indices of individual lemmata and their occurrences :)

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at "../../repo/croalacite.xqm";
import module namespace functx = "http://www.functx.com" at "../../repo/functx.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Index verbi in CroALa Pelagios';
declare variable $content := "Display list of occurrences for a lemma in document, with links to context.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar, place name, URN, lemmatization, lemma";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cpciteindex/{$cts}/{$lemma_cite}")
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
  function page:pelagindexlemmadoc($cts, $lemma_cite)
{
  (: HTML template starts here :)

<html>
{ cp:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Index verbi {$lemma_cite} in textu {$cts}. <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://commons.pelagios.org/">Pelagii</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a> and the <a href="https://github.com/nevenjovanovic/croala-pelagios/wiki#the-team">CroALa-Pelagios team</a>.</p>
<p>Occurrences of word forms in the document. Links lead to basic context.</p>
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
{ cp:index_lemmata($cts, $lemma_cite) }
  
     </div>
</blockquote>
     <p/>
     </div>
<hr/>
{ cp:footerserver() }
</body>
</html>
};

return




