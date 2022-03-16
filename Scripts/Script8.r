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
keywords[["x_label"]] <- new("keyword",name="x_label",type="col", in_out="in", value="Loss_value")


keywords[["group_data"]] <- new("keyword",name="secondary_x_label",type="col", in_out="in", value="Structure_evaluation")

keywords[["font_size"]] <- new("keyword",name="font_size",type="size", in_out="in", value="14")



set_up_keyword_values.function(keywords,args)

############################################
#             Prepare data                 #
############################################
MyData=read.csv(keywords[["CSV_file"]]@value)

MyData <- setnames(MyData,c(check_col.function(keywords[["x_label"]]@value,MyData),check_col.function(keywords[["group_data"]]@value,MyData)),c("x_label","group_data"))


y_labels <- table(MyData$x_label)
y_labels <- (y_labels*100)/length(MyData$x_label)


max_yCom = max(max(y_labels))
max_yCom = max(pretty(c(0,max(max(y_labels)))))
max_xCom=max(MyData$x_label)


############################################
#             Create plot                  #
############################################

png(keywords[["Plot_name"]]@value, units="in", width=8, height=4, res=1000)

ggplot(MyData, aes(MyData$x_label,fill =MyData$group_data,color="Cumulative percentage")) + geom_bar(aes(y = (..count..)*100/sum(..count..)), colour="black" ,position="dodge") + labs(y = "Percentage of data sets",x=keywords[["x_label"]]@value,size=5)+theme(axis.line = element_line(colour = "black"),
panel.grid.major = element_blank(),
panel.grid.minor = element_blank(),
panel.border = element_blank(),
panel.background = element_blank()) +scale_fill_manual(values="#0073C2FF")+ theme(legend.position = c(0.90, 0.62))+ theme(legend.title = element_blank())  +theme(panel.margin=unit(.05, "lines"),
panel.border = element_rect(color = "black", fill = NA, size = 0.5),
strip.background = element_rect(color = "black", size = 0.5))+     stat_ecdf(aes_(y=bquote(..y.. * .(max_yCom))),geom = "line") +
scale_y_continuous(sec.axis=sec_axis(trans = ~./max_yCom, name="percentage",labels=scales::percent_format(suffix = "")))+ scale_x_continuous(breaks = seq(0, max_xCom, by = 1),expand = c(0.01,0)) +theme(text = element_text(size=8)) +scale_color_manual(name = "Y series", values = c("Cumulative percentage" = "black"))+theme(legend.key = element_rect(fill = NA))+theme(
legend.spacing.y = unit(0.001, 'cm'))+theme(
legend.spacing.x = unit(0.07, 'cm'))+ theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))



invisible(capture.output(dev.off()))

if(file.exists(keywords[["Plot_name"]]@value))
print("Plot was created!")


