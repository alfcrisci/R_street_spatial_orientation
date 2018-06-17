ibrary(rgdal)
library(rBiometeo)


###########################################################à#############################################################################

source("aux_orientation.r")

###########################################################à#############################################################################
strade_orientation_df <- readOGR(".", "strade_df")

orient_gis=read.csv("Orientation_strade_df.csv")
strade_orientation <- readOGR(".", "strade_orientation")

strade_orientati_seg=segmented_lines(strade_orientation)
strade_orientati_seg_df=SpatialLinesDataFrame(strade_orientati_seg,data.frame(id=1:length(strade_orientati_seg)))
strade_orientati_seg_df$orient=orient_gis$Orientation
strade_orientati_seg_df$sector=compass_8(strade_orientation_df$orient)
strade_orientati_seg_df$sector_windstreet=strade_orientati_seg_df$sector

strade_orientati_seg_df$sector=compass_8(strade_orientation_df$orient)

idNE_SO=c(which(strade_orientati_seg_df$sector=="NE"),which(strade_orientati_seg_df$sector=="SW"))
idN_S=c(which(strade_orientati_seg_df$sector=="N"),which(strade_orientati_seg_df$sector=="S"))
idE_O=c(which(strade_orientati_seg_df$sector=="E"),which(strade_orientati_seg_df$sector=="W"))
idNW_SE=c(which(strade_orientati_seg_df$sector=="NW"),which(strade_orientati_seg_df$sector=="SE"))

strade_orientati_seg_df$sector_windstreet[idNE_SO]="asse_NE_SO"
strade_orientati_seg_df$sector_windstreet[idN_S]="asse_N_S"
strade_orientati_seg_df$sector_windstreet[idE_O]="asse_E_O"
strade_orientati_seg_df$sector_windstreet[idNW_SE]="asse_NW_SE"
writeOGR(strade_orientati_seg_df, ".", "strade_df_guerri", driver="ESRI Shapefile",overwrite_layer=T)


###########################################################à#############################################################################

