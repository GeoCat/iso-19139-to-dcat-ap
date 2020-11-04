#!/usr/bin/env python3
 
 
import os.path
import sys
from lxml import etree
 
 
def main(args):
    """Script for running an XSL transform against an XML file.
 
    The script accepts three positional arguments:
 
    (1) The input XML file to process
    (2) The XSL transform to process the XML file with
    (3) The output file.
 
    For example:
 
    python3 xsl_transform.py input.xml process.xsl output.xml
    """
    if len(args) != 2:
        print("ERROR: Missing or invalid arguments!")
        print(
            "Usage: {0} <input.xml>".format(
                args[0]))
        sys.exit(1)
 
    input_xml_filename = args[1]
    process_xsl_filename = "iso-19139-to-dcat-ap.xsl"
    output_filename = "out.xml"
    if not os.path.isfile(input_xml_filename):
        print("ERROR: Unable to access input XML file: {0}".format(
            input_xml_filename))
        sys.exit(1)
    if not os.path.isfile(process_xsl_filename):
        print("ERROR: Unable to access XSL file: {0}".format(
            process_xsl_filename))
        sys.exit(1)
    if os.path.isfile(output_filename):
        print("WARNING: Output file {0} exists and will be overwritten.".format(
            output_filename))

    parser = etree.XMLParser(resolve_entities=False)
    parser.resolvers.add(FileResolver())
    process_xsl = etree.parse(process_xsl_filename)
    xsl_transform = etree.XSLT(process_xsl)
    cnt = 0
    input_xml = etree.parse(input_xml_filename, parser)
    mds = input_xml.xpath('//gmd:MD_Metadata',namespaces={'gmd': 'http://www.isotc211.org/2005/gmd'})
    for elm in mds:
        try:
           output_xml = xsl_transform(elm)
        except:
            print(xsl_transform.error_log)     
        cnt = cnt + 1
        with open(str(cnt) + '.xml', 'w') as output_xml_file:
            try:
                output_xml_file.write(
                    etree.tostring(
                        output_xml,
                        pretty_print=True).decode())
            except:
                print (str(cnt)+' has error')

class FileResolver(etree.Resolver):
       def resolve(self, url, pubid, context):
           return self.resolve_filename(url, context)

if __name__ == "__main__":
    main(sys.argv)