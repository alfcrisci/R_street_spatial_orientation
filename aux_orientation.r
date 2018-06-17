segmented_lines=function(lines) {
  cSl <- coordinates(lines)
  in_nrows <- lapply(cSl, function(x) sapply(x, nrow))
  outn <- sapply(in_nrows, function(y) sum(y-1))
  res <-list()
  
  i <- 1
  for (j in seq(along=cSl)) {
    for (k in seq(along=cSl[[j]])) {
      for (l in 1:(nrow(cSl[[j]][[k]])-1)) {
        res[[i]] <- cSl[[j]][[k]][l:(l+1),]
        i <- i + 1}}}
  
  res1 <- list();for (i in seq_along(res)) {res1[[i]] <- Lines(list(Line(res[[i]])), as.character(i))}
  outSL <- SpatialLines(res1)
  proj4string(outSL)=proj4string(lines)
  return(outSL);
}


orient_seg=function(linesobj) {
  message("work only single segment SpatialLines!")
  res_orient=list()
  for ( i in seq_along(linesobj)) {
    x=linesobj[i,]
    res_orient[[i]]=(2*pi+atan2(x@lines[[1]]@Lines[[1]]@coords[2,1]-x@lines[[1]]@Lines[[1]]@coords[1,1],x@lines[[1]]@Lines[[1]]@coords[2,2]-x@lines[[1]]@Lines[[1]]@coords[1,2]))*(180/pi)
  }
  
  temp=as.numeric(unlist(res_orient))
  return(temp)   
}


axes_segment=function(orient){
  
if ( !(require(rBiometeo))) { devtools::install_github("alfcrisci/rBiometeo")}
  
sector=rBiometeo::compass_8(orient)
sector=sector_windstreet
idNE_SO=c(which(sector=="NE"),which(sector=="SW"))
idN_S=c(which(sector=="N"),which(sector=="S"))
idE_O=c(which(sector=="E"),which(sector=="W"))
idNW_SE=c(which(sector=="NW"),which(sector=="SE"))

sector_windstreet[idNE_SO]="asse_NE_SO"
sector_windstreet[idN_S]="asse_N_S"
sector_windstreet[idE_O]="asse_E_O"
sector_windstreet[idNW_SE]="asse_NW_SE"

return(data.frame(orient=orient,sector=sector,ax_wind=sector_windstreet))

}

