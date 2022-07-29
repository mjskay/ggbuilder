test_that("layer_spec construction works", {
  df = data.frame(response_time = 1:30, condition = c("A", "B", "C"))

  ls = layer_spec(
    data_(\(x) filter(x, condition == "b")),
    stat_("boxplot", aes(x = condition, y = value)),
    geom_("label", aes(y = ymax, label = ymax), size = 5)
  )

  df |>
    ggplot(aes(x = condition, y = response_time)) +
    geom_("point")

  df |>
    ggplot() +
    geom_("point", aes(x = condition, y = response_time))

  df |>
    ggplot() +
    stat_("identity", aes(x = condition, y = response_time)) |>
      geom_("point")

  df |>
    ggplot(aes(x = condition, y = response_time)) +
    stat_("boxplot", aes(x = condition, y = response_time, color = condition)) |>
      geom_("boxplot") +
    stat_("boxplot", aes(x = condition, y = response_time, color = condition)) |>
      geom_("label", aes(y = ymax, label = ymax), size = 5, data = . %>% filter(condition == "B"))

  df |>
    ggplot(aes(x = condition, y = response_time)) +
    plot_data() |>
      stat_("boxplot", aes(x = condition, y = response_time, color = condition)) |>
      geom_("boxplot") +
    plot_data(. %>% dplyr::filter(condition %in% c("B", "C"))) |>
      stat_("boxplot", aes(x = condition, y = response_time, color = condition)) |>
      geom_("label", aes(y = ymax, label = ymax), size = 5, show.legend = FALSE) |>
      remap(aes(fill = colorspace::lighten(color, .9)))


  df |>
    ggplot(aes(x = condition, y = response_time, color = condition)) +
    geom_boxplot() +
    plot_data() |>
      filter(condition %in% c("B", "C")) |>
      stat_("boxplot", aes(x = condition, y = response_time)) |>
      geom_("label", aes(y = ymax, label = ymax), size = 5) |>
      remap(aes(fill = colorspace::lighten(color, .9))) +
    theme_light()

  df |>
    ggplot(aes(x = condition, y = response_time, color = condition)) +
    stat_("boxplot") +
    plot_data() |>
      filter(condition %in% c("B", "C")) |>
      group_by(condition) |>
      slice_max(response_time) |>
      geom_("label", aes(label = response_time), size = 5, show.legend = FALSE) |>
      remap(aes(fill = colorspace::lighten(color, .9)))


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


  data_(~ dplyr::filter(.x, condition == "A")) |>
    stat_("boxplot", aes(x = condition, y = response_time, color = condition)) |>
    geom_("label", aes(y = ymax, label = ymax), size = 5) |>
    rescale_(aes(fill = alpha(color, 0.1)))


  plot_data() |>
    filter(condition == "A") |>
    stat_("boxplot", aes(x = condition, y = response_time, color = condition)) |>
    geom_("label", aes(y = ymax, label = ymax), size = 5) |>
    rescale(aes(fill = alpha(color, 0.1)))

  statistic(aes(x = condition, y = response_time, color = condition)) |>
    geometry(label, aes(y = ymax, label = ymax), size = 5)
})
