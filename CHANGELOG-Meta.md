# Change log metagis

XSLT transforms swedisch iso19139 metadata to dcat-swe, for loading in the national data portal. National data portal is a rdf-type system which applies some SHACL rules to verify consistency between records. Many of these rules fail on the generic iso2dcat approach introduced by semic, which treats each record as an individual closed world. In these developments the master-sheet has been adjusted to fit with the swedisch portal rules.

The developments have been evaluated against the sandbox data portal validator at https://sandbox.admin.dataportal.se/toolkit

We've worked on 2 branches.

Meta-srv was the first initiative, but it was not maintained to be kept in synch with master.

The new branch meta2 has been set up to be kept in synch with master, with minimal changes on the actual main iso transformation sheet. By using includes for meta dedicated templates and quoting out irrelavant sections.

Main challange in the sheet is to identify child entities such as contact, distribution, etc. If a child entity does not have identification the assumption is that it can not be found by the portal. We generate a uri for each child entity, but it should be unique, else two child entities may collide. This is especcially problematic if a foaf:organisation is identified similar as a vcard:organisation.

Other problematic situation is when free values are used in a property which expects a value from a codelist such as accrualperiodicity. In that case we map the values to the codelist and skip others. This is also the reason that we removed quite some of the properties of master which populate properties with free text values, where a codelist value is expected.

For distributions we use quite dedicated template based on mediatype to override the standard behaviour in master.