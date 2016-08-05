#!/usr/bin/python
from __future__ import print_function
"""body-csv2rdf.py: Parse CSV. Output RDF to address the CITE analysis object: 
"""


__author__ = "Neven Jovanovic"
__copyright__ = ["Neven Jovanovic, Zagreb, Croatia"]
__credits__ = ["Neven Jovanovic"]
__license__ = "CC-BY"
__version__ = "0.0.1"
__maintainer__ = "Neven Jovanovic"
__email__ = "neven.jovanovic@ffzg.hr"
__status__ = "Prototype"


import os
import csv
from rdflib import URIRef, BNode, Literal, Graph, Namespace
from rdflib.namespace import RDF , DC


# initialize RDF graph and rdfs, oa, olo, and owl namespaces
croala2graph = Graph()
rdfs = Namespace("http://www.w3.org/2000/01/rdf-schema#")
oa = Namespace("http://www.w3.org/ns/oa#")
ecrm = Namespace("http://erlangen-crm.org/current/")
lawd = Namespace("http://lawd.info/ontology/1.0/")
pleiades = Namespace("http://pleiades.stoa.org/places/vocab#")
saws = Namespace("http://purl.org/saws/ontology/")
dcterms = Namespace("http://purl.org/dc/terms/")

# open file, parse it as CSV object, select necessary fields
with open('../csv/pilot/modruski-cite-analysis-places-body.csv') as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        abody = URIRef(row[0])
        atarget = URIRef(row[2])
        annobody = BNode()
        annobody1 = BNode()
        annobody2 = BNode()
        label = Literal(row[3], lang='la')
        placeuri = URIRef(row[7])
        perioduri = URIRef(row[8])
        topicuri = URIRef(row[11])
        golduri1 = URIRef(row[14])
        golduri2 = URIRef(row[15])
        dcauthoruri = URIRef(row[16])
        dcdate = Literal(row[17])
        croala2graph.add((abody,RDF.type,oa.Annotation))
        croala2graph.add((abody,oa.motivatedBy,oa.identifying))
        croala2graph.add((abody,oa.hasTarget,atarget))
        croala2graph.add((abody,oa.hasBody,annobody))
        croala2graph.add((annobody,RDF.type,lawd.PlaceName))
        croala2graph.add((annobody,saws.refersTo,placeuri))
        croala2graph.add((annobody,pleiades.during,perioduri))
        croala2graph.add((abody,oa.hasBody,annobody1))
        croala2graph.add((annobody1,RDF.type,ecrm.E89_Propositional_Object))
        croala2graph.add((annobody1,RDF.type,topicuri))
        croala2graph.add((abody,oa.hasBody,annobody2))
        croala2graph.add((annobody2,RDF.type,ecrm.E33_Linguistic_Object))
        croala2graph.add((annobody2,RDF.type,golduri1))
        croala2graph.add((annobody2,RDF.type,golduri2))
        croala2graph.add((abody,dcterms.creator,dcauthoruri))
        croala2graph.add((abody,dcterms.created,dcdate))        
        croala2graph.add((abody,rdfs.label,label))

# add the RDF statements to our graph file
croalardffile = open("../rdf/croala-cite-ana-body.ttl", "w")
print(croala2graph.serialize(format='turtle'), file=croalardffile)

