require('DBI')
require('RPostgreSQL')

drv <- dbDriver("PostgreSQL")

# Función que permite conectarnos a una base de datos PostgreSQL.
# Incluye por default muchos de los parámetros que suelen usarse para conectarse (user, port y host).
# Si no se especifica contraseña se busca un archivo en el mismo PATH que este Script con el nombre
# del usuario especificado y la extensión '.pwd'.
pg_connect <- function(user='postgres', dbname, host='localhost', password=NULL, port=5432){
    if(is.null(password)){
        password = get_password(user)
    }
    connection = dbConnect(drv, port=port, user=user, dbname=dbname, host=host, password=password)
    # Registramos el evento de cerrar la conexión automáticamente al salir de R.
    on.exit(pg_disconnect(con))
    return(connection)
}

# Desconecta una conexión ya creada.
pg_disconnect <- function(connection){
    dbDisconnect(conn=connection)
}

# Obtiene la contraseña de un usuario buscando dentro del directorio especificado un archivo
# con el nombre del usuario y la extensión '.pwd'.
# Si no se especifica directorio, se toma el directorio de este Script.
get_password = function(username, directory=NULL, ext='.pwd') {
    # Si no nos pasaron un directorio, concatenamos el Working Directory (wd)
    # con el path relativo a este Script.
    if(is.null(directory)) {
        directory = paste(getwd(), 'db', 'PostgreSQL', sep='/')
    }
    # Concatenamos el nombre del archivo al directorio.
    file = paste0(directory, '/', username, ext)
    # Probamos que sea accesible para lectura (mode=4 prueba existencia+lectura).
    can_read = file.access(file, mode=4)
    # Si podemos acceder al archivo, lo leemos entero y lo devolvemos.
    if(can_read[[file]] == 0) {
        return(readLines(file))
    }
    # Si no se puede encontrar o leer el archivo, devolvemos un string vacío que va
    # a dar error cuando se intente realizar la conexión.
    return("")
}