# Setup
library(devtools)
library(ggplot2)
library(ggthemr)  # to set a custom theme but non essential!
library(forcats)  # to reorder categorical variables

# Set working directory ----
setwd("~/Documents/Uni Stuff/Year 3/Data Science/GEE-Hack-a-thon/Data")

##Read in the data ----
PL_gain <- read.csv("PL_forest_gain.csv")
PL_loss <- read.csv("PL_forest_loss.csv")

# Create identifier column for gain vs loss
PL_gain$type <- "Gain"
PL_loss$type <- "Loss"
PL_change <- rbind(PL_gain, PL_loss)

# Sets theme for the graph
ggthemr('dust', type = "outer", layout = "minimal")

# Making + formatting barplot
(PL_barplot <- ggplot(PL_change, aes(x = NAME, y = sum/GIS_AREA, 
                                             fill = fct_rev(type))) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(x = NULL, y = "Forest change (% of park area)\n") +
    # Expanding the scale removes the emtpy space below the bars
    scale_y_continuous(expand = c(0, 0), limits = c(0, 0.6)) +
    theme(text = element_text(size = 16),  # makes font size larger
          legend.title = element_blank(),  # gets rid of the legend title
          legend.background = element_rect(color = "black", 
                                           fill = "transparent",   # removes the white background behind the legend
                                           linetype = "blank")))
# Save figure
ggsave(PL_barplot, filename = "PL_barplot.png",
       height = 5, width = 5)
