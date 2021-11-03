# 별점화 회귀분석 실습

# 회귀분석의 최소제곱 추정
library(lars)

data(diabetes)
# db 설명
# 당뇨 환자 442명 db
# 종속 변수 : 당뇨 치료 1년 후 병세 호전 정도
# 설명 변수 : 나이, 성별, 체질량지수, 평균혈압, 혈청 측정값

ols = solve(t(diabetes$x)%*%diabetes$x)%*%t(diabetes$x)%*%diabetes$y
ols

if(0)"
          [,1]
age  -10.01220
sex -239.81909
bmi  519.83979
map  324.39043
tc  -792.18416
ldl  476.74584
hdl  101.04457
tch  177.06418
ltg  751.27932
glu   67.62539
"#"

# 능형회귀분석 회귀계수의 추정
library(glmnet)
r.rslt = glmnet(x=diabetes$x, y=diabetes$y, family="gaussian", alpha=0)
r.rslt$beta

# alpha를 1로 하면 라쏘회귀분석이 된다.

# 라쏘회귀분석 회귀계수의 추정
r.rslt = glmnet(x=diabetes$x, y=diabetes$y, family="gaussian", alpha=1)
r.rslt$beta


# 빅데이터 환경에서의 회귀분석
library(biglm)
library(bigmemory)
library(biganalytics)

big.data = as.big.matrix(as.matrix(diabetes))
fm = y~x.age+x.sex+x.bmi+x.map+x.tc+x.ldl+x.hdl+x.tch+x.ltg+x.glu
lm.rslt = biglm.big.matrix(fm,big.data)
summary(lm.rslt)


# 빅데이터 환경에서의 라쏘회귀분석
# as.ff 함수는 객체를 ff 객체로 바꿔주는 함수이다.
library(biglars)
ff.x = as.ff(diabetes$x)
ff.y = as.ff(diabetes$y)
big.lasso = biglars.fit(ff.x, ff.y, type="lasso")

big.lasso$coef
big.lasso$RSS
