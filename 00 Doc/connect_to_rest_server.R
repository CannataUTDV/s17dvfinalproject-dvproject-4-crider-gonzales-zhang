require("jsonlite")
require("RCurl")
require("ggplot2")

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:1738/rest/native/?query="select * from KEI_Avg"')),httpheader=c(DB='jdbc:data:world:sql:chriscrider:s-17-edv-project-3', USER='gonzalez', PASS='eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50OmdvbnphbGV6IiwiaXNzIjoiYWdlbnQ6Z29uemFsZXo6OmMwN2RkYmNkLTU3ZmEtNDBkNi04MzQwLTQ0NzJlYzI0OTBiMiIsImlhdCI6MTQ4NDY5NzMxOSwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.5mTuKVcV8fKTtPvvxxcyo-5TBGLGufXDQkIraPgCsuB4hc7mUj_editztVly63Yr4jxmvyvI-kUu07EvQnuZYw', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))