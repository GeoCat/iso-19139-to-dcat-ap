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
			<xsl:apply-templates mode="record-reference" select="//gmd:MD_Metadata[gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset']"/>
		</dcat:Catalog>
	</xsl:template>

	<xsl:template mode="record-reference" match="gmd:MD_Metadata" priority="2">
		
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
		<xsl:param name="protocol"></xsl:param>
		<xsl:param name="linkurl"></xsl:param>
		<xsl:param name="TitleAndDescription"></xsl:param>
		<xsl:param name="mdURI"></xsl:param>
		<xsl:param name="Encoding"></xsl:param>
		<xsl:param name="ConstraintsRelatedToAccessAndUse"></xsl:param>
		
	<xsl:choose>
		<xsl:when test="$protocol = 'HTTP:Information'">
			<dcat:distribution>
				
				<dcat:Distribution rdf:about="{$linkurl}/{$mdURI}">
					<!-- Title and  description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<dcat:accessURL
							rdf:resource="{iso19139:processUrl(.)}"/>
					</xsl:for-each>
					<!-- Constraints related to access and use -->
					<xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
					<!-- Spatial representation type (tentative) -->
					<!-- <xsl:copy-of select="$SpatialRepresentationType"/>-->
					<!-- Encoding -->
					<xsl:copy-of select="$Encoding"/>
					<dc:format>text/html</dc:format>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:Information:Produktspecifikation'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{$linkurl}/{$mdURI}">
					<!-- Title and  description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<dcat:accessURL
							rdf:resource="{iso19139:processUrl(.)}"/>
					</xsl:for-each>
					<!-- Constraints related to access and use -->
					<xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
					<!-- Spatial representation type (tentative) -->
					<!--											<xsl:copy-of select="$SpatialRepresentationType"/>-->
					<!-- Encoding -->
					<xsl:copy-of select="$Encoding"/>
					<dc:format>text/html</dc:format>

				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:Nedladdning:data'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{$linkurl}/{$mdURI}">
					<!-- Title and  description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<dcat:accessURL
							rdf:resource="{iso19139:processUrl(.)}"/>
					</xsl:for-each>
					<!-- Constraints related to access and use -->
					<xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
					<!-- Spatial representation type (tentative) -->
					<!--											<xsl:copy-of select="$SpatialRepresentationType"/>-->
					<!-- Encoding -->
					<xsl:copy-of select="$Encoding"/>
					<dc:format>text/html</dc:format>

				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		
		<xsl:when test="$protocol = 'HTTP:nedladdning:document'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{$linkurl}/{$mdURI}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<dcat:accessURL
							rdf:resource="{iso19139:processUrl(.)}"/>
					</xsl:for-each>
					<!-- Constraints related to access and use -->
					<xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
					<!-- Spatial representation type (tentative) -->
					<!--											<xsl:copy-of select="$SpatialRepresentationType"/>-->
					<!-- Encoding -->
					<xsl:copy-of select="$Encoding"/>
					<dc:format>application/pdf</dc:format>
					<!-- Resource character encoding -->

				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:Nedladdning'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{$linkurl}/{$mdURI}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<dcat:accessURL
							rdf:resource="{iso19139:processUrl(.)}"/>
					</xsl:for-each>
					<!-- Constraints related to access and use -->
					<xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
					<!-- Spatial representation type (tentative) -->
					<!--											<xsl:copy-of select="$SpatialRepresentationType"/>-->
					<!-- Encoding -->
					<xsl:copy-of select="$Encoding"/>
					<!--		<dc:format>Nedladdning</dc:format>-->

				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:Nedladdning:Atom'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{$linkurl}/{$mdURI}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<dcat:accessURL
							rdf:resource="{iso19139:processUrl(.)}"/>
					</xsl:for-each>
					<!-- Constraints related to access and use -->
					<xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
					<!-- Spatial representation type (tentative) -->
					<!-- <xsl:copy-of select="$SpatialRepresentationType"/>-->
					<!-- Encoding -->
					<xsl:copy-of select="$Encoding"/>
					<dc:format>application/atom+xml</dc:format>

				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		
		<xsl:when test="$protocol = 'HTTP:OGC:WMS'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{$linkurl}/{$mdURI}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<dcat:accessURL
							rdf:resource="{iso19139:processUrl(.)}"/>
					</xsl:for-each>
					<!-- Constraints related to access and use -->
					<xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
					<!-- Spatial representation type (tentative) -->
					<!--											<xsl:copy-of select="$SpatialRepresentationType"/>-->
					<!-- Encoding -->
					<xsl:copy-of select="$Encoding"/>
					<dc:format>image/png</dc:format>
					
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		<xsl:when test="$protocol = 'HTTP:OGC:WFS'">
			<dcat:distribution>
				<dcat:Distribution rdf:about="{$linkurl}/{$mdURI}">
					<!-- Title and description -->
					<xsl:copy-of select="$TitleAndDescription"/>
					<!-- Access URL -->
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<dcat:accessURL
							rdf:resource="{iso19139:processUrl(.)}"/>
					</xsl:for-each>
					<!-- Constraints related to access and use -->
					<xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
					<!-- Spatial representation type (tentative) -->
					<!-- <xsl:copy-of select="$SpatialRepresentationType"/> -->
					<!-- Encoding -->
					<xsl:copy-of select="$Encoding"/>
					<dc:format>application/gml+xml</dc:format>
					

					<dcatap:availability rdf:resource="http://data.europa.eu/r5r/availability/stable"/>
				</dcat:Distribution>
			</dcat:distribution>
		</xsl:when>
		
		<!--								<xsl:when test="$function = 'information' or $function = 'search'">
									<xsl:for-each select="gmd:linkage/gmd:URL">
										<foaf:page>
											<foaf:Document rdf:about="{.}">
												<xsl:copy-of select="$TitleAndDescription"/>
											</foaf:Document>
										</foaf:page>
									</xsl:for-each>
								</xsl:when>
-->
		<!-- ?? Should dcat:landingPage be detailed with title, description, etc.? -->
		<xsl:otherwise>
			<xsl:for-each select="gmd:linkage/gmd:URL">
				<dcat:landingPage>
					<foaf:Document rdf:about="{iso19139:processUrl(.)}">
						<xsl:copy-of select="$TitleAndDescription"/>
					</foaf:Document>
				</dcat:landingPage>
			</xsl:for-each>
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
			select="iso19139:addUrlProtocol(translate($url3, ' ', ''))"/>
		
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

  </xsl:stylesheet>