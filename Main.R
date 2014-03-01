source("init/init.R")

con <- pg_connect(user="crcssa_user", dbname="crcssa_salado", port=10521)

rs <- dbSendQuery(con, "select COUNT(*) from estacion_registro_diario e")

fetch(rs,n=-1)