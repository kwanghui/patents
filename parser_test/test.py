from cStringIO import StringIO
from datetime import datetime
from unidecode import unidecode
from handler import Patobj, PatentHandler
import re
import uuid
import xml.sax
import xml_util
import xml_driver

xml_string = 'ipg050104.xml'

xh = xml_driver.XMLHandler()
parser = xml_driver.make_parser()
parser.setContentHandler(xh)
parser.setFeature(xml_driver.handler.feature_external_ges, False)

l = xml.sax.xmlreader.Locator()
xh.setDocumentLocator(l)

#parser.parse(StringIO(xml_string))
parser.parse(xml_string)
print "parsing done"

#print type(xh.root.us_bibliographic_data_grant.publication_reference.contents_of('document_id', '', as_string=False))
print xh.root.claims.contents_of('claim', '', as_string=True, upper=False)

#print type(xh.root.us_bibliographic_data_grant.publication_reference.contents_of('document_id', '', as_string=True))
#print xh.root.us_bibliographic_data_grant.publication_reference.contents_of('document_id', '', as_string=True)
