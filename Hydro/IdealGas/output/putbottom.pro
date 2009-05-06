;===========================================================================
pro putbottom,multix,multiy,ix,iy,ninfo,nx,it,time

on_error,2
info='nx='+string(nx,format='(i6,2(",",i4))')+' '
xyouts,((ix+0.2)*!d.x_size)/multix,8+(iy*!d.y_size)/multiy,/DEV,info

end
;===========================================================================
