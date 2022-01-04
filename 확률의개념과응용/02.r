# R을 이용한 고전적 확률 실습

# 표본공간 : 통계적 실험의 모든 가능 결과의 집합
# 사건 : 표본공간의 부분 집합



#install.packages("prob")
library(prob)

# 동전던지기 1회 실시한 표본공간
t1 = tosscoin(1)
print(t1)

if(0)'
  toss1
1     H
2     T
'

# 동전던지기 3회 실시한 표본공간
t3 = tosscoin(3)
print(t3)

if(0)'
  toss1 toss2 toss3
1     H     H     H
2     T     H     H
3     H     T     H
4     T     T     H
5     H     H     T
6     T     H     T
7     H     T     T
8     T     T     T'


#주사위 1회 던지기
r1 = rolldie(1)
print(r1)

if(0)'
  X1
1  1
2  2
3  3
4  4
5  5
6  6'

# 공이 3개 든 항아리에서 표본 2개 뽑는 경우

# 1) 순서 고려, 복원 추출
u1 = urnsamples(x=c("a","b","c"), size=2, replace=TRUE, ordered=TRUE)
print(" 순서 고려, 복원추출  ")
print(u1)

if(0)'
  X1 X2
1  a  a
2  b  a
3  c  a
4  a  b
5  b  b
6  c  b
7  a  c
8  b  c
9  c  c'


# 2) 순서 고려, 비복원 추출
u2 = urnsamples(x=c("a","b","c"), size=2, replace=FALSE, ordered=TRUE)
print(" 순서 고려, 비복원추출  ")
print(u2)

if(0)'
  X1 X2
1  a  b
2  b  a
3  a  c
4  c  a
5  b  c
6  c  b'


# 3) 순서 비고려, 비복원추출
u3 = urnsamples(x=c("a","b","c"), size=2, replace=FALSE, ordered=FALSE)
print(" 순서 비고려, 비복원추출  ")
print(u3)

if(0)'
  X1 X2
1  a  b
2  a  c
3  b  c'

# 공이 3개 든 항아리에서 표본 2개 뽑는 경우의 수 계산

# 1) 순서 고려, 복원추출
a1 = nsamp(n=3, k=2, replace=TRUE, ordered=TRUE)
# 2) 순서 고려, 비복원추출
a2 = nsamp(n=3, k=2, replace=FALSE, ordered=TRUE)
# 3) 순서 비고려, 비복원추출
a3 = nsamp(n=3, k=2, replace=FALSE, ordered=FALSE)

cat("  순서 고려, 복원추출의 경우의 수   :", a1, "\n")
cat("  순서 고려, 비복원추출의 경우의 수 :", a2, "\n")
cat("  순서 비고려, 비복원추출의 경우의 수 :", a3, "\n")

#순서 고려, 복원추출의 경우의 수   : 9
#순서 고려, 비복원추출의 경우의 수 : 6
#순서 비고려, 비복원추출의 경우의 수 : 3 


#고전적 확률계산
#주사위 확률계산
rolldie(1, makespace=TRUE)
if(0)'
  X1     probs
1  1 0.1666667
2  2 0.1666667
3  3 0.1666667
4  4 0.1666667
5  5 0.1666667
6  6 0.1666667'

#동전던지기 확률계산
tosscoin(1, makespace=TRUE)
if(0)'
  toss1 probs
1     H   0.5
2     T   0.5'

#집합연산과 확률


S=rolldie(1, makespace=TRUE)
A=subset(S, X1==2 | X1==4 | X1==6)
B=subset(S, X1==3 | X1==6)
pa = Prob(A)
pb = Prob(B)
paub = Prob(union(A,B))
pacb = Prob(intersect(A,B))
padb = Prob(setdiff(A,B))

cat(" P(A) =", pa, "\n")
cat(" P(B) =", pb, "\n")
cat(" P(A U B) =", paub, "\n")
cat(" P(A ^ B) =", pacb, "\n")
cat(" P(A - B) =", padb)

if(0)'
P(A) = 0.5 
P(B) = 0.3333333 
P(A U B) = 0.6666667 
P(A ^ B) = 0.1666667 
P(A - B) = 0.3333333'
