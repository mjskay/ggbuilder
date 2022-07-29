test_that("layer_spec construction works", {
  df = data.frame(response_time = 1:20, condition = c("A", "B"))

  ls = layer_spec(
    data_(\(x) filter(x, condition == "b")),
    stat_("boxplot", aes(x = condition, y = value)),
    geom_("label", aes(y = ymax, label = ymax), size = 5)
  )

  df |>
    ggplot() +
    stat_boxplot(aes(x = condition, y = response_time, fill = condition)) +
    layer_(
      data_(~ dplyr::filter(.x, condition == "A")),
      stat_("boxplot", aes(x = condition, y = response_time, color = condition)),
      geom_("label", aes(y = ymax, label = ymax), size = 5),
      rescale_(aes(fill = alpha(color, 0.1)))
    )

  df |>
    ggplot() +
    stat_boxplot(aes(x = condition, y = response_time, fill = condition)) +
    geom_label(
      aes(x = condition,
        y = stage(start = response_time, after_stat = ymax),
        label = after_stat(ymax),
        colour = condition,
        fill = after_scale(alpha(color, 0.1))
        ),
      stat = "boxplot", size = 5,
      data = . %>% dplyr::filter(condition == "B")
    )
})
