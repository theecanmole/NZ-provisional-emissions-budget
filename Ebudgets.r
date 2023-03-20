Emissions budgets

# https://www.beehive.govt.nz/release/emission-trading-reforms-another-step-meeting-climate-targets	 2 June 2020
# Emission trading reforms another step to meeting climate targets
# https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf
# page 2 "An emissions budget is the total volume of emissions New Zealand is allowed to emit over a period of time."
# page 2 "The provisional emissions budget has been set at 354 million tonnes of CO2 equivalent greenhouse gasses for the 2021-2025 period."
# page 2 "Unit cap: The emissions budget guides the limit or ‘cap’ on the number of units that will be supplied to the NZ ETS market (excluding forestry units). The cap is the remaining number of units left after emissions not covered by the NZ ETS are removed, including agriculture, some of the waste sector, some of the forestry sector and gases covered by the greenhouse gas levy."

https://environment.govt.nz/what-government-is-doing/areas-of-work/climate-change/ets/nz-ets-market/setting-unit-limits-in-the-nz-ets/#figure-2-breakdown-of-the-provisional-emissions-budget-volume-and-nz-ets-limit

# load package
library(RColorBrewer) 

# Create matrix as three steps; 1 matrix of data and rows and cols, 2 colnames,  3 rownames
# the total of the 5 year budget is 354 million tonnes of emissions
# see Figure on page 3 of NZETS%20Q%26A.pdf
# see table on page 2 of Q&A
# enter the individual portions of the budgets

stockpile <-c(5.4, 5.4, 5.4, 5.4, 5.4 )
auction <-c(19, 19.3, 18.6, 17.2, 15.5)
allocation <-c(8.4, 8.2, 8.9, 8.7, 8.7)
outsideets <-c(rep(38.8,5))
# add up the slices of the emissions budget
budget <- stockpile + auction + allocation + outsideets 
budget
[1] 71.6 71.7 71.7 70.1 68.4
sum(budget) 
[1] 353.5 

budgetmat <- matrix(budget, nrow = 1, ncol=5,byrow=TRUE)    
colnames(budgetmat) <- c("2021","2022","2023","2024","2025")
rownames(budgetmat) <- c("Emissions budget")

budgetmat 
                2021 2022 2023 2024 2025
Emissions budget 71.6 71.7 71.7 70.1 68.4 

