# IPTW&加权Cox
gps_cox_model <- function(dt_fin, exposures, covariates, outcomes, survival_time, out_path) {
  # 广义倾向性得分模型
  formula <- sprintf("%s ~ %s", exposures[2], paste(covariates, collapse = "+")) %>% as.formula()
  w.out <- weightit(formula, data = dt_fin, estimand = "ATE", method = "ps")
  dt_fin$weights <- w.out$weights
  dt_fin$weights[dt_fin$weights >= 10] <- 10
  dt_fin$weights[dt_fin$weights <= 0.1] <- 0.1

  # 变量平衡
  bal_tab <- bal.tab(w.out, m.threshold = 0.1, un = TRUE)
  writexl::write_xlsx(bal_tab$Balance, path = paste0(out_path, "/", "3.1_", "Covariates balance", ".xlsx"))

  # 加权后的Cox回归模型
  weighted_cox <- mul_out_exp_reg(outcome = outcomes,
                                  survival_time = survival_time,
                                  exposure = "treat_type",
                                  cov_list = list(c("age")),
                                  data = dt_fin,
                                  null_model = TRUE,
                                  family = "cox",
                                  weights = dt_fin$weights)
  weighted_cox <- weighted_cox %>% filter(Model == "Model 1") %>% select(-Model, -Beta, -STD)
  writexl::write_xlsx(weighted_cox, path = paste0(out_path, "/", "3.3_", "IPW", ".xlsx"))

  return(weighted_cox)
}
