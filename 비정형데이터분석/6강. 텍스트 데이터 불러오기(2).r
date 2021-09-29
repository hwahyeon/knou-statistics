
#--------------------------------------------------------------------------------------
library(httr)
library(XML)
webpage=GET('https://press.knou.ac.kr/goods/textBookList.do?condLscValue=001&condMscValue=003&condSscValue=007&condScyr=4')
web=htmlParse(webpage)
xpathSApply(web,'//*[@id="listForm"]/div/div[3]/div[3]/div[3]/table/tbody/tr[1]/td[2]/div/h5/a',xmlValue)

xpathSApply(web,'//*[@id="listForm"]/div/div[3]/div[3]/div[3]/table/tbody/tr[2]/td[2]/div/h5/a',xmlValue)

xpathSApply(web,'//*[@id="listForm"]/div/div[3]/div[3]/div[3]/table/tbody/tr[3]/td[2]/div/h5/a',xmlValue)

ls <- rep("",6)
 for (i in 1:6) {
 sub <- paste0('//*[@id="listForm"]/div/div[3]/div[3]/div[3]/table/tbody/tr[',i,']/td[2]/div/h5/a')
 ls[i] <- xpathSApply(web,sub,xmlValue)
 }

#--------------------------------------------------------------------------------------
library(rvest)
library(dplyr)
exurl <- "https://ko.wikipedia.org/wiki/%EB%B9%84%EC%A0%95%ED%98%95_%EB%8D%B0%EC%9D%B4%ED%84%B0"
html_ex <- read_html(exurl,encoding="UTF-8")

html_ex%>%html_nodes(".mw-parser-output p")%>%html_text()
html_ex%>%html_nodes("#mw-content-text p")%>%html_text()

#------------------------------------------------
ex2url <- "http://www.index.go.kr/potal/main/EachDtlPageDetail.do?idx_cd=2736"

html_ex2 <- read_html(ex2url,encoding="UTF-8")
html_ex2%>%html_nodes(".table_style_2")%>%html_table()

#--------------------------------------------------------------------------------------------
