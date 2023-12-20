# 20_control_skin_gsea_dotplots_enrichment_maps.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

mp_gsea_dotplots_enrichment_maps <- function(go_gsea_res_low_w6,
                                             kegg_gsea_res_low_w6,
                                             go_gsea_res_high_w6,
                                             kegg_gsea_res_high_w6,
                                             go_gsea_res_low_w8,
                                             kegg_gsea_res_low_w8,
                                             go_gsea_res_high_w8,
                                             kegg_gsea_res_high_w8,
                                             go_gsea_res_low_gs45,
                                             kegg_gsea_res_low_gs45,
                                             go_gsea_res_high_gs45,
                                             kegg_gsea_res_high_gs45,
                                             output_dir) {
    if (nrow(go_gsea_res_low_w6) != 0) {
        go_dotplot_low_w6 <- dotplot(go_gsea_res_low_w6,
                                     showCategory = 20,
                                     orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_GS~34_1×.png"),
               plot = go_dotplot_low_w6,
               height = 11,
               width = 9)
    }
    
    if (nrow(kegg_gsea_res_low_w6) != 0) {
        kegg_dotplot_low_w6 <- dotplot(kegg_gsea_res_low_w6,
                                       showCategory = 20,
                                       orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_GS~34_1×.png"),
               plot = kegg_dotplot_low_w6,
               height = 11,
               width = 9)
    }
    
    if (nrow(go_gsea_res_high_w6) != 0) {
        go_dotplot_high_w6 <- dotplot(go_gsea_res_high_w6,
                                      showCategory = 20,
                                      orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_GS~34_10×.png"),
               plot = go_dotplot_high_w6,
               height = 11,
               width = 9)
    }
    
    if (nrow(kegg_gsea_res_high_w6) != 0) {
        kegg_dotplot_high_w6 <- dotplot(kegg_gsea_res_high_w6,
                                        showCategory = 20,
                                        orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_GS~34_10×.png"),
               plot = kegg_dotplot_high_w6,
               height = 11,
               width = 9)
    }
    
    if (nrow(go_gsea_res_low_w8) != 0) {
        go_dotplot_low_w8 <- dotplot(go_gsea_res_low_w8,
                                     showCategory = 20,
                                     orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_GS~42_1×.png"),
               plot = go_dotplot_low_w8,
               height = 11,
               width = 9)
    }
    
    if (nrow(kegg_gsea_res_low_w8) != 0) {
        kegg_dotplot_low_w8 <- dotplot(kegg_gsea_res_low_w8,
                                       showCategory = 20,
                                       orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_GS~42_1×.png"),
               plot = kegg_dotplot_low_w8,
               height = 11,
               width = 9)
    }
    
    if (nrow(go_gsea_res_high_w8) != 0) {
        go_dotplot_high_w8 <- dotplot(go_gsea_res_high_w8,
                                      showCategory = 20,
                                      orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_GS~42_10×.png"),
               plot = go_dotplot_high_w8,
               height = 11,
               width = 9)
    }
    
    if (nrow(kegg_gsea_res_high_w8) != 0) {
        kegg_dotplot_high_w8 <- dotplot(kegg_gsea_res_high_w8,
                                        showCategory = 20,
                                        orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_GS~42_10×.png"),
               plot = kegg_dotplot_high_w8,
               height = 11,
               width = 9)
    }
    
    if (nrow(go_gsea_res_low_gs45) != 0) {
        go_dotplot_low_gs45 <- dotplot(go_gsea_res_low_gs45,
                                       showCategory = 20,
                                       orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_GS45_1×.png"),
               plot = go_dotplot_low_gs45,
               height = 11,
               width = 9)
    }
    
    if (nrow(kegg_gsea_res_low_gs45) != 0) {
        kegg_dotplot_low_gs45 <- dotplot(kegg_gsea_res_low_gs45,
                                         showCategory = 20,
                                         orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_GS45_1×.png"),
               plot = kegg_dotplot_low_gs45,
               height = 11,
               width = 9)
    }
    
    if (nrow(go_gsea_res_high_gs45) != 0) {
        go_dotplot_high_gs45 <- dotplot(go_gsea_res_high_gs45,
                                        showCategory = 20,
                                        orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_GS45_10×.png"),
               plot = go_dotplot_high_gs45,
               height = 11,
               width = 9)
    }
    
    if (nrow(kegg_gsea_res_high_gs45) != 0) {
        kegg_dotplot_high_gs45 <- dotplot(kegg_gsea_res_high_gs45,
                                          showCategory = 20,
                                          orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_GS45_10×.png"),
               plot = kegg_dotplot_high_gs45,
               height = 11,
               width = 9)
    }
    
    
    if (nrow(go_gsea_res_low_w6) > 1) {
        go_gsea_res_low_w6_dists <- enrichplot::pairwise_termsim(go_gsea_res_low_w6,
                                                                 showCategory = nrow(go_gsea_res_low_w6))
        go_gsea_res_low_w6_map <- emapplot(go_gsea_res_low_w6_dists,
                                           showCategory = nrow(go_gsea_res_low_w6_dists),
                                           color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_low_w6.png"),
               plot = go_gsea_res_low_w6_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 3)
    }
    
    if (nrow(go_gsea_res_high_w6) > 1) {
        go_gsea_res_high_w6_dists <- enrichplot::pairwise_termsim(go_gsea_res_high_w6,
                                                                  showCategory = nrow(go_gsea_res_high_w6))
        go_gsea_res_high_w6_map <- emapplot(go_gsea_res_high_w6_dists,
                                            showCategory = nrow(go_gsea_res_high_w6_dists),
                                            color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_high_w6.png"),
               plot = go_gsea_res_high_w6_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(go_gsea_res_low_w8) > 1) {
        go_gsea_res_low_w8_dists <- enrichplot::pairwise_termsim(go_gsea_res_low_w8,
                                                                 showCategory = nrow(go_gsea_res_low_w8))
        go_gsea_res_low_w8_map <- emapplot(go_gsea_res_low_w8_dists,
                                           showCategory = nrow(go_gsea_res_low_w8_dists),
                                           color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_low_w8.png"),
               plot = go_gsea_res_low_w8_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(go_gsea_res_high_w8) > 1) {
        go_gsea_res_high_w8_dists <- enrichplot::pairwise_termsim(go_gsea_res_high_w8,
                                                                  showCategory = nrow(go_gsea_res_high_w8))
        go_gsea_res_high_w8_map <- emapplot(go_gsea_res_high_w8_dists,
                                            showCategory = nrow(go_gsea_res_high_w8_dists),
                                            color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_high_w8.png"),
               plot = go_gsea_res_high_w8_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(go_gsea_res_low_gs45) > 1) {
        go_gsea_res_low_gs45_dists <- enrichplot::pairwise_termsim(go_gsea_res_low_gs45,
                                                                   showCategory = nrow(go_gsea_res_low_gs45))
        go_gsea_res_low_gs45_map <- emapplot(go_gsea_res_low_gs45_dists,
                                             showCategory = nrow(go_gsea_res_low_gs45_dists),
                                             color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_low_gs45.png"),
               plot = go_gsea_res_low_gs45_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(go_gsea_res_high_gs45) > 1) {
        go_gsea_res_high_gs45_dists <- enrichplot::pairwise_termsim(go_gsea_res_high_gs45,
                                                                    showCategory = nrow(go_gsea_res_high_gs45))
        go_gsea_res_high_gs45_map <- emapplot(go_gsea_res_high_gs45_dists,
                                              showCategory = nrow(go_gsea_res_high_gs45_dists),
                                              color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_high_gs45.png"),
               plot = go_gsea_res_high_gs45_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    
    if (nrow(kegg_gsea_res_low_w6) > 1) {
        kegg_gsea_res_low_w6_dists <- enrichplot::pairwise_termsim(kegg_gsea_res_low_w6,
                                                                   showCategory = nrow(kegg_gsea_res_low_w6))
        kegg_gsea_res_low_w6_map <- emapplot(kegg_gsea_res_low_w6_dists,
                                             showCategory = nrow(kegg_gsea_res_low_w6_dists),
                                             color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_low_w6.png"),
               plot = kegg_gsea_res_low_w6_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(kegg_gsea_res_high_w6) > 1) {
        kegg_gsea_res_high_w6_dists <- enrichplot::pairwise_termsim(kegg_gsea_res_high_w6,
                                                                    showCategory = nrow(kegg_gsea_res_high_w6))
        kegg_gsea_res_high_w6_map <- emapplot(kegg_gsea_res_high_w6_dists,
                                              showCategory = nrow(kegg_gsea_res_high_w6_dists),
                                              color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_high_w6.png"),
               plot = kegg_gsea_res_high_w6_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(kegg_gsea_res_low_w8) > 1) {
        kegg_gsea_res_low_w8_dists <- enrichplot::pairwise_termsim(kegg_gsea_res_low_w8,
                                                                   showCategory = nrow(kegg_gsea_res_low_w8))
        kegg_gsea_res_low_w8_map <- emapplot(kegg_gsea_res_low_w8_dists,
                                             showCategory = nrow(kegg_gsea_res_low_w8_dists),
                                             color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_low_w8.png"),
               plot = kegg_gsea_res_low_w8_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(kegg_gsea_res_high_w8) > 1) {
        kegg_gsea_res_high_w8_dists <- enrichplot::pairwise_termsim(kegg_gsea_res_high_w8,
                                                                    showCategory = nrow(kegg_gsea_res_high_w8))
        kegg_gsea_res_high_w8_map <- emapplot(kegg_gsea_res_high_w8_dists,
                                              showCategory = nrow(kegg_gsea_res_high_w8_dists),
                                              color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_high_w8.png"),
               plot = kegg_gsea_res_high_w8_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(kegg_gsea_res_low_gs45) > 1) {
        kegg_gsea_res_low_gs45_dists <- enrichplot::pairwise_termsim(kegg_gsea_res_low_gs45,
                                                                     showCategory = nrow(kegg_gsea_res_low_gs45))
        kegg_gsea_res_low_gs45_map <- emapplot(kegg_gsea_res_low_gs45_dists,
                                               showCategory = nrow(kegg_gsea_res_low_gs45_dists),
                                               color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_low_gs45.png"),
               plot = kegg_gsea_res_low_gs45_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
    if (nrow(kegg_gsea_res_high_gs45) > 1) {
        kegg_gsea_res_high_gs45_dists <- enrichplot::pairwise_termsim(kegg_gsea_res_high_gs45,
                                                                      showCategory = nrow(kegg_gsea_res_high_gs45))
        kegg_gsea_res_high_gs45_map <- emapplot(kegg_gsea_res_high_gs45_dists,
                                                showCategory = nrow(kegg_gsea_res_high_gs45_dists),
                                                color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_high_gs45.png"),
               plot = kegg_gsea_res_high_gs45_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
    }
    
}


