
## Studying imports of Spotify (and other music streaming platforms) -------------

music <- PAY %>%
    dplyr::filter(mcc == 5815) %>% # MCC for "Digital Goods Media – Books, Movies, Music"
    dplyr::filter(ref_area == country.parameters$COUNTRY_CODE) %>%
    dplyr::filter(digital == "R") %>%
    dplyr::mutate(avg.transaction = val / vol) %>%
    dplyr::left_join(country_codes %>% dplyr::select(count_area.name = name, alpha.2, count_area.sub_region = sub.region), by = dplyr::join_by(count_area == alpha.2))


main.platforms$spotify <- music %>%
    dplyr::filter(count_area.name == "Sweden") %>%
    dplyr::arrange(time)

main.fields.totals$music_streaming <- music %>%
    dplyr::group_by(time, ref_area, mcc, digital) %>%
    dplyr::summarise(
        val = sum(val),
        vol = sum(vol),
        .groups = "drop"
    ) %>%
    dplyr::mutate(avg.transaction = val / vol) %>%
    dplyr::arrange(time)
