#!/usr/bin/env Rscript

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

library_list <- list("hash","data.table","ggplot2")
load_library_list.function(library_list)

############################################
#             Keywords                     #
############################################

setClass("keyword", slots=list(name="character",type="character", in_out="character", value="character"))
keywords <- hash()
keywords[["CSV_file"]] <- new("keyword",name="CSV_file",type="file", in_out="in", value="./Data_example.csv")
keywords[["Plot_name"]] <- new("keyword",name="Plot_name",type="file", in_out="out", value="Plot.png")
keywords[["x_label"]] <- new("keyword",name="x_label",type="col", in_out="in", value="Resolution")
keywords[["font_size"]] <- new("keyword",name="font_size",type="size", in_out="in", value="14")
set_up_keyword_values.function(keywords,args)

############################################
#             Prepare data                 #
############################################

MyData = read.csv(keywords[["CSV_file"]]@value ,header=TRUE)
MyData <- setnames(MyData,c(check_col.function(keywords[["x_label"]]@value,MyData)),c("x_label" ))


############################################
#             Create plot                  #
############################################

png(keywords[["Plot_name"]]@value, units="in", width=7, height=5, res=1000)

ggplot(MyData, aes(x=as.factor(MyData$x_label)))+geom_bar(stat="count", color="black",fill="#56B4E9") +theme(axis.line = element_line(colour="black"),panel.background = element_blank() ,panel.border = element_rect(colour = "black", fill=NA)) + labs(x = keywords[["x_label"]]@value , y="Number of data sets") +theme(axis.text=element_text(size=keywords[["font_size"]]@value),axis.title=element_text(size=keywords[["font_size"]]@value))+theme(legend.spacing.x = unit(0.05, 'cm'))+ theme(legend.text=element_text(size=keywords[["font_size"]]@value))+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

invisible(capture.output(dev.off()))

if(file.exists(keywords[["Plot_name"]]@value))
print("Plot was created!")
