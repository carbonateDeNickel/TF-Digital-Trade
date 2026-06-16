library(tidyverse)

source("PAY/DoNotShare/parameters.R")

# Preparing the ground -----------

## Build a table of MCC codes from different sources -----------
source("PAY/Tier_1/build_rich_MCC_table.R")

## Retrieve table of country codes - from repository if exists there, or from the internet -------------
source("PAY/Tier_1/country_codes.R")


# Study different platforms on several main markets of the digital economy ---------------

PAY <- read.table(
    file = country.parameters$PAY.file$path,
    header = country.parameters$PAY.file$header,
    sep = country.parameters$PAY.file$sep,
    stringsAsFactors = TRUE
)


main.platforms <- list()

main.fields.totals <- list()


## Music (and Spotify particularly) -----------
source("PAY/Tier_1/music_streaming.R")


## [...] ------------



# Saving the results to CSV files ---------

if (!dir.exists(file.path("PAY", "results", "main_platforms"))) {
    dir.create(file.path("PAY", "results", "main_platforms"), recursive = TRUE)
}

if (!dir.exists(file.path("PAY", "results", "main_fields"))) {
    dir.create(file.path("PAY", "results", "main_fields"), recursive = TRUE)
}


for (name in names(main.platforms)) {
    write.csv(
        x = main.platforms[[name]],
        file = file.path("PAY", "results", "main_platforms", paste0(name, ".csv")),
        row.names = FALSE
    )
}

for (name in names(main.fields.totals)) {
    write.csv(
        x = main.fields.totals[[name]],
        file = file.path("PAY", "results", "main_fields", paste0(name, ".csv")),
        row.names = FALSE
    )
}
