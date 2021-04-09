## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/",
  out.width = "100%"
)


## ----coupling angle-----------------------------------------------------------
library(biblionetwork)
biblio_coupling(Ref_stagflation, 
                source = "Citing_ItemID_Ref", 
                ref = "ItemID_Ref", 
                normalized_weight_only = FALSE, 
                weight_threshold = 1)


## ----threshold example--------------------------------------------------------
biblio_coupling(Ref_stagflation, 
                source = "Citing_ItemID_Ref", 
                ref = "ItemID_Ref", 
                weight_threshold = 3)


## ----cocitation---------------------------------------------------------------
biblio_coupling(Ref_stagflation, 
                source = "ItemID_Ref", 
                ref = "Citing_ItemID_Ref")

biblio_cocitation(Ref_stagflation, 
                  source = "Citing_ItemID_Ref", 
                  ref = "ItemID_Ref")


## ----coupling strength--------------------------------------------------------
coupling_strength(Ref_stagflation, 
                  source = "Citing_ItemID_Ref", 
                  ref = "ItemID_Ref", 
                  weight_threshold = 1)


## ----coupling entity----------------------------------------------------------
# merging the references data with the citing author information in Nodes_stagflation
entity_citations <- merge(Ref_stagflation, 
                          Authors_stagflation, 
                          by.x = "Citing_ItemID_Ref", 
                          by.y = "ItemID_Ref",
                          allow.cartesian = TRUE) 
# allow.cartesian is needed as we have several authors per article, thus the merge results 
# is longer than the longer merged data frame

coupling_entity(entity_citations, 
                source = "Citing_ItemID_Ref", 
                ref = "ItemID_Ref", 
                entity = "Author.y", 
                method = "coupling_angle")


## ----coauthorship network-----------------------------------------------------

full_counting <- coauth_network(Authors_stagflation, 
                                authors = "Author", 
                                articles = "ItemID_Ref", 
                                method = "full_counting")
head(full_counting[order(Source)],10)

fractional_counting <- coauth_network(Authors_stagflation, 
                                      authors = "Author", 
                                      articles = "ItemID_Ref", 
                                      method = "fractional_counting")
head(fractional_counting[order(Source)],10)

fractional_counting_cosine <- coauth_network(Authors_stagflation,
                                             authors = "Author", 
                                             articles = "ItemID_Ref", 
                                             method = "fractional_counting", 
                                             cosine_normalized = TRUE)
head(fractional_counting_cosine[order(Source)],10)
  

