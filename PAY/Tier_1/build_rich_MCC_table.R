
# Building a table of MCC codes based on several sources -------------------

MCC.table <- read.table(
    file = country.parameters$MCC.table.file$path,
    header = country.parameters$MCC.table.file$header,
    sep = country.parameters$MCC.table.file$sep
)


MCC.table.greggles <- read.table(
    file = "https://raw.githubusercontent.com/greggles/mcc-codes/refs/heads/main/mcc_codes.csv",
    header = TRUE,
    sep = ",",
    colClasses = c(mcc = "character")
)

coherence.greggles <- MCC.table.greggles %>%
    dplyr::mutate(
        identical.edited.combined = (edited_description == combined_description),
        identical.edited.usda = (edited_description == usda_description),
        identical.edited.irs = (edited_description == irs_description)
    )


joined.MCC.tables <- dplyr::full_join(
        MCC.table,
        coherence.greggles,
        by = dplyr::join_by(Code == mcc)
    ) %>%
    dplyr::mutate(is.identical = (DESCRIPTION == edited_description), .before = 1)

joined.MCC.tables <- joined.MCC.tables %>%
    dplyr::mutate(
        Description = dplyr::case_when(
            is.na(DESCRIPTION) ~ edited_description,
            .default = DESCRIPTION
        )
    ) %>%
    dplyr::mutate(
        Origin = dplyr::case_when(
            is.na(DESCRIPTION) ~ "greggles (GitHub public)",
            .default = "institutional source"
        )
    ) %>%
    dplyr::select(Code, Description, Origin)
