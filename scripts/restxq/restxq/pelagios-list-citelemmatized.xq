(: CroALa Pelagios :)
(: List available CITE URNs with links to nodes and CTS URNs :)
(: For CTS URNs with lemmatizing annotations :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at "../../repo/croalacite.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'CITE URN indiculi; lemmata verborum in CroALa';
declare variable $content := "Display available CITE URNs of lemmatized words from our texts.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar, place name, URN, lemmatization, lemma";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cp/cp-lemmata")
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
  function page:pelaglistciteurnlemmata()
{
  (: HTML template starts here :)

<html>
{ cite:htmlheadtsorter($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Locus in <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://commons.pelagios.org/">Pelagii</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a></p>
<p>Indiculi CITE URN verborum lemmatibus notatorum.</p>
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
<table id="lemmata" class="table-striped  table-hover table-centered sort">
	<thead>
	<tr>
  <th>Annotationis CITE URN</th>
  <th>Verbum</th>
  <th>Lemma</th>
  <th>Lemmatis CITE URN</th>

  </tr>
	</thead>
  <!-- function here -->
{ cite:listlemmata() }
  </table>
  
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




