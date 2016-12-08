(: CroALa Pelagios :)
(: List available CITE Period URNs :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'CITE URN indiculus: aetates in CroALa';
declare variable $content := "Display available CITE Object URNs of period identifications.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar, place name, URN";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cp-aetates")
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
  function page:croalapellistaetates()
{
  (: HTML template starts here :)

<html>
{ cp:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Locus in <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://commons.pelagios.org/">Pelagii</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a> and the <a href="https://github.com/nevenjovanovic/croala-pelagios/wiki#the-team">CroALa-Pelagios team</a>.</p>
<p>CITE URN: aetates in collectione.</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{croala:infodb('cp-aetates')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	{cp:listciteperiods()}
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




