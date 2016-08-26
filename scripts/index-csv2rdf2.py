#!/usr/bin/python
# from __future__ import print_function
"""index-csv2rdf.py: Parse CSV. Output RDF to address the CITE object and CTS: 
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
from rdflib import URIRef, BNode, Literal, Graph, Namespace, XSD
from rdflib.namespace import RDF


# initialize RDF graph and rdfs, oa, olo, and owl namespaces
croala1graph = Graph()
rdfs = Namespace("http://www.w3.org/2000/01/rdf-schema#")
oa = Namespace("http://www.w3.org/ns/oa#")
olo = Namespace("http://purl.org/ontology/olo/core#")
owl = Namespace("http://www.w3.org/2002/07/owl#")
cts = Namespace("http://croala.ffzg.unizg.hr/basex/cts/")

# open file, parse it as CSV object, select necessary fields
with open('../csv/t-cite-modr-cts-ana.csv') as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        ctsurn = URIRef("http://croala.ffzg.unizg.hr/basex/cts/" + row[1])
        sequence = Literal(row[0], datatype=XSD.integer)
        arecord = URIRef("http://croala.ffzg.unizg.hr/basex/cts/" + row[4])
        abody = URIRef("http://croala.ffzg.unizg.hr/basex/cts/" + row[5])
        aexemplar = URIRef("http://croala.ffzg.unizg.hr/basex/cts/" + row[6])
        label = Literal(row[2], lang='la')
        croala1graph.add((arecord,RDF.type,oa.Annotation))
        croala1graph.add((arecord,olo.item,sequence))
        croala1graph.add((arecord,oa.hasBody,abody))
        croala1graph.add((arecord,oa.hasTarget,ctsurn))
        croala1graph.add((arecord,oa.hasTarget,aexemplar))
        croala1graph.add((arecord,rdfs.label,label))
# add the RDF statements to our graph file
# croalardffile = open("../rdf/croala-cite-ana2.ttl", "w")
croala1graph.serialize("../rdf/croala-cite-ana2.xml", format="xml")
# print(croala1graph.serialize(format='turtle'), file=croalardffile)
