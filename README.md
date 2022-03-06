# A bunch of R scripts
These R scripts are those that I used to visualise the results in my research papers. For each script, I show an example of data structure, a produced plot and the command line with parameters, if any, to run the script from the command line. The scripts are free and ready to use.      

## Script 1 (line plot)
<p align="center">
<img src="Scripts/Script1/Plot_example.png" alt="drawing" width="400"/>
</p>

- Command line
```
Rscript Script1.r -CSV_file Data_example.csv
```
- Command line keywords


  
| keyword | Description | Default value |
| ------ | ----------- |-----------  |
| -CSV_file   | Path to CSV file. | Data_example.csv |
| -Plot_name | Created plot name | Plot.png |
| -x_label    |  a column name in the CSV file to use for x axis  | Resolution  |
| -y_label    |  a column name in the CSV file to use for y axis | Completness |
| -group_label    |   a column name in the CSV file to group the data  | Pipeline |
| -font_size    |   x and y axis labels fonts size  | 14 |

<a href="/Scripts/Script1/Script1.r" > - Download the script </a>

<a href="/Scripts/Script1/Data_example.csv" > - Download the data example </a>

## Script 2 (histogram plot)
<p align="center">
<img src="Scripts/Script2/Plot_example.png" alt="drawing" width="400"/>
</p>

- Command line
```
Rscript Script2.r -CSV_file Data_example.csv
```
- Command line keywords


  
| keyword | Description | Default value |
| ------ | ----------- |-----------  |
| -CSV_file   | Path to CSV file. | Data_example.csv |
| -Plot_name | Created plot name | Plot.png |
| -x_label    |  a column name in the CSV file to use for x axis  | Resolution  |
| -font_size    |   x axis labels fonts size  | 14 |

<a href="/Scripts/Script2/Script2.r" > - Download the script </a>

<a href="/Scripts/Script2/Data_example.csv" > - Download the data example </a>


## Script 3 (bar plots grid)
<p align="center">
<img src="Scripts/Script3/Plot_example.png" alt="drawing" width="400"/>
</p>

- Command line
```
Rscript Script3.r -CSV_file Data_example.csv
```
- Command line keywords


  
| keyword | Description | Default value |
| ------ | ----------- |-----------  |
| -CSV_file   | Path to CSV file. | Data_example.csv |
| -Plot_name | Created plot name | Plot.png |
| -x_label    |  a column name in the CSV file to use for x axis  | CompareTo  |
| -y_label    |  a column name in the CSV file to use for y axis | Percentage |
| -group_label    |   a column name in the CSV file to group the data  | Pipeline |
| -font_size    |   y axis labels fonts size  | 14 |

<a href="/Scripts/Script3/Script3.r" > - Download the script </a>

<a href="/Scripts/Script3/Data_example.csv" > - Download the data example </a>


## Script 4 (inset line plot)
<p align="center">
<img src="Scripts/Script4/Plot_example.png" alt="drawing" width="400"/>
</p>

- Command line
```
Rscript Script4.r -CSV_file Data_example.csv
```
- Command line keywords


  
| keyword | Description | Default value |
| ------ | ----------- |-----------  |
| -CSV_file   | Path to CSV file. | Data_example.csv |
| -Plot_name | Created plot name | Plot.png |
| -x_label    |  a column name in the CSV file to use for x axis  | bin  |
| -y_label    |  a column name in the CSV file to use for y axis | Completness |
| -group_label    |   a column name in the CSV file to group the data  | Pipeline |
| -font_size    |   x and y axis labels fonts size  | 14 |

To hide a line in the inset plot, set the alpha value for the corresponding line to zero in the plot (g2) in the script. 
```
scale_alpha_manual(values = c(0, 0, 0, 0,1, 1, 0, 0,1, 0, 1, 1,0))
```
<a href="/Scripts/Script4/Script4.r" > - Download the script </a>

<a href="/Scripts/Script4/Data_example.csv" > - Download the data example </a>



## Citing
```
@software{A_bunch_of_R_scripts,
  author = {Alharbi,Emad},
  doi = {},
  month = {03},
  title = {{A bunch of R scripts}},
  url = {https://github.com/E-Alharbi/rscript-bunch},
  year = {2022}
}
```
