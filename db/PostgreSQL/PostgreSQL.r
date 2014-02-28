require('DBI')
require('RPostgreSQL')
library(tools)

drv <- dbDriver("PostgreSQL")

db_connect <- function(user='postgres', dbname, host='localhost', password=NULL, port=5432){
    if(is.null(password)){
        password = get_password(user)
    }
    connection = dbConnect(drv, port=port, user=user, dbname=dbname, host=host, password=password)
    return(connection)
}

get_password = function(username, directory=NULL, ext='.pwd') {
    if(is.null(directory)) {
        directory = paste(getwd(),'db','PostgreSQL',sep='/')
    }
    
    file = paste0(directory, '/', username, ext)
    
    can_read = file.access(file, mode=4)
    
    if(can_read[[file]] == 0) {
        return(readLines(file))
    }
    return("")
}