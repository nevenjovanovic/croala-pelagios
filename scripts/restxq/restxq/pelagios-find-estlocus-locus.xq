(: CroALa Pelagios :)
(: Report the estlocus assertions for an individual doc, display with legend for estlocus values :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'CroALa: locorum qualitatis approbationes';
declare variable $content := "Display assertions of certainty for specific place denotations in the whole CroALa Pelagios corpus.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar, place name, URN, certainty, named entities";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cp-loci-approbatio")
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
  function page:cpestlocuslocus()
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
<p>Annotated certainty of place denotations in the corpus.</p>

<p>Function name: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{croala:infodb('cp-cite-urns')}
</div>
</div>
</div>
<div class="container-fluid">
{ cp:table(("Code", "Certainty level description"), cp:estlocus_info_all()) }
<blockquote class="croala">
<div class="table-responsive">
{ cp:join_locus_estlocus()  }
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
