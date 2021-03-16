# Mapping from iso19139 to DCAT-SWE elements

## Mandatory elements

### Class Catalog

DCAT | iso19139 | comment
--|--|--
dcterms:title | settings | 
dcterms:description |  settings |
dcterms:publisher | settings |
dcat:dataset | gmd:identifier | a link for each record
dcterms:license | settings |

### Class Dataset

DCAT | iso19139 | comment
--|--|--
dcterms:title | gmd:title | 
dcterms:description | gmd:abstract | 
dcterms:publisher | gmd:identificationInfo/gmd:pointOfContact//gmd:role//@codeListValue='owner' | 
dcat:distribution | gmd:distributionInfo/*/gmd:transferOptions/*/gmd:online | 
dcat:contactPoint | gmd:identificationInfo/gmd:pointOfContact//gmd:role//@codeListValue='pointOfContact' | 

### Class Distribution

DCAT | iso19139 | comment
--|--|--
dcat:accessURL | gmd:URL | 
dcat:accessService | - | Currently not iplemented 

## Recommended elements

### Class Catalog

DCAT | iso19139 | comment
--|--|--
foaf:homepage | settings | 
dcterms:language | settings | 
dcterms:issued | settings | 
dcat:themeTaxonomy | settings | 

### Class Dataset

DCAT | iso19139 | comment
--|--|--
dcterms:spatial/dct:Location/dcat:bbox | gmd:extent/gmd:EX_GeographicBoundingBox | 
dcat:keyword | gmd:keyword |
dcat:theme | gmd:topicCategory | Mapping to EU themes |
dcterms:issued | gmd:date//@type='publication' |
dcterms:temporal/dcterms:PeriodOfTime | gmd:extent//gmd:EX_TemporalExtent |

### Class Distribution

DCAT | iso19139 | comment
--|--|--
dcterms:description | gmd:description | 
dcterms:format | gmd:protocol | Mapping to SWE media types
dcterms:license | - | Mapped on dataset level
dcat:downloadURL | gmd:URL | If protocol matches with downloadable file

## Optional elements

### Class Catalog

DCAT | iso19139 | comment
--|--|--
dct:modified | settings

### Class Dataset

DCAT | iso19139 | comment
--|--|--
dct:accrualPeriodicity | gmd:MD_MaintenanceInformation//gmd:MD_MaintenanceFrequencyCode | Mapping to DC Freq types
dct:identifier | gmd:identifier | 
dct:conformsTo | gmd:referenceSystemInfo//gmd:RS_Identifier, gmd:dataQualityInfo//gmd:specification |
dct:accessRights | gmd:resourceConstraints/gmd:MD_LegalConstraints [gmd:accessConstraints]/gmd:otherConstraints | Mapping to EU constraints
dct:license | gmd:resourceConstraints/gmd:MD_LegalConstraints [gmd:usageConstraints]/gmd:otherConstraints | Mapping to SWE licenses
dct:modified | gmd:date//@type='revision' |
dct:created | gmd:date//@type='creation' |

### Class Distribution

DCAT | iso19139 | comment
--|--|--
dct:name | gmd:name |


### Codelist mappings

## Topic category to DCAT theme

iso19139 | DCAT
--|--
farming| http://publications.europa.eu/resource/authority/data-theme/AGRI
economy | http://publications.europa.eu/resource/authority/data-theme/ECON
planningCadastre | http://publications.europa.eu/resource/authority/data-theme/GOVE
health | http://publications.europa.eu/resource/authority/data-theme/HEAL
intelligenceMilitary | http://publications.europa.eu/resource/authority/data-theme/JUST
society, structure | http://publications.europa.eu/resource/authority/data-theme/SOCI
boundaries | http://publications.europa.eu/resource/authority/data-theme/REGI
geoscientificInformation, utilitiesCommunication, imageryBaseMapsEarthCover, location | http://publications.europa.eu/resource/authority/data-theme/TECH
inlandWaters, transport'">http://publications.europa.eu/resource/authority/data-theme/TRAN
others | http://publications.europa.eu/resource/authority/data-theme/ENVI

## Usage Constraints

iso19139 | DCAT
--|--
http://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#CC01.0 | http://creativecommons.org/publicdomain/zero/1.0/
https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#CCby4.0 | http://creativecommons.org/licenses/by/4.0/
https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#CCby-sa4.0 | http://creativecommons.org/licenses/by-sa/4.0/
https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#AnnanBegransning | http://creativecommons.org/publicdomain/zero/1.0/
https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#villkorOkanda | https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#villkorOkanda
http://inspire.ec.europa.eu/metadata-codelist/ConditionsApplyingToAccessAndUse/noConditionsApply | http://creativecommons.org/publicdomain/zero/1.0/
https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#licensBehovs | https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#licensBehovs
others | https://resources.geodata.se/codelist/metadata/anvandningsrestriktioner.xml#villkorOkanda
		
## Access constraints

iso19139 | DCAT
--|--
http://inspire.ec.europa.eu/metadata-codelist/LimitationsOnPublicAccess/noLimitations | http://publications.europa.eu/resource/authority/access-right/PUBLIC
https://resources.geodata.se/codelist/metadata/atkomstrestriktioner.xml#IngaBegransningar | http://publications.europa.eu/resource/authority/access-right/PUBLIC
https://resources.geodata.se/codelist/metadata/atkomstrestriktioner.xml#IngenBegransning | http://publications.europa.eu/resource/authority/access-right/PUBLIC
https://resources.geodata.se/codelist/metadata/atkomstrestriktioner.xml#OkandaBegransningar | https://resources.geodata.se/codelist/metadata/atkomstrestriktioner.xml#OkandaBegransningar
Others | http://publications.europa.eu/resource/authority/access-right/RESTRICTED

## Media types

iso19139 | DCAT
--|--
ESRI Shape | application/x-shapefile
GML | application/gml+xml
KML | vnd.google-earth.kml+xml
TIFF | image/tiff
GPKG | application/vnd.sqlite3
FGDB | application/x-filegdb
GEOJSON | application/geo+json
SDE Feature Class | application/x-filegdb

## Services

iso19139 | DCAT
--|--
HTTP:Information | text/html
HTTP:Information:Produktspecifikation | text/html
HTTP:Nedladdning:data | text/html
HTTP:nedladdning:document | application/pdf
HTTP:Nedladdning | -
HTTP:Nedladdning:Atom | application/atom+xml
HTTP:OGC:WMS | image/png
HTTP:OGC:WFS | application/gml+xml