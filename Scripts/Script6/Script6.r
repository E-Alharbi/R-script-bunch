#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)


############################################
#         Download utilities.r             #
############################################

utilities_file="utilities.r"
if(!file.exists(utilities_file)){
    print (paste0(utilities_file," not found. We will download from rscript-bunch repository.
"))
download.file("https://raw.githubusercontent.com/E-Alharbi/R-script-bunch/main/utilities.r", utilities_file,method='curl')

}

############################################
#  Load libraies and set up env options    #
############################################

source(utilities_file)
set_up_env_options.function()


library_list <- list("hash","ggrepel","grid","gtable","data.table")
load_library_list.function(library_list)

############################################
#             Keywords                     #
############################################

setClass("keyword", slots=list(name="character",type="character", in_out="character", value="character"))
keywords <- hash()
keywords[["CSV_file"]] <- new("keyword",name="CSV_file",type="file", in_out="in", value="./Data_example.csv")
keywords[["Plot_name"]] <- new("keyword",name="Plot_name",type="file", in_out="out", value="Plot.png")
keywords[["x_label"]] <- new("keyword",name="x_label",type="col", in_out="in", value="Structure_evaluation")
keywords[["y_label"]] <- new("keyword",name="y_label",type="col", in_out="in", value="Feature")
keywords[["secondary_y_label_1"]] <- new("keyword",name="secondary_y_label_1",type="col", in_out="in", value="Error_matrix")
keywords[["secondary_y_label_2"]] <- new("keyword",name="secondary_y_label_2",type="col", in_out="in", value="Dataset")
keywords[["secondary_x_label"]] <- new("keyword",name="secondary_x_label",type="col", in_out="in", value="Pipeline")
keywords[["fill_value"]] <- new("keyword",name="fill_value",type="col", in_out="in", value="Difference_from_base_model")

keywords[["font_size"]] <- new("keyword",name="font_size",type="size", in_out="in", value="3")


keywords[["round_places"]] <- new("keyword",name="round_places",type="size", in_out="in", value="5")
set_up_keyword_values.function(keywords,args)

############################################
#             Prepare data                 #
############################################
MyData = read.csv(keywords[["CSV_file"]]@value ,header=TRUE)

MyData <- setnames(MyData,c(check_col.function(keywords[["secondary_x_label"]]@value,MyData),check_col.function(keywords[["x_label"]]@value,MyData),check_col.function(keywords[["secondary_y_label_1"]]@value,MyData),check_col.function(keywords[["fill_value"]]@value,MyData),check_col.function(keywords[["y_label"]]@value,MyData),check_col.function(keywords[["secondary_y_label_2"]]@value,MyData)),c("secondary_x_label","x_label","secondary_y_label_1","fill_value","y_label","secondary_y_label_2"))

options(scipen = 999)
 
############################################
#             Validate CSV                 #
############################################

if(length(unique(MyData$secondary_y_label_2)) > 2){
    stop(paste0(" Number of unique values is more than two in  ",keywords[["secondary_y_label_2"]]@value))
}
if(length(unique(MyData$secondary_y_label_1)) > 2){
    stop(paste0(" Number of unique values is more than two in  ",keywords[["secondary_y_label_1"]]@value))
}

############################################
#             Create plot                  #
############################################

png(keywords[["Plot_name"]]@value, units="in", width=10, height=6, res=1000)


p <- ggplot(MyData, aes( MyData$x_label,MyData$y_label,  fill= MyData$fill_value ,label =MyData$y_label)) + geom_tile( colour = "black") + scale_fill_gradient(low="white", high="red",guide = guide_colorbar(label = TRUE,frame.colour = "black",)) + facet_grid( secondary_y_label_2 ~ MyData$secondary_y_label_1~MyData$secondary_x_label,scale="free",labeller = labeller(secondary_y_label_2 = function(x) {rep("", length(x))})) + geom_text(data = MyData, aes(label = round(MyData$fill_value,as.numeric(keywords[["round_places"]]@value))),  size=as.numeric(keywords[["font_size"]]@value)) + theme(panel.background = element_rect(fill =  NA, colour = 'black')) + labs(y = keywords[["y_label"]]@value,x=keywords[["x_label"]]@value,size=as.numeric(keywords[["font_size"]]@value)) + theme(legend.title=element_blank())+ theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust=1))




label_list <- unique(MyData$secondary_y_label_2)

labelR = label_list[1]
labelR2 = label_list[2]


z <- ggplotGrob(p)


posR <- subset(z$layout, grepl("strip-r", name), select = t:r)
posT <- subset(z$layout, grepl("strip-t", name), select = t:r)


width <- z$widths[max(posR$r)]
height <- z$heights[min(posT$t)]

z <- gtable_add_cols(z, width, max(posR$r))
z <- gtable_add_rows(z, height, min(posT$t)-1)


stripR <- gTree(name = "Strip_right", children = gList(
   rectGrob(gp = gpar(col = NA, fill = "grey85")),
   textGrob(labelR, rot = -90, gp = gpar(fontsize = 8.8, col = "grey10"))))

stripR2 <- gTree(name = "Strip_right", children = gList(
   rectGrob(gp = gpar(col = NA, fill = "grey85")),
   textGrob(labelR2, rot = -90, gp = gpar(fontsize = 8.8, col = "grey10"))))


z <- gtable_add_grob(z, stripR, t = min(posR$t)+1, l = max(posR$r) + 1, b = max(posR$b)-3, name = "strip-right")

z <- gtable_add_grob(z, stripR2, t = min(posR$t)+5, l = max(posR$r) + 1, b = max(posR$b)+1, name = "strip-right2")



z <- gtable_add_cols(z, unit(1/5, "line"), max(posR$r))



grid.newpage()
grid.draw(z)
invisible(capture.output(dev.off()))

if(file.exists(keywords[["Plot_name"]]@value))
print("Plot was created!")

