# Todas las funciones de calibración terminadas en ".csv" toman como entrada un campo
# data que debe ser un Data Frame con las cabeceras:
#  ___________________________________________________________________
# |  Date  |  Tmax  |  Tmin  |  Precip  |  Sunabs  |  Solrad  |  Nub  |
#  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Angstrom-Prescott
estimar.por.ap.csv <- function(lat, data, ap.cal) {
    return(ap(days=as.Date(data$Date), lat=lat, A=ap.cal[[1]], B=ap.cal[[2]], SSD=data$Sunabs))
}