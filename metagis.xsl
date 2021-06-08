<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet    xmlns:adms   = "http://www.w3.org/ns/adms#"
	xmlns:cnt    = "http://www.w3.org/2011/content#"
	xmlns:dc     = "http://purl.org/dc/elements/1.1/"
	xmlns:dcat   = "http://www.w3.org/ns/dcat#"
	xmlns:dct    = "http://purl.org/dc/terms/"
	xmlns:dctype = "http://purl.org/dc/dcmitype/"
	xmlns:earl   = "http://www.w3.org/ns/earl#"
	xmlns:foaf   = "http://xmlns.com/foaf/0.1/"
	xmlns:gco    = "http://www.isotc211.org/2005/gco"
	xmlns:gmd    = "http://www.isotc211.org/2005/gmd"
	xmlns:gml    = "http://www.opengis.net/gml"
	xmlns:gmx    = "http://www.isotc211.org/2005/gmx"
	xmlns:gsp    = "http://www.opengis.net/ont/geosparql#"
	xmlns:i      = "http://inspire.ec.europa.eu/schemas/common/1.0"
	xmlns:i-gp   = "http://inspire.ec.europa.eu/schemas/geoportal/1.0"
	xmlns:locn   = "http://www.w3.org/ns/locn#"
	xmlns:owl    = "http://www.w3.org/2002/07/owl#"
	xmlns:org    = "http://www.w3.org/ns/org#"
	xmlns:prov   = "http://www.w3.org/ns/prov#"
	xmlns:rdf    = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs   = "http://www.w3.org/2000/01/rdf-schema#"
	xmlns:schema = "http://schema.org/"
	xmlns:skos   = "http://www.w3.org/2004/02/skos/core#"
	xmlns:srv    = "http://www.isotc211.org/2005/srv"
	xmlns:vcard  = "http://www.w3.org/2006/vcard/ns#"
	xmlns:wdrs   = "http://www.w3.org/2007/05/powder-s#"
	xmlns:xlink  = "http://www.w3.org/1999/xlink"
	xmlns:xsi    = "http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl    = "http://www.w3.org/1999/XSL/Transform"
	xmlns:dcatap = "http://data.europa.eu/r5r/"
	xmlns:iso19139 = "http://geonetwork-opensource.org/schemas/iso19139"
	xmlns:xs 	 = "http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="earl gco gmd gml gmx i i-gp srv xlink xsi xsl wdrs"
	version="2.0">

	<xsl:template name="catalogue">
		<!-- First, the local catalog description using dcat:Catalog.
      "Typically, a web-based data catalog is represented as a single instance of this class."
      ... also describe harvested catalogues if harvested records are in the current dump.
    -->
		<dcat:Catalog rdf:about="{$catURL}">
			<!-- A name given to the catalog. -->
			<dct:title xml:lang="{$iso2letterLanguageCode}">
				<xsl:value-of select="$catTitle"/>
			</dct:title>
			<!-- free-text account of the catalog. -->
			<dct:description>
				<xsl:value-of select="$catDescription"/>
			</dct:description>
			<xsl:message>#!!!!!<xsl:value-of select="$catTitle"/></xsl:message>
			<rdfs:label xml:lang="{$iso2letterLanguageCode}">
				<xsl:value-of select="$catTitle"/>
				<!--     <xsl:value-of select="$env/geonet:system/geonet:site/geonet:name"/> (<xsl:value-of
          select="$env/geonet:system/geonet:site/geonet:organization"/>)-->
			</rdfs:label>
			<!-- The homepage of the catalog -->
