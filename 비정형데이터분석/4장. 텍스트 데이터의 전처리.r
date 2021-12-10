# 수치형 데이터
data("iris")
iris

# R을 이용한 단어주머니 생성
# R의 기본 패키지 base 중 strsplit()는 텍스트 문자열 분해 후 단어주머니를 생성하게 해준다.
x <- c("Kim was loved by everybody.", "Everybody loved Kim", "Kim loved everybody.")
strsplit(x, split= " ")

if(0)'
[[1]]
[1] "Kim"        "was"        "loved"      "by"         "everybody."

[[2]]
[1] "Everybody" "loved"     "Kim"

[[3]]
[1] "Kim"        "loved"      "everybody."
'

# []로 인덱스를 줄 수 있다.
strsplit(x, split=" ")[[1]]
# [1] "Kim"        "was"        "loved"      "by"         "everybody."
strsplit(x, split=" ")[[2]]
# [1] "Everybody" "loved"     "Kim"
strsplit(x, split=" ")[[3]]
# [1] "Kim"        "loved"      "everybody."
strsplit(x, split=" ")[[2]][3]
# [1] "Kim"

###########################################################
# 토큰화 해보기
# 토큰 : 더 이상 나눌 필요가 없는 하나의 단위
# 축약 : ex) they're, I'm
# n-gram : give up, bed and breakfast, hard disk drive

sub(pattern = "ouse", replacement = "ay", x = "mouse in the house")
# [1] "may in the house"
gsub(pattern = "ouse", replacement = "ay", x = "mouse in the house")
# [1] "may in the hay"

# gsup을 사용하여 축약 문자를 원래 형태로 돌릴 수 있다.
contraciton_dict <- list(c("don't", "it's", "you're"), c("do not", "it is", "you are"))
dictlen <- length(contraciton_dict[[1]])

datstr <- "I don't think you're ready."
for (stri in 1:dictlen) {
    datstr <- gsub(pattern = contraciton_dict[[1]][stri],
                   replacement = contraciton_dict[[2]][stri], x = datstr)
}
datstr
# [1] "I do not think you are ready."

strsplit(datstr, " ")
#[[1]]
#[1] "I"      "do"     "not"    "think"  "you"    "are"    "ready."

# n-gram 토큰화 // 위와 방법은 동일
ngram_dict <- list(c("bed and breakfast", "grab and go", "New York"), c("bed_and_breakfast", "grab_and_go", "New_York"))
ndiclen <- length(ngram_dict[[1]])

datstr <- "It's one of the best bed and breakfast in New York."

for (stri in 1:ndiclen){
    datstr <- gsub(x = datstr, pattern = ngram_dict[[1]][stri],
                   replacement = ngram_dict[[2]][stri])
}

datstr
# [1] "It's one of the best bed_and_breakfast in New_York."

# 대소문자 변환 tolower(), toupper()
tolower('TO')
toupper('to')

# 정규표현식 + gsub pattern
x <- "Kim was a 12-years-old boy!"
gsub(x, pattern = "([[:punct:]])", replacement = "")
# [1] "Kim was a 12yearsold boy"
gsub(x, pattern = "([^[:alnum:][:blank:]'-])", replacement = "")
# ^는 삭제 대상에서 제외하겠단 뜻
# [1] "Kim was a 12-years-old boy"

# perl = T -> Perl 언어 방식의 정규표현식을 사용하겠다는 뜻.
# "\\L\\1" -> \\L 소문자를 \\1 첫 문자 하나를
gsub(x, pattern = "([[:upper:]])", replacement = "\\L\\1", perl = T)
# [1] "kim was a 12-years-old boy!"

# 어간 추출
library(textstem)
txts <- c("The williams sisters are leaving this tennis centre.")
stem_strings(txts, language = "porter")
# [1] "The william sister ar leav thi tenni centr."
# 원형 복원
lemmatize_strings(txts)
# [1] "The williams sister be leave this tennis centre."

# 어간 추출 후 원형 복원 ex) produced -> produc -> produce

# 불용어 삭제
#install.packages("stopwords")
library(stopwords)
# 불용어 확인
stopwords()
# [1] "i"          "me"         "my"         "myself"     "we"         "our"        "ours"       "ourselves" ...

# 소문자 변환 -> 문장부호 제거 -> 공백 기준으로 토큰화/단어주머니 생성 -> setdiff()로 stopwords()에 있는 불용어 제거
txt <- c("He decided to quit his job.", "I do not deny it.", "Can you hear me?")
txt <- tolower(txt)
txt <- gsub(txt, pattern = "([^[:alnum:][:blank:]'-])", replacement = "")
txt <- strsplit(txt, " ")
lapply(txt, setdiff, y=stopwords())
# setdiff()는 차집합을 구하는 함수, lapply()로 실행한 것임
if(0)'
[[1]]
[1] "decided" "quit"    "job"

[[2]]
[1] "deny"

[[3]]
[1] "can"  "hear"'

newstop <- c(stopwords(), "can")
newstop <- setdiff(newstop, c("no", "not"))
lapply(txt, setdiff, y=newstop)
if(0)'[[1]]
[1] "decided" "quit"    "job"    

[[2]]
[1] "not"  "deny"

[[3]]
[1] "hear"'
# 이런 식으로 불용어 목록을 수정할 수 있다.
