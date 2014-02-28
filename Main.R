source("db/PostgreSQL/PostgreSQL.r")

con <- db_connect(user="crcssa_user", host="192.168.1.115", dbname="crcssa_salado")

rs <- dbSendQuery(con, "select COUNT(*) from estacion_registro_diario e")

fetch(rs,n=-1)