test_that("layer construction works", {
  skip_if_not_installed("vdiffr")

  df = data.frame(response_time = 1:30, condition = c("A", "B", "C"))
  p = ggplot(df)

  vdiffr::expect_doppelganger("single geom",
    p + geom_("point", aes(x = condition, y = response_time), size = 3)
  )


  vdiffr::expect_doppelganger("single stat and geom",
    p + stat_("identity", aes(x = condition, y = response_time)) |>
      geom_("point", size = 3)
  )

  vdiffr::expect_doppelganger("plot_data() with a function",
    p +
      geom_boxplot(aes(x = condition, y = response_time, color = condition)) +
      plot_data(\(x) x[x$condition %in% c("B", "C"),]) |>
      stat_("boxplot", aes(x = condition, y = response_time, color = condition)) |>
      geom_("label", aes(y = ymax, label = ymax), size = 5)
  )


  skip_if_not_installed("dplyr")

  vdiffr::expect_doppelganger("plot_data() with a verb",
    p +
      geom_boxplot(aes(x = condition, y = response_time, color = condition)) +
      plot_data() |>
        dplyr::filter(condition %in% c("B", "C")) |>
        stat_("boxplot", aes(x = condition, y = response_time, color = condition)) |>
        geom_("label", aes(y = ymax, label = ymax), size = 5)
  )

  vdiffr::expect_doppelganger("plot_data() with several verbs and remap()",
    df |>
      ggplot(aes(x = condition, y = response_time, color = condition)) +
      stat_("boxplot") +
      plot_data() |>
        dplyr::filter(condition %in% c("B", "C")) |>
        dplyr::group_by(condition) |>
        dplyr::slice_max(response_time) |>
        geom_("label", aes(label = response_time), size = 5, show.legend = FALSE) |>
        remap(aes(fill = colorspace::lighten(color, .9)))
  )

})
