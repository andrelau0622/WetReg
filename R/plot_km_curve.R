# KM曲线
plot_km_curve <- function(dt_fin, out_path) {
  surv_obj <- Surv(time = dt_fin$los_hospital, event = dt_fin$hospital_expire_flag)
  km_fit <- survfit(surv_obj ~ treat_type, data = dt_fin, weights = dt_fin$weights)

  # 绘制KM曲线
  p <- ggsurvplot(km_fit, data = dt_fin,
                  pval = TRUE,
                  ggtheme = theme_classic(),
                  surv.median.line = "hv",
                  title = "Kaplan-Meier Survival Curve",
                  xlab = "Time (days)",
                  ylab = "Survival Probability",
                  legend.title = "Treat type",
                  legend.labs = c("IV", "SC"))

  ggsave(plot = p, filename = paste0(out_path, "/", "3.4_", "KM_curve", ".tiff"), width = 300, height = 200, units = "mm", dpi = 300)
}
