install.packages(c('rlang','glue','htmltools'))
install.packages('highcharter')
#-------------------------------------------------------------------------------------------------------------
library(tidyquant)
library(data.table)
library(highcharter)
library(h2o)

# string-leri qruplashdirmaq ==> mutate_if(is.character,as.factor)
df <- fread('bank-full.csv') %>% mutate_if(is.character,as.factor)

df %>% glimpse()

# Run h2O cluster
h2o.init()

# datanı h2o-ya çevirin
h2o_data <- as.h2o(df)

#datanı 2 hissəyə bolün
h2o_data <- h2o.splitFrame(h2o_data, ratios = c(0.8), seed=1)

# hesablama hissəsi
train <- h2o_data[[1]]

#proqnoz vermə hissəsi
test <- h2o_data[[2]]

# süni zəkaya hansı sütunu proqnoz verəcəyini göstəririk
outcome <- 'y'

# modelin qurulması, 5 alqoritm ilə
# y -- bizə hansı sütunu proqnoz edəcəyimizi
# training_frame - hesablama hissəsi
# validation_frame - təsdiqləmə hissəsi
# leaderboard_frame  - proqnoz vermə hissəsi
# seed - təsadüfi ədədlərin yaradılması
# max_runtime_secs - modellərin qurulması üçün maksimum vaxtın verilməsi
# max_models - isə max_runtime_secs-in əvəzinə model sayını bildirir. Bu sayda model  qurulduqdan sonra süni zəka dayanır
# exclude_algos - isə həmin alqoritmləri hesablamadan çıxarır
aml<-h2o.automl(y=outcome,
                training_frame = train,
                leaderboard_frame = test,seed=3,
                max_runtime_secs = 120)#,max_models = 2)#,exclude_algos = c("DRF", "GBM","GLM","DeepLearning","StackedEnsemble"))

# lider alqoritmi göstərir
aml@leader

#liderlərin sihasını əks etdirir.
aml@leaderboard %>% as_tibble() %>% head(.,20)

h2o.performance(aml@leader,test)