<!--			<foaf:homepage>
				<xsl:value-of select="$catURL"/>
			</foaf:homepage>-->
			<!-- FIXME : void:Dataset 
			<void:openSearchDescription>
				<xsl:value-of select="$catGNBaseUrl"/>/srv/eng/portal.opensearch</void:openSearchDescription>
			<void:uriLookupEndpoint>
				<xsl:value-of select="$catGNBaseUrl"/>/srv/eng/rdf.search?any=</void:uriLookupEndpoint>-->
			<!-- The entity responsible for making the catalog online. -->
			<dct:publisher>
				<foaf:agent
					rdf:about="https://resources.geodata.se/codelist/organisationer/lantmateriet">
					<foaf:name>
						<xsl:value-of select="$CatOrgName"/>
					</foaf:name>
					<!--<dc:type rdf:resource="http://purl.org/adms/publishertype/NationalAuthority"/> 
					<foaf:mbox rdf:resource="mailto:geodatasupport@geodata.se"/> -->
					<dc:type rdf:resource="http://purl.org/adms/publishertype/LocalAuthority"/>
					<foaf:mbox rdf:resource="mailto:{$CatOrgEmail}"/>
				</foaf:agent>
			</dct:publisher>
			<!-- The knowledge organization system (KOS) used to classify catalog's datasets.
      -->
			<!-- <xsl:for-each select="/geonet :root/gui/thesaurus/thesauri/thesaurus">-->
			<!--<dcat:themes rdf:resource="{$url}/thesaurus/{key}"/>-->
			<!--      </xsl:for-each>-->
			<!-- The language of the catalog. This refers to the language used
        in the textual metadata describing titles, descriptions, etc.
        of the datasets in the catalog.

        http://www.ietf.org/rfc/rfc3066.txt

        Multiple values can be used. The publisher might also choose to describe
        the language on the dataset level (see dataset language).
      -->
			<foaf:homepage rdf:resource="{$catMDBaseUrl}"/>
			<dct:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="current-dateTime()"/></dct:issued>
			<dct:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime"><xsl:value-of select="current-dateTime()"/></dct:modified>
			<dcat:themeTaxonomy rdf:resource="http://publications.europa.eu/resource/authority/data-theme"/>	
			<dct:language
				rdf:resource="http://publications.europa.eu/resource/authority/language/SWE"/>
			<dct:license rdf:resource="http://creativecommons.org/licenses/by/4.0/"/>
			<!-- This describes the license under which the catalog can be used/reused and not the datasets.
        Even if the license of the catalog applies to all of its datasets it should be
        replicated on each dataset.-->
			<!-- TODO using VoIDx
      <dc:license>
      </dc:license>
      -->
			<!-- The geographical area covered by the catalog.
      <dc:Location>

       </dc:Location> -->
			<!-- List all catalogue records
        <dcat:dataset rdf:resource="http://localhost:8080/geonetwork/dataset/1"/>
        <dcat:record rdf:resource="http://localhost:8080/geonetwork/metadata/1"/>
      
			<xsl:apply-templates mode="record-reference" select="//gmd:MD_Metadata[gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset']"/>
		-->
			<xsl:apply-templates mode="record-reference" select="//gmd:MD_Metadata[
				gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset' and
				gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString != 'SMHI']"/>
		</dcat:Catalog>
	</xsl:template>

	<xsl:template mode="record-reference" match="gmd:MD_Metadata[gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset']" priority="2">
		
		<xsl:param name="MetadataUri">
			<xsl:variable name="mURI" select="gmd:fileIdentifier/gco:CharacterString"/>
			<xsl:if
				test="$mURI != '' and (starts-with($mURI, 'http://') or starts-with($mURI, 'https://'))">
				<xsl:value-of select="$mURI"/>
			</xsl:if>
		</xsl:param>
		
		<xsl:variable name="mdURI" select="gmd:fileIdentifier/gco:CharacterString"/>
		<!--		<xsl:if test="gmd:identificationInfo//gmd:descriptiveKeywords[gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString='Initiativ']/gmd:MD_Keywords/gmd:keyword/gco:CharacterString='Öppna data'"  > -->
		
		<!--<xsl:message>#!!!!!<xsl:value-of select="$mdURI"/></xsl:message>-->
		<dcat:dataset rdf:resource="{$catMDBaseUrl}/{$mdURI}"/>
		
		<!-- <dcat:record rdf:resource="{$url}/metadata/{geonet:info/uuid}"/>-->
	</xsl:template>
	
	<xsl:template name="protocolMatch">
		<xsl:param name="online"/>
		<xsl:param name="dsURI"/>
		
		<xsl:variable name="protocol" select="$online/gmd:protocol/gco:CharacterString" />
		<xsl:variable name="linkurl" select="$online/gmd:linkage/gmd:URL"/>
		<xsl:variable name="Title" select="$online/gmd:name/gco:CharacterString"/>
		<xsl:variable name="Description" select="$online/gmd:description/gco:CharacterString"/>
		<xsl:variable name="TitleAndDescription">
			<xsl:if test="$Title"><dct:name><xsl:value-of select="$Title"/></dct:name></xsl:if>
			<xsl:if test="$Description"><dct:description><xsl:value-of select="$Description"/></dct:description></xsl:if>
		</xsl:variable>
		<xsl:variable name="separator">
			<xsl:choose>
				<xsl:when test="contains($linkurl,'#')">/</xsl:when>
				<xsl:otherwise>#</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
	<xsl:choose>
		<xsl:when test="$protocol = 'HTTP:Information'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{iso19139:processUrl(concat($dsURI,$separator,$protocol,'/',position()))}">
					<!-- Title and  description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<dcat:accessURL
							rdf:resource="{iso19139:processUrl($linkurl)}"/>
					<dc:format>text/html</dc:format>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:Information:Produktspecifikation'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{iso19139:processUrl(concat($dsURI,$separator,$protocol,'/',position()))}">
					<!-- Title and  description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<dcat:accessURL
							rdf:resource="{iso19139:processUrl($linkurl)}"/>
					<dc:format>text/html</dc:format>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:Nedladdning:data'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{iso19139:processUrl(concat($dsURI,$separator,$protocol,'/',position()))}">
					<!-- Title and  description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<dcat:accessURL
							rdf:resource="{iso19139:processUrl($linkurl)}"/>
					<dc:format>text/html</dc:format>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		
		<xsl:when test="$protocol = 'HTTP:nedladdning:document'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{iso19139:processUrl(concat($dsURI,$separator,$protocol,'/',position()))}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<dcat:accessURL
							rdf:resource="{iso19139:processUrl($linkurl)}"/>
					<dc:format>application/pdf</dc:format>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:Nedladdning'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{iso19139:processUrl(concat($dsURI,$separator,$protocol,'/',position()))}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
				    <dcat:accessURL
							rdf:resource="{iso19139:processUrl($linkurl)}"/>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:Nedladdning:Atom'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{iso19139:processUrl(concat($dsURI,$separator,$protocol,'/',position()))}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
				    <dcat:accessURL
							rdf:resource="{iso19139:processUrl($linkurl)}"/>
					<dc:format>application/atom+xml</dc:format>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		
		<xsl:when test="$protocol = 'HTTP:OGC:WMS'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{iso19139:processUrl(concat($dsURI,$separator,$protocol,'/',position()))}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<dcat:accessURL
							rdf:resource="{iso19139:processUrl($linkurl)}"/>
					<dc:format>application/vnd.ogc.wms_xml</dc:format>		
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:OGC:WFS'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{iso19139:processUrl(concat($dsURI,$separator,$protocol,'/',position()))}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
			        <dcat:accessURL
			        	rdf:resource="{iso19139:processUrl($linkurl)}"/>
					<dc:format>application/vnd.ogc.wfs_xml</dc:format>
					<dcatap:availability rdf:resource="http://data.europa.eu/r5r/availability/stable"/>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		
		<!-- ?? Should dcat:landingPage be detailed with title, description, etc.? -->
		<xsl:otherwise>
				<dcat:landingPage rdf:resource="{iso19139:processUrl($linkurl)}"/>
		</xsl:otherwise>
	</xsl:choose>
	
	</xsl:template>

	<xsl:function name="iso19139:processUrl" as="xs:string">
		<xsl:param name="url" as="xs:string"/>
		
		<!-- Fix protocol -->
		<!--<xsl:variable name="url2" select="replace($url, 'ftp:', 'https:')" />-->
		<xsl:variable name="url2" select="translate($url, '{', '')"/>
		<xsl:variable name="url3" select="translate($url2, '}', '')"/>
		
		<xsl:variable name="urlFixedProtocol"
			select="iso19139:addUrlProtocol(translate($url3, ' ', '+'))"/>
		
		<!-- Replace placeholder elements in url between [] symbols, removing the []. Example:
			
        http://www.trafikverket.se/TrvSeFiler/Foretag/[API-key]/Bygga_och_underhalla/Vag
        
        is updated to
        
        http://www.trafikverket.se/TrvSeFiler/Foretag/API-key/Bygga_och_underhalla/Vag
    -->
		<xsl:variable name="newUrl">
			<xsl:analyze-string select="$urlFixedProtocol" regex="\[(.*?)\]">
				<xsl:matching-substring>
					<xsl:value-of select='replace(., "\[(.*?)\]", "$1")'/>
				</xsl:matching-substring>
				<xsl:non-matching-substring>
					<xsl:value-of select="."/>
				</xsl:non-matching-substring>
			</xsl:analyze-string>
		</xsl:variable>
		
		<xsl:value-of select="$newUrl"/>
	</xsl:function>
	
	<xsl:function name="iso19139:addUrlProtocol" as="xs:string">
		<xsl:param name="url" as="xs:string"/>
		
		<!-- TODO: Check to add ftp://,file:// if required -->
		<xsl:variable name="validProtocols" select="'http://,https://,ftp://'"/>
		
		<xsl:variable name="validProtocolsList" select="tokenize($validProtocols, ',')"/>
		<xsl:variable name="hasValidProtocol">
			<xsl:for-each select="$validProtocolsList">
				<xsl:if test="starts-with($url, .)"> true </xsl:if>
			</xsl:for-each>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="string(normalize-space($hasValidProtocol))">
				<xsl:value-of select="$url"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('http://', $url)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xsl:function name="iso19139:getTopic" as="xs:string">
		<xsl:param name="TopicCategory" as="xs:string"/>
			<xsl:choose>
				<xsl:when test="$TopicCategory = 'farming'">http://publications.europa.eu/resource/authority/data-theme/AGRI</xsl:when>
				<xsl:when test="$TopicCategory = 'economy'">http://publications.europa.eu/resource/authority/data-theme/ECON</xsl:when>
				<xsl:when test="$TopicCategory = 'planningCadastre'">http://publications.europa.eu/resource/authority/data-theme/GOVE</xsl:when>
				<xsl:when test="$TopicCategory = 'health'">http://publications.europa.eu/resource/authority/data-theme/HEAL</xsl:when>
				<xsl:when test="$TopicCategory = 'intelligenceMilitary'">http://publications.europa.eu/resource/authority/data-theme/JUST</xsl:when>
				<xsl:when test="$TopicCategory = 'society' or $TopicCategory = 'structure'">http://publications.europa.eu/resource/authority/data-theme/SOCI</xsl:when>
				<xsl:when test="$TopicCategory = 'boundaries'">http://publications.europa.eu/resource/authority/data-theme/REGI</xsl:when>
				<xsl:when test="$TopicCategory = 'geoscientificInformation' or $TopicCategory = 'utilitiesCommunication' or $TopicCategory = 'imageryBaseMapsEarthCover' or $TopicCategory = 'location'">http://publications.europa.eu/resource/authority/data-theme/TECH</xsl:when>
				<xsl:when test="$TopicCategory = 'inlandWaters' or $TopicCategory = 'transport'">http://publications.europa.eu/resource/authority/data-theme/TRAN</xsl:when>
				<xsl:otherwise>http://publications.europa.eu/resource/authority/data-theme/ENVI</xsl:otherwise>
			</xsl:choose>
	</xsl:function>
	
	<xsl:function name="iso19139:mapFormat">
		<xsl:param name="format" as="xs:string"/>
		<xsl:choose>
			<xsl:when test="$format = 'ESRI Shape'">application/x-shapefile</xsl:when>
			<xsl:when test="$format = 'GML'">application/gml+xml</xsl:when>
			<xsl:when test="$format = 'KML'">vnd.google-earth.kml+xml</xsl:when>
			<xsl:when test="$format = 'TIFF'">image/tiff</xsl:when>
			<xsl:when test="$format = 'GPKG'">application/vnd.sqlite3</xsl:when>
			<xsl:when test="$format = 'FGDB'">application/x-filegdb</xsl:when>
			<xsl:when test="$format = 'GEOJSON'">application/geo+json</xsl:when>
			<xsl:when test="$format = 'SDE Feature Class'">application/x-filegdb</xsl:when>
		</xsl:choose>
	</xsl:function>
	
	<xsl:function name="iso19139:mapAccessConstraints" as="xs:string">
		<!-- there is currently no value in swedisch access rights to indicate "unknown", an option is to leave the element empty -->
		<xsl:param name="const" as="xs:string" />
		<xsl:choose>
			<xsl:when test="$const = 'http://inspire.ec.europa.eu/metadata-codelist/LimitationsOnPublicAccess/noLimitations'">http://publications.europa.eu/resource/authority/access-right/PUBLIC</xsl:when>
			<xsl:when test="$const = 'https://resources.geodata.se/codelist/metadata/atkomstrestriktioner.xml#IngaBegransningar'">http://publications.europa.eu/resource/authority/access-right/PUBLIC</xsl:when>
			<xsl:when test="$const = 'https://resources.geodata.se/codelist/metadata/atkomstrestriktioner.xml#IngenBegransning'">http://publications.europa.eu/resource/authority/access-right/PUBLIC</xsl:when>
			<!--<xsl:when test="$const = 'https://resources.geodata.se/codelist/metadata/atkomstrestriktioner.xml#OkandaBegransningar'">https://resources.geodata.se/codelist/metadata/atkomstrestriktioner.xml#OkandaBegransningar</xsl:when>-->
			<xsl:otherwise>http://publications.europa.eu/resource/authority/access-right/RESTRICTED</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
	<xsl:function name="iso19139:fetchDSID">
		<!-- extracts the uuid from metadata url, tries to use the uuid to find a metadata record, inside the dsid -->
		<xsl:param name="mdurl" as="xs:string" />
		<xsl:param name="md" />
		<xsl:variable name="mdid" select="tokenize(tokenize(tokenize($mdurl,'id=')[2],'&amp;')[1],'#')[1]"/>
		<xsl:if test="$mdid!=''">
			<xsl:variable name="dsid" select="$md//gmd:MD_Metadata[gmd:fileIdentifier/gco:CharacterString=$mdid]/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/*/gmd:code/*"/>
			<xsl:choose>
				<xsl:when test="starts-with($dsid/@xlink:href,'http')">
					<xsl:value-of select="$dsid/@xlink:href"/>
				</xsl:when>
				<xsl:when test="$dsid != ''"><xsl:value-of select="$dsid"/></xsl:when>
			</xsl:choose>		
		</xsl:if>
	</xsl:function>
	
	
	<xsl:function name="iso19139:mapUsageConstraints" as="xs:string">
		<!-- there is currently no value in swedisch license to indicate "unknown" or "restricted", an option is to leave the element empty, or reference the anvandningsrestriktioner codelist -->
		<xsl:param name="const" as="xs:string" />
		<xsl:choose>
			<xsl:when test="$const = 'http://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#CC01.0'">http://creativecommons.org/publicdomain/zero/1.0/</xsl:when>
			<xsl:when test="$const = 'https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#CCby4.0'">http://creativecommons.org/licenses/by/4.0/</xsl:when>
			<xsl:when test="$const = 'https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#CCby-sa4.0'">http://creativecommons.org/licenses/by-sa/4.0/</xsl:when>
			<xsl:when test="$const = 'https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#AnnanBegransning'">http://creativecommons.org/publicdomain/zero/1.0/</xsl:when>
			<xsl:when test="$const = 'https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#villkorOkanda'">https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#villkorOkanda</xsl:when> <!-- unknown -->
			<xsl:when test="$const = 'http://inspire.ec.europa.eu/metadata-codelist/ConditionsApplyingToAccessAndUse/noConditionsApply'">http://creativecommons.org/publicdomain/zero/1.0/</xsl:when>
			<xsl:when test="$const = 'https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#licensBehovs'">https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#licensBehovs</xsl:when> <!-- restricted -->
			<xsl:otherwise>https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#villkorOkanda</xsl:otherwise>
		</xsl:choose>  
	</xsl:function>

</xsl:stylesheet>