(: CroALa Pelagios :)
(: use a CITE URN to open a CITE Body record :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../../repo/croalacite.xqm';
import module namespace vit = "http://croala.ffzg.unizg.hr/vit" at "../../repo/vitezovic.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Commentum loci in CroALa';
declare variable $content := "Display a note connected with a CITE URN for a place name.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cite/{$urn}")
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
  function page:croalapelagiosciteurn($urn)
{
  (: HTML template starts here :)

<html>
{ vit:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Locus in <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://commons.pelagios.org/">Pelagii</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a></p>
<p>Locus identificatur et commentatur.</p>
<p>Functio nominatur: {rest:uri()}.</p>
<p>Redi ad <a href="http://croala.ffzg.unizg.hr/basex/cp/citelist">CTS URN indiculum</a>.</p>
</div>
<div class="col-md-6">
{croala:infodb('cp-citebody')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	
	{  if (starts-with($urn, "urn:cite:croala:loci" )) then cp:openciteurn($urn)
      else if (starts-with($urn, "urn:cite:perseus:latlexent") or starts-with($urn, "urn:cite:croala:latmorph")) then cite:geturn($urn)
    else if (matches($urn, "^[A-Z]")) then cite:queryname($urn) 
    else
    element p { "URN deest in collectionibus nostris."}
   
}
  
</blockquote>
     <p/>
     </div>
<hr/>
{ croala:footerserver() }

</body>
</html>
};

return




