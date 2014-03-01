source("init/init.R")
source("rad/EstimacionPorTemperaturas.R")

# Creamos la conexión con la base de datos.
con <- pg_connect(user="crcssa_user", dbname="crcssa_salado", port=10521)
# Registramos el evento de cerrar la conexión automáticamente al salir de R.
on.exit(pg_disconnect(con))

# Obtenemos los datos de una estación con la cual trabajar.
rs.estacion <- dbSendQuery(con, "SELECT * FROM estacion e WHERE e.omm_id = 87484")
est <- fetch(rs.estacion, n=1)

# Obtenemos 100 registros de dicha estación donde se tenga valores para todas las variables meteorológicas.
rs.registros.diarios <- dbSendQuery(con, "SELECT fecha, tmax, tmin, prcp, helio FROM estacion_registro_diario e WHERE omm_id = 87484 AND (tmax NOTNULL AND tmin NOTNULL AND prcp NOTNULL AND helio > 0) LIMIT 100")
result <- fetch(rs.registros.diarios,n=-1)

# Convertimos las fechas de la query en variables Date.
fechas <- as.Date(result$fecha)

# Estimamos por los métodos de estimación que usan la temperatura máxima y mínima.
bc.rad <- estimar.por.bc(est, result, fechas)
mh.rad <- estimar.por.mh(est, result, fechas)
ha.rad <- estimar.por.ha(est, result, fechas)

df <- data.frame(bc.rad, mh.rad, ha.rad, result$prcp, result$helio)

pg_disconnect(con)
