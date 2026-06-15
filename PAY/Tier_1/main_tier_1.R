library(tidyverse)

source("PAY/DoNotShare/parameters.R")


# Build a table of MCC codes from different sources -----------
source("PAY/Tier_1/build_rich_MCC_table.R")


# Study different platforms on several main markets of the digital economy ---------------

## Music (and Spotify particularly) -----------
source("PAY/Tier_1/music_streaming.R")
