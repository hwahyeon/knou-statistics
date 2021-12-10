# Project Gutenberg의 로빈슨 크루소 속 단어들의 도수분포표 작성

# scan()은 길이가 일정하지 않은 비정형 데이터 파일을 읽는데 적합.
# read.csv(), read.table()은 정형 데이터 읽는 데 적합.
RC <- scan("http://www.gutenberg.org/files/521/521-0.txt",
           what = "character", encoding = "UTF-8", sep = "\n")

# grep()은 텍스트 데이터에서 해당되는 패턴의 위치를 알려줌.
RC_Chpt <- grep(RC, pattern = "CHAPTER")
RC_End <- grep(RC, pattern = "END OF THE PROJECT GUTENBERG EBOOK")-1
RC_body <- RC[(RC_Chpt[1]):RC_End]

# 데이터 전처리
# 각 행들이 \n으로 나누어져 있으므로 paste()를 활용, 공백으로 덧붙여 하나의 벡터로 연결하고자 함
RC_all <- paste(RC_body, collapse = " ")

# 's 제거 / 아포스트로피와 하이픈을 제외한 문장부호 제거
RC_all <- gsub(RC_all, pattern = "'s", replacement = "")
RC_all <- gsub(RC_all, pattern = "([^[:alnum:][:blank:]'-])", replacement = "")
RC_all <- tolower(RC_all)

# 이번 과정에선 n-gram은 염두에 두지 않는다.

# strsplit()의 결과는 리스트로 저장된다. unlist()를 활용해 벡터로 변환해준다.
RC_all <- unlist(strsplit(RC_all, " "))
library(stopwords)
# RC_all 벡터의 원소들이 불용어 목록에 포함되지 않거나 빈칸일 때만 참이 된다.
RC_all <- RC_all[! RC_all %in% c(stopwords(), "")]

# 제거 되지 않은 아포스트로피 삭제
RC_all <- gsub(RC_all, pattern = "'", replacement = "")
# 원형 복원
library(textstem)
RC_all <- lemmatize_strings(RC_all)

# 도수분포표 작성
RC_all_table <- sort(table(RC_all), decreasing = T)
RC_all_table
if(0)'
                    I                   make                     go                   come
                  4995                    610                    508                    496
                  upon                    see                    one                   good
                   492                    388                    377                    369
                   may                  great                   find                    two
                   363                    354                    345                    339
                  take                 little                    me,                   much
                   329                    291                    266                    242 '


# 상대도수를 이용한 도수분포표
RC_all_proptable <- sort(prop.table(table(RC_all)), decreasing = T)
RC_all_proptable
if(0)'
            I                   make                     go                   come
          8.177264e-02           9.986248e-03           8.316417e-03           8.119966e-03
                  upon                    see                    one                   good
          8.054482e-03           6.351909e-03           6.171829e-03           6.040862e-03
                   may                  great                   find                    two
          5.942636e-03           5.795298e-03           5.647960e-03           5.549735e-03 '
