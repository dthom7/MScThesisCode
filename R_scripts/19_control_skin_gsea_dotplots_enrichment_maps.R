# 19_control_skin_gsea_dotplots_enrichment_maps.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

control_skin_gsea_dotplots_enrichment_maps <-
    function(go_gsea_res_control_t2_vs_t1,
             go_gsea_res_control_t3_vs_t2,
             go_gsea_res_control_t3_vs_t1,
             kegg_gsea_res_control_t2_vs_t1,
             kegg_gsea_res_control_t3_vs_t2,
             kegg_gsea_res_control_t3_vs_t1,
             output_dir) {
        
        go_dotplot_control_t2_vs_t1 <- dotplot(go_gsea_res_control_t2_vs_t1,
                                               showCategory = 20,
                                               orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_control_t2_vs_t1.png"),
               plot = go_dotplot_control_t2_vs_t1,
               height = 11,
               width = 9)
        
        go_dotplot_control_t3_vs_t2 <- dotplot(go_gsea_res_control_t3_vs_t2,
                                               showCategory = 20,
                                               orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_control_t3_vs_t2.png"),
               plot = go_dotplot_control_t3_vs_t2,
               height = 11,
               width = 9)
        
        go_dotplot_control_t3_vs_t1 <- dotplot(go_gsea_res_control_t3_vs_t1,
                                               showCategory = 20,
                                               orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/go_dotplot_control_t3_vs_t1.png"),
               plot = go_dotplot_control_t3_vs_t1,
               height = 11,
               width = 9)
        
        kegg_dotplot_control_t2_vs_t1 <- dotplot(kegg_gsea_res_control_t2_vs_t1,
                                                 showCategory = 20,
                                                 orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_control_t2_vs_t1.png"),
               plot = kegg_dotplot_control_t2_vs_t1,
               height = 11,
               width = 9)
        
        kegg_dotplot_control_t3_vs_t2 <- dotplot(kegg_gsea_res_control_t3_vs_t2,
                                                 showCategory = 20,
                                                 orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_control_t3_vs_t2.png"),
               plot = kegg_dotplot_control_t3_vs_t2,
               height = 11,
               width = 9)
        
        kegg_dotplot_control_t3_vs_t1 <- dotplot(kegg_gsea_res_control_t3_vs_t1,
                                                 showCategory = 20,
                                                 orderBy = "p.adjust") +
            facet_grid(.~.sign)
        ggsave(paste0(output_dir, "/kegg_dotplot_control_t3_vs_t1.png"),
               plot = kegg_dotplot_control_t3_vs_t1,
               height = 11,
               width = 9)
        
        go_gsea_res_control_t2_vs_t1_dists <-
            enrichplot::pairwise_termsim(go_gsea_res_control_t2_vs_t1,
                                         showCategory = nrow(go_gsea_res_control_t2_vs_t1))
        go_gsea_res_control_t2_vs_t1_map <- emapplot(go_gsea_res_control_t2_vs_t1_dists,
                                                     showCategory = nrow(go_gsea_res_control_t2_vs_t1_dists),
                                                     color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_control_t2_vs_t1.png"),
               plot = go_gsea_res_control_t2_vs_t1_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 3)
        
        go_gsea_res_control_t3_vs_t2_dists <-
            enrichplot::pairwise_termsim(go_gsea_res_control_t3_vs_t2,
                                         showCategory = nrow(go_gsea_res_control_t3_vs_t2))
        go_gsea_res_control_t3_vs_t2_map <- emapplot(go_gsea_res_control_t3_vs_t2_dists,
                                                     showCategory = nrow(go_gsea_res_control_t3_vs_t2_dists),
                                                     color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_control_t3_vs_t2.png"),
               plot = go_gsea_res_control_t3_vs_t2_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
        
        go_gsea_res_control_t3_vs_t1_dists <-
            enrichplot::pairwise_termsim(go_gsea_res_control_t3_vs_t1,
                                         showCategory = nrow(go_gsea_res_control_t3_vs_t1))
        go_gsea_res_control_t3_vs_t1_map <- emapplot(go_gsea_res_control_t3_vs_t1_dists,
                                                     showCategory = nrow(go_gsea_res_control_t3_vs_t1_dists),
                                                     color = "NES")
        ggsave(paste0(output_dir, "/map_go_gsea_res_control_t3_vs_t1.png"),
               plot = go_gsea_res_control_t3_vs_t1_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
        
        kegg_gsea_res_control_t2_vs_t1_dists <-
            enrichplot::pairwise_termsim(kegg_gsea_res_control_t2_vs_t1,
                                         showCategory = nrow(kegg_gsea_res_control_t2_vs_t1))
        kegg_gsea_res_control_t2_vs_t1_map <- emapplot(kegg_gsea_res_control_t2_vs_t1_dists,
                                                     showCategory = nrow(kegg_gsea_res_control_t2_vs_t1_dists),
                                                     color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_control_t2_vs_t1.png"),
               plot = kegg_gsea_res_control_t2_vs_t1_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
        
        kegg_gsea_res_control_t3_vs_t2_dists <-
            enrichplot::pairwise_termsim(kegg_gsea_res_control_t3_vs_t2,
                                         showCategory = nrow(kegg_gsea_res_control_t3_vs_t2))
        kegg_gsea_res_control_t3_vs_t2_map <- emapplot(kegg_gsea_res_control_t3_vs_t2_dists,
                                                     showCategory = nrow(kegg_gsea_res_control_t3_vs_t2_dists),
                                                     color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_control_t3_vs_t2.png"),
               plot = kegg_gsea_res_control_t3_vs_t2_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
        
        kegg_gsea_res_control_t3_vs_t1_dists <-
            enrichplot::pairwise_termsim(kegg_gsea_res_control_t3_vs_t1,
                                         showCategory = nrow(kegg_gsea_res_control_t3_vs_t1))
        kegg_gsea_res_control_t3_vs_t1_map <- emapplot(kegg_gsea_res_control_t3_vs_t1_dists,
                                                     showCategory = nrow(kegg_gsea_res_control_t3_vs_t1_dists),
                                                     color = "NES")
        ggsave(paste0(output_dir, "/map_kegg_gsea_res_control_t3_vs_t1.png"),
               plot = kegg_gsea_res_control_t3_vs_t1_map,
               width = 7,
               height = 7,
               units = "in",
               scale = 2)
        
    }
        
        
        