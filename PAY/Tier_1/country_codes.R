
if (!file.exists("PAY/DoNotShare/country_codes.csv")) {
    country_codes <- read.table(
        file = "https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/refs/heads/master/all/all.csv",
        header = TRUE,
        sep = ",",
        quote = "\""
    )
    write.csv(country_codes, file = "PAY/DoNotShare/country_codes.csv")
} else {
    country_codes <- read.csv("PAY/DoNotShare/country_codes.csv")
}