svg(filename="Emissions-budget1-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
#png("Emissions-budget1-560by420.png", bg="white", width=560, height=420,pointsize = 14)
#png("Emissions-budget1-600by450.png", bg="white", width=600, height=450,pointsize = 12)
#png("Emissions-budget1-720by540.png", bg="white", width=720, height=540,pointsize = 16)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat,ylim=c(0,75),las=1,space=0, beside = FALSE, col=c("#1D556C")) #  colour is blumine 
mtext(side=1,line=2.5,cex=0.9,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf")))
legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Emissions budget = 354 million tonnes") , fill = c("#2D9886"))
mtext(side=2,cex=1, line=2.3,expression(paste("million tonnes of emissions")))
mtext(side=4,cex=0.85, line=-0.5,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Provisional emissions budget 2021 to 2025")) )
dev.off() 

# define the annual 'cap', the annual limit or target implied by the emission budget, that I want to high light in a reddish color
ab <- c(1,1,1,1,1)
ab

# take ab (the annual cap) off the budget 
netbudget <- budget - ab
netbudget 
[1] 70.6 70.7 70.7 69.1 67.4 
# creatre matrix that is the 5 year emission budget (area) and the annual 'cap' in red
budgetmat2 <- matrix(c(netbudget,ab), nrow = 2, ncol=5,byrow=TRUE)    
colnames(budgetmat2) <- c("2021","2022","2023","2024","2025")
rownames(budgetmat2) <- c("Five year emissions budget 354m","Cap on annual emissions")

# or budgetmat2 <- matrix(c(netbudget,ab ), nrow = 2, ncol=5, byrow=TRUE, dimnames = list(c("Five year emissions budget 354mt,"Cap on annual emissions"), c("2021","2022","2023","2024","2025")))

budgetmat2 
Five year emissions budget 354mt 70.6 70.7 70.7 69.1 67.4
Cap on annual emissions           1.0  1.0  1.0  1.0  1.0 

svg(filename="Emissions-budget2-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
png("Emissions-budget2-560by420.png", bg="white", width=560, height=420,pointsize = 14)
#png("Emissions-budget2-600by450.png", bg="white", width=600, height=450,pointsize = 12)
#png("Emissions-budget2-720by540.png", bg="white", width=720, height=540,pointsize = 16)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat2,ylim=c(0,75),las=1,space=0, beside = FALSE, col=c("#1D556C","#FF4700")) #blumine and Red-Orange 
mtext(side=1,line=2.5,cex=0.9,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf")))
legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Total five year emissions budget 354 million tonnes","Annual emissions caps; (72, 72, 72, 70, 68 mt)") , fill = c("#1D556C","#FF4700"))
mtext(side=2,cex=1, line=2.3,expression(paste("million tonnes of emissions")))
mtext(side=4,cex=0.85, line=-0.5,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Provisional emissions budgets 2021 to 2025")) )
dev.off()

# lets now flip the colours of the annual caps and remaining emissions budget to allocate to auctions
https://environment.govt.nz/what-government-is-doing/areas-of-work/climate-change/ets/nz-ets-market/setting-unit-limits-in-the-nz-ets/#the-number-of-nzus-available-for-auction-over-2021-2027
#Calculating NZUs available at NZ ETS auctions
# The overall limits are reached by following a series of steps to determine the total number of NZUs that will be available for sale at NZ ETS auctions.
# We start with the total volume of the emissions budget, then: Forecast emissions from outside of the scheme are removed to calculate the NZ ETS overall limit.

svg(filename="Emissions-budget3-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
#png("Emissions-budget3-560by420.png", bg="white", width=560, height=420,pointsize = 14)
#png("Emissions-budget3-600by450.png", bg="white", width=600, height=450,pointsize = 12)
#png("Emissions-budget3-720by540.png", bg="white", width=720, height=540,pointsize = 16)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat2,ylim=c(0,75),las=1,space=0, beside = FALSE, col=c("#1D556C","#FF4700")) #blumine and Red-Orange 
mtext(side=1,line=2.5,cex=0.9,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf")))
legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Emissions budget/annual caps 354m","Volume of emission units to auction? 354m") , fill = c("#FF4700","#1D556C"))
mtext(side=2,cex=1, line=2.3,expression(paste("million tonnes of emissions")))
mtext(side=4,cex=0.85, line=-0.5,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Provisional emissions budgets 2021 to 2025")) )
dev.off() 


# so is the budget auctioned? No. Why not? We have to account for the design flaws in the ETS, 1 exemption - not in ETS (Agriculture), 2 excessive allocation of free units to emitters 3 excessive availability of privately owned units 'the stockpile"
sum(outsideets)
[1] 194
# subtract agriculture from budget = 'available' emissions to auction
available1 <- netbudget - outsideets
# how many tonnes in 'available'
sum(available1)
[1] 154.5 

budgetmat3 <- matrix(c(available1, outsideets,ab), nrow = 3, ncol=5,byrow=TRUE)    
colnames(budgetmat3) <- c("2021","2022","2023","2024","2025")
rownames(budgetmat3) <- c( "Available emission units","Emissions outside NZETS","Cap on annual emissions")
# print budgetmat3
budgetmat3

                         2021 2022 2023 2024 2025
Available emission units 31.8 31.9 31.9 30.3 28.6
Emissions outside NZETS  38.8 38.8 38.8 38.8 38.8
Cap on annual emissions   1.0  1.0  1.0  1.0  1.0

# check the colours I took from the chart in the NZETS Q&A 

# "#1D556C" Blumine,"#ED7F30" Jaffa,"#2D9886" Lochinvar,"#919390" Stack
slices <- c(1,1,1,1)
names(slices) <- c("#1D556C Blumine","#ED7F30 Jaffa","#2D9886 Lochinvar","#919390 Stack")
svg(filename="colors-peb-chart-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
pie (slices, radius=1,col=c("#1D556C","#ED7F30","#2D9886","#919390")) 
dev.off() 

barplot (slices, col=c("#1D556C","#ED7F30","#2D9886","#919390")) 
# works ok 

#svg(filename="Emissions-budget4-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
png("Emissions-budget4-560by420.png", bg="white", width=560, height=420,pointsize = 14)
#png("Emissions-budget4-600by450.png", bg="white", width=600, height=450,pointsize = 12)
#png("Emissions-budget4-720by540.png", bg="white", width=720, height=540,pointsize = 16)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat3,ylim=c(0,75),las=1,space=0, beside = FALSE, col=c("#2D9886","#1D556C","#FF4700")) 
mtext(side=1,line=2.5,cex=0.9,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/020-06/NZETS%20Q%26A.pdf")))
legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Cap on annual emissions 354m","- Agriculture emissions outside NZETS 194m", "= Remaining units to auction 160m") , fill = c("#FF4700","#1D556C","#2D9886"))
mtext(side=2,cex=1, line=2.3,expression(paste("million tonnes of emissions")))
mtext(side=4,cex=0.85, line=-0.5,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Provisional emissions budgets 2021 to 2025")) )
dev.off()

# calculate the available/remaining units to auction after deducting industrial (free) allocation of units to emitters

available2 <- available1 - allocation
sum(allocation)
[1] 42.9
available2 
[1] 24.4 24.7 24.0 22.6 20.9
sum(available2) 
[1] 116.6 

budgetmat4 <- matrix(c(available2, allocation, outsideets,ab), nrow = 4, ncol=5,byrow=TRUE)    
colnames(budgetmat4) <- c("2021","2022","2023","2024","2025")
rownames(budgetmat4) <- c( "Available emission units","Industrial allocation units","Emissions outside NZETS","Cap on annual emissions")
# print budgetmat4
budgetmat4
                           2021 2022 2023 2024 2025
Available emission units    23.4 23.7 23.0 21.6 19.9
Industrial allocation units  8.4  8.2  8.9  8.7  8.7
Emissions outside NZETS     38.8 38.8 38.8 38.8 38.8
Cap on annual emissions      1.0  1.0  1.0  1.0  1.0                           

#svg(filename="Emissions-budget5-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
png("Emissions-budget5-560by420.png", bg="white", width=560, height=420,pointsize = 14)
#png("Emissions-budget5-600by450.png", bg="white", width=600, height=450,pointsize = 12)
#png("Emissions-budget5-720by540.png", bg="white", width=720, height=540,pointsize = 16)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat4,ylim=c(0,75),las=1,space=0, beside = FALSE, col=c("#2D9886","#ED7F30","#1D556C","#FF4700")) 
mtext(side=1,line=2.5,cex=0.9,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf")))
legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Cap on annual emissions 354m","- Agriculture emissions outside NZETS 194m","- Industrial allocation units 43m", "= Remaining units to auction 117m"), fill = c("#FF4700","#1D556C", "#ED7F30","#2D9886"))
mtext(side=2,cex=1, line=2.3, expression(paste("million tonnes of emissions")))
mtext(side=4,cex=0.85, line=-0.5,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Provisional emissions budgets 2021 to 2025")) )
dev.off()

# calculate available units to auction after subtracting units for 'stockpile reduction'
available3 <- available2 - stockpile
available3
[1] 18.0 18.3 17.6 16.2 14.5 
sum(available3) 
 [1] 84.6
sum(stockpile)
[1] 27 

# create matrix
budgetmat5 <- matrix(c(available3, stockpile, allocation, outsideets,ab), nrow = 5, ncol=5,byrow=TRUE)    
colnames(budgetmat5) <- c("2021","2022","2023","2024","2025")
rownames(budgetmat5) <- c("Available emission units","Stockpile reduction","Industrial allocation units","Emissions outside NZETS","Cap on annual emissions")
# print budgetmat5
budgetmat5
                            2021 2022 2023 2024 2025
Available emission units    18.0 18.3 17.6 16.2 14.5
Stockpile reduction          5.4  5.4  5.4  5.4  5.4
Industrial allocation units  8.4  8.2  8.9  8.7  8.7
Emissions outside NZETS     38.8 38.8 38.8 38.8 38.8
Cap on annual emissions      1.0  1.0  1.0  1.0  1.0

#svg(filename="Emissions-budget6-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
png("Emissions-budget6-560by420.png", bg="white", width=560, height=420,pointsize = 14)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat5,ylim=c(0,75),las=1,space=0, beside = FALSE, col=c("#2D9886","#919390","#ED7F30","#1D556C", "#FF4700"))
mtext(side=1,line=2.5,cex=0.9,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf")))
legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Cap on annual emissions 354m","- Agriculture emissions outside NZETS 194m","- Industrial allocation units 43m", "- Stockpile reduction units 27m", "= Remaining units for auctions 90m") , fill = c("#FF4700", "#1D556C", "#ED7F30", "#919390", "#2D9886"))
mtext(side=2,cex=1, line=2.3,expression(paste("million tonnes of emissions")))
mtext(side=4,cex=0.85, line=-0.5,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Provisional emissions budget 2021 to 2025")) )
dev.off()

 

# make a matrix of the emissions subtracted out of budget to get to auction units
budgetmat6 <- matrix(c(outsideets,allocation,stockpile), nrow = 3, ncol=5,byrow=TRUE)    
colnames(budgetmat6) <- c("2021","2022","2023","2024","2025")
rownames(budgetmat6) <- c("Emissions outside NZETS","Industrial allocation units", "Stockpile reduction units")
# print datamat
budgetmat6
                            2021 2022 2023 2024 2025
Emissions outside NZETS     38.8 38.8 38.8 38.8 38.8
Industrial allocation units  8.4  8.2  8.9  8.7  8.7
Stockpile reduction units    5.4  5.4  5.4  5.4  5.4 
sum(budgetmat6)
[1] 263.9
# chart of agriculture + allocation + stockpile reduction units = emissions not priced via ETS or emissions budget
svg(filename="Emissions-budget7-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
#png("Emissions-budget7-560by420.png", bg="white", width=560, height=420,pointsize = 12)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat6,ylim=c(0,53),las=1,space=0, beside = FALSE, col=c("#1D556C","#ED7F30","#919390")) # blumine jaffa stack cols
mtext(side=1,line=2.5,cex=1,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf")))
legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Stockpile reduction 27m", "Free industrial allocation 43m", "Emissions outside NZETS 194m") , fill = c("#919390","#ED7F30","#1D556C"))
mtext(side=2,cex=1, line=2.3, expression(paste("million tonnes of emissions")))
mtext(side=4,cex=0.85, line=0.05,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Emissions of 264m are not priced in emissions budget")) )
dev.off() 

sum(auction)# 89.6
budgetmat7 <- matrix(auction, nrow = 1, ncol=5,byrow=TRUE)    
colnames(budgetmat7)  <- c("2021","2022","2023","2024","2025")
rownames(budgetmat7) <- c("Emissions of 90m are priced in emissions budget")

# chart of emissions actually priced via ETS or emissions budget
svg(filename="Emissions-budget8-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
#png("Emissions-budget8-560by420.png", bg="white", width=560, height=420,pointsize = 12)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat7,ylim=c(0,53),las=1,space=0, beside = FALSE, col=c("#2D9886")) 
mtext(side=1,line=2.5,cex=1,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf")))
legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Emissions actually priced via auctions 90m") , fill = c("#2D9886"))
mtext(side=2,cex=1, line=2.3, expression(paste("million tonnes of emissions")))
mtext(side=4,cex=0.85, line=0.05,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Emissions of 90m are priced in emissions budget")) )
dev.off() 

unpriced<-c( outsideets + allocation + stockpile)
unpriced 
[1] 52.6 52.4 53.1 52.9 52.9 
sum(unpriced)       # [1] 263.9
sum(auction)# 89.6
# what proportion of emissions budget is priced?
sum(auction)/(sum(auction)+sum(unpriced))
[1] 0.2534653 

budgetmat8 <- matrix(c( unpriced, auction), nrow = 2, ncol=5,byrow=TRUE)    
colnames(budgetmat8) <- c("2021","2022","2023","2024","2025")
rownames(budgetmat8) <- c("Unpriced emissions outside NZETS & budgets","Priced emissions via auctions")
budgetmat8 
                                           2021 2022 2023 2024 2025
Unpriced emissions outside NZETS & budgets 52.6 52.4 53.1 52.9 52.9
Priced emissions via auctions              19.0 19.3 18.6 17.2 15.5


# chart of emissions actually priced via ETS or emissions budget
#svg(filename="Emissions-budget9-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
png("Emissions-budget9-560by420.png", bg="white", width=560, height=420,pointsize = 12)
par(mar=c(4, 4, 4, 1)+0.1)
barplot(budgetmat8, ylim=c(0,75), las=1,space=0, beside = FALSE, col=c("#1D556C","#919390")) 
mtext(side=3,line=-0.5,cex=1,expression(paste("The emissions budget prices 25% of net emissions")))
mtext(side=1,line=2.5,cex=1,expression(paste("Data https://www.beehive.govt.nz/sites/default/files/2020-06/NZETS%20Q%26A.pdf")))
#legend("bottom", inset=c(0.0,0.0) ,bty="o", cex=1, c("Emissions actually priced via auctions 90m", "Unpriced emissions outside NZETS & budgets 264m") , fill = c("#919390","#1D556C"))
legend(1.2, 63.5, inset=c(0.0,0.0) ,bty="o", cex=1, c("Emissions actually priced via auctions 90m") , fill = c("#919390"))
legend(0.8, 31, inset=c(0.0,0.0) ,bty="o", cex=1, c("Unpriced emissions outside NZETS & budgets 264m") , fill = c("#1D556C"))
mtext(side=2,cex=1, line=2.3, expression(paste("million units")))
mtext(side=4,cex=0.85, line=0.05,R.version.string)
mtext(side=3,cex=1.5, line=1,expression(paste("Emissions not priced in emissions budget 2021 to 2025")) )
dev.off()  

===============================
# download the MfE GHG Inventory time series spreadsheet to 2020
# https://environment.govt.nz/publications/new-zealands-greenhouse-gas-inventory-1990-2020/
# https://environment.govt.nz/assets/publications/GhG-Inventory/Time-series-emissions-data-by-category.xlsx
download.file("https://environment.govt.nz/assets/publications/GhG-Inventory/Time-series-emissions-data-by-category.xlsx","/media/user/RED/NZaluminium/Time-series-emissions-data-by-category.xlsx") 
trying URL 'https://environment.govt.nz/assets/publications/GhG-Inventory/Time-series-emissions-data-by-category.xlsx'
Content type 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' length 1567250 bytes (1.5 MB)
==================================================
downloaded 1.5 MB

# check number of worksheets
excel_sheets("Time-series-emissions-data-by-category.xlsx") 
 
[1] "All gases" "CO2"       "CH4"       "N2O"       "HFCs"      "PFCs"     
[7] "SF6"  

# read in inventory emissions data
emissions <- read_excel("Time-series-emissions-data-by-category.xlsx", sheet = "All gases",skip=10)
New names:
* `` -> ...34
* `` -> ...35
* `` -> ...36
* `` -> ...37

# select only alminium sector emissions being row 378 (excluding first 11 rows in worksheet) from column 3 1990 to 2019
aluminium <- as.numeric(emissions[378,3:33]) 
aluminium
[1] 1358.9293 1352.9269  862.6030  667.4980  642.5180  587.5980  737.1080
 [8]  715.9150  596.2139  610.7926  607.6797  597.4573  636.7836  667.5680
[15]  650.1950  629.0778  649.0240  625.5620  548.1361  506.0851  622.2611
[22]  606.3370  568.4929  581.9501  609.9896  596.6533  588.1052  606.6072
[29]  627.3271  663.6246  637.1307
