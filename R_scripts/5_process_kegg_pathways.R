# 5_process_kegg_pathways.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

process_kegg_pathways <- function(kegg_annot,
                                  kegg_classes_output_file,
                                  kegg_map_output_file,
                                  kegg_pathway_dict_output_file) {
    ko_list <- unique(kegg_annot$KEGG)
    print(paste0("Number of KEGG pathways to look up: ", length(ko_list)))
    
    counter <- 0
    query_list <- NULL
    pathway_categories <- NULL
    kegg_pathway_dict <- NULL
    for (k in ko_list) {
        query_list <- c(query_list, k)
        counter <- counter + 1
        if (counter == 10) {
            tryCatch({
                k_query <- keggGet(query_list)
                for (i in 1:length(k_query)) {
                    
                    # Extract class
                    tryCatch({
                        k_q_entry <- k_query[[i]]
                        k_id <- k_q_entry$ENTRY
                        k_class <- k_q_entry$CLASS
                        k_class_entry <- data.frame(ID = k_id,
                                                    CLASS = k_class,
                                                    stringsAsFactors = FALSE)
                        pathway_categories <- rbind(pathway_categories,
                                                    k_class_entry)
                    }, warning = function(w) {
                        print(paste("Warning:", w, "when extrating class for",
                                    k_query[[i]]$ENTRY, sep = " "))
                    }, error = function(e) {
                        print(paste("Error:", e, "when extrating class for",
                                    k_query[[i]]$ENTRY, sep = " "))
                    })
                    
                    # Extract pathway names
                    tryCatch({
                        k_q_entry <- k_query[[i]]
                        k_id <- k_q_entry$ENTRY
                        k_name <- k_q_entry$NAME
                        k_name_entry <- data.frame(ID = k_id,
                                                   NAME = k_name,
                                                   stringsAsFactors = FALSE)
                        kegg_pathway_dict <- rbind(kegg_pathway_dict,
                                                   k_name_entry)
                    }, warning = function(w) {
                        print(paste("Warning:", w, "when extrating name for",
                                    k_query[[i]]$ENTRY, sep = " "))
                    }, error = function(e) {
                        print(paste("Error:", e, "when extrating name for",
                                    k_query[[i]]$ENTRY, sep = " "))
                    })
                }
            }, warning = function(w) {
                print("Warning:")
                print(w)
                print("when searching for")
                print(query_list)
                stop()
            }, error = function(e) {
                print("Error:")
                print(e)
                print("when searching for")
                print(query_list)
                stop()
            }, finally = {
                counter <- 0
                query_list <- NULL
                next()
            })
        }
    }
    
    kegg_map <- kegg_annot[kegg_annot$KEGG %in% kegg_pathway_dict$ID, ]
    
    print(paste0("Number of KEGG pathways which classes were found for: ",
                 nrow(pathway_categories)))
    print(paste0("Number of KEGG pathways which names were found for: ",
                 nrow(kegg_pathway_dict)))
    write.csv(pathway_categories,
              file = kegg_classes_output_file,
              row.names = FALSE)
    write.csv(kegg_map,
              file = kegg_map_output_file,
              row.names = FALSE)
    write.csv(kegg_pathway_dict,
              file = kegg_pathway_dict_output_file,
              row.names = FALSE)
    
    return(list(kegg_map = kegg_map,
                kegg_pathway_dict = kegg_pathway_dict))
}