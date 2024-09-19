# 安装包
devtools::install("WetReg")

# 加载包
library(WetReg)

# 1. 加载数据
dat_path <- "./data"
out_path <- "./output"
load_data(dat_path)

# 2. 构建广义倾向性得分模型并输出加权后的Cox回归
outcomes <- c("输入结局列名")
survival_time <- c("输入生存时间列名")
exposures <- c("输入结局列名")
covariates <- c("输入协变量列名")

gps_cox_model(dt_fin, exposures, covariates, outcomes, survival_time, out_path)

# 3. 绘制KM曲线
plot_km_curve(dt_fin, out_path)
