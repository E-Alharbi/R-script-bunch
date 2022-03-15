#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

############################################
#         Download utilities.r             #
############################################

utilities_file="utilities.r"
if(!file.exists(utilities_file)){
    print (paste0(utilities_file," not found. We will download from rscript-bunch repository.
"))
download.file("https://raw.githubusercontent.com/E-Alharbi/rscript-bunch/main/utilities.r", utilities_file,method='curl')

}

############################################
#  Load libraies and set up env options    #
############################################

source(utilities_file)
set_up_env_options.function()


library_list <- list("hash","ggplot2","data.table")
load_library_list.function(library_list)


############################################
#             Keywords                     #
############################################

setClass("keyword", slots=list(name="character",type="character", in_out="character", value="character"))
keywords <- hash()
keywords[["CSV_file"]] <- new("keyword",name="CSV_file",type="file", in_out="in", value="./Data_example.csv")
keywords[["Plot_name"]] <- new("keyword",name="Plot_name",type="file", in_out="out", value="Plot.png")
keywords[["x_label"]] <- new("keyword",name="x_label",type="col", in_out="in", value="Pipeline")
keywords[["y_label"]] <- new("keyword",name="y_label",type="col", in_out="in", value="Difference")
keywords[["secondary_y_label"]] <- new("keyword",name="secondary_y_label_1",type="col", in_out="in", value="Evaluation_measure")
keywords[["secondary_x_label"]] <- new("keyword",name="secondary_x_label",type="col", in_out="in", value="dataset")
keywords[["group_data"]] <- new("keyword",name="secondary_x_label",type="col", in_out="in", value="predictive_model")

keywords[["font_size"]] <- new("keyword",name="font_size",type="size", in_out="in", value="14")



set_up_keyword_values.function(keywords,args)

############################################
#             Prepare data                 #
############################################
 calc_stat <- function(x) {
     coef <- 1.5
     n <- sum(!is.na(x))
     # calculate quantiles
     stats <- quantile(x, probs = c(0.1, 0.25, 0.5, 0.75, 0.9))
     names(stats) <- c("ymin", "lower", "middle", "upper", "ymax")
     return(stats)
 }


MyData = read.csv(keywords[["CSV_file"]]@value ,header=TRUE,row.names=NULL)

MyData <- setnames(MyData,c(check_col.function(keywords[["y_label"]]@value,MyData),check_col.function(keywords[["x_label"]]@value,MyData),check_col.function(keywords[["secondary_y_label"]]@value,MyData),check_col.function(keywords[["group_data"]]@value,MyData),check_col.function(keywords[["secondary_x_label"]]@value,MyData)),c("y_label","x_label","secondary_y_label","group_data","secondary_x_label"))



png(keywords[["Plot_name"]]@value, units="in", width=8, height=4, res=1000)

ggplot(MyData, aes(x=MyData$x_label, y=MyData$y_label, fill=MyData$group_data)) +geom_hline(aes(yintercept=0),linetype='dashed',size=0.2)+geom_hline(aes(yintercept=10),linetype='dashed',size=0.2)+geom_hline(aes(yintercept=-10),linetype='dashed',size=0.2)+
    stat_summary(fun.data = calc_stat, geom="boxplot",position=position_dodge(width=0.90),lwd=0.15,width=0.6) +
    facet_grid(MyData$secondary_y_label ~ MyData$secondary_x_label, scales="free_y")+ theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+ theme(panel.background = element_rect(fill = 'white', colour = 'black'))  + labs(fill = "") +xlab(keywords[["x_label"]]@value) + ylab(keywords[["y_label"]]@value)+ theme(legend.position = c(0.75, 0.26))+
    theme(legend.direction = "horizontal",
          legend.box = "horizontal") +
    guides(size=guide_legend(direction='horizontal'))+ guides(colour = guide_legend(nrow = 1))+guides(fill=guide_legend(nrow=1,byrow=TRUE))+theme(text = element_text(size=6))+theme(panel.border = element_rect(colour = "black", fill=NA, size=0.5)) + theme(
legend.title = element_text(color = "blue", size = keywords[["font_size"]]@value),
legend.text = element_text(color = "black", size = 4)
)+ guides(fill = guide_legend(override.aes = list(size=0.3))) +theme(legend.key.size = unit(0.3, "cm"))+theme(legend.background = element_rect(fill = "transparent")) +theme(legend.key = element_rect(fill = "transparent"))+guides(fill=guide_legend(nrow=1,byrow=TRUE))+theme(
legend.spacing.y = unit(0.01, 'cm'))+theme(
legend.spacing.x = unit(0.07, 'cm'))

invisible(capture.output(dev.off()))

if(file.exists(keywords[["Plot_name"]]@value))
print("Plot was created!")
