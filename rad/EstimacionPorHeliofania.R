estimar.por.ap.csv <- function(lat, data, ap.cal) {
    return(ap(days=as.Date(data$Date), lat=lat, A=ap.cal[[1]], B=ap.cal[[2]], SSD=data$Sunabs))
}