library("rvest")

movie <- read.csv("��ȭ�ֿ����.csv" , sep = ",")
p <- unique(movie$actor)


final.movie <- data.frame()
k <- 1

while(k <= length(p)){
  
  url_1 = 'https://s.search.naver.com/p/ncr/search.naver?query='
  name1 = p[k]
  name2 = '+�⿬��ȭ+������'
  url_2 = '&rev=31&json_type=2&size=6&lv=2&ssl=1&_callback=window.__jindo2_callback._$3362_0&pa=%2Foid%2F918iq60s401sg578ba1&listfrom='
  
  url_3 = '&click_area=nmu_x29*t'
  
  j <- 0
  s <- data.frame()
  
  while(j <= 9){
    
    url = paste(url_1 , name1, name2 , url_2 ,j, url_3 , sep ="")
    htxt = read_html(url)
    ## ���� ##
    comments = html_nodes(htxt,'li')
    reviews = html_text(comments)
    final = repair_encoding(reviews)
    final <- gsub(" " , "",final)
    
    i <- 1
    s1 <- data.frame()
    while(i <= length(final)){
      
      director <- name1
      title <- str_sub(final[i] , start = 1 , end = str_locate(final[i] , '������')[1] - 1 )
      release <- str_sub(final[i] , start = str_locate(final[i] , '������')[2] + 1 , end = str_locate(final[i] , '������')[2] + 10)
      final2 <- unlist(str_split(final[i],'����������'))[2]
      total <- str_sub(final2 , start = 1 , end = str_locate(final2, '��')[1])
      s2 <- data.frame(director,title,release,total)
      s1 <- rbind(s1,s2)
      i <- i + 1
    }
    s <- rbind(s,s1)
    j <- j + 3
  }
  
  final.movie <- rbind(final.movie,s)
  k <- k + 1
}

write.csv(final.movie , "�ֿ���쿵ȭ����.csv" ,sep =",")