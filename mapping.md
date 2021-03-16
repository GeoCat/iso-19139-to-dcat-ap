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
dcterms:issued | gmd:data//@type='publication' |
dcterms:temporal/dcterms:PeriodOfTime | gmd:extent//gmd:EX_TemporalExtent |

### Class Distribution

DCAT | iso19139 | comment
--|--|--
dcterms:description | gmd:description | 
dcterms:format | gmd:protocol | Mapping to SWE media types
dcterms:license | - | Not implemented
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
dct:modified | gmd:data//@type='revision' |
dct:created | gmd:data//@type='creation' |

### Class Distribution

DCAT | iso19139 | comment
--|--|--
dct:name | gmd:name |