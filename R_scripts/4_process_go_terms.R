# 4_process_go_terms.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

process_go_terms <- function(go_annot,
                             all_levels_output_file,
                             level_2_output_file,
                             go_map_output_file,
                             go_id_ont_term_file,
                             go_term_dict_file) {
    all_go_ids <- unique(go_annot$GO)
    all_go_info <- select(GO.db,
                          keys = all_go_ids,
                          columns = c("ONTOLOGY", "TERM"),
                          keytype = "GOID")
    all_go_info <- all_go_info[!is.na(all_go_info$TERM), ]
    all_go_info <- all_go_info[!is.na(all_go_info$ONTOLOGY), ]
    
    # Save go term map (go id to gene) for GSEA
    go_map <- go_annot[go_annot$GO %in% all_go_info$GOID, ]
    write.csv(go_map,
              file = go_map_output_file,
              row.names = FALSE)
    
    all_go_info
    write.csv(all_go_info,
              file = go_id_ont_term_file,
              row.names = FALSE)
    
    go_term_dict <- all_go_info[, c("GOID", "TERM")]
    write.csv(go_term_dict,
              file = go_term_dict_file,
              row.names = FALSE)
    
    # Find GO term levels
    bp_id <- "GO:0008150"
    mf_id <- "GO:0003674"
    cc_id <- "GO:0005575"
    
    go_levels <- NULL
    for (i in 1:nrow(all_go_info)) {
        entry <- all_go_info[i,]
        id <- entry$GOID
        ont <- entry$ONTOLOGY
        level <- NULL
        if (ont == "BP") {
            if (id == bp_id) {
                level <- 1
            } else {
                level <- 3
                parents <- GOBPPARENTS[[id]]
                for (p in parents) {
                    if (p == bp_id) {
                        level <- 2
                        break()
                    }
                }
            }
        } else if (ont == "MF") {
            if (id == mf_id) {
                level <- 1
            } else {
                level <- 3
                parents <- GOMFPARENTS[[id]]
                for (p in parents) {
                    if (p == mf_id) {
                        level <- 2
                        break()
                    }
                }
            }
        } else if (ont == "CC") {
            if (id == cc_id) {
                level <- 1
            } else {
                level <- 3
                parents <- GOCCPARENTS[[id]]
                for (p in parents) {
                    if (p == cc_id) {
                        level <- 2
                        break()
                    }
                }
            }
        }
        new_row <- data.frame(GOID = id,
                              ONTOLOGY = ont,
                              level = level,
                              stringsAsFactors = FALSE)
        go_levels <- rbind(go_levels, new_row)
    }
    
    write.csv(go_levels,
              file = all_levels_output_file,
              row.names = FALSE)
    go_levels <- go_levels[go_levels$level == 2, ]
    write.csv(go_levels,
              file = level_2_output_file,
              row.names = FALSE)
    
    return(list(go_map = go_map,
                go_term_dict = go_term_dict))
}