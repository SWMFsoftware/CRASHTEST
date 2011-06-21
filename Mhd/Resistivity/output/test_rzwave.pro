; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

resdir='test_rzwave_results/'

set_device,resdir+'rzwave.eps',/eps,/port
loadct,39
filename=resdir+'*/GM/z*.outs'
; in the following Delta(t)=0.05, eta=20
func='bx {bx}-(cos(!pi/5*y)*(1-(!pi/5)^2)-!pi/5*sin(!pi/5*y)/y) bz {bz}-((1.0-cos(!pi/5*y))*(1.0-1.0/y^2)+(!pi/5)^2*cos(!pi/5*y)+!pi/5*sin(!pi/5*y)/y) pe {pe}-(1.0+(5.0/3-1.0)*((!pi/5*sin(!pi/5*y))^2+((1.0-cos(!pi/5*y))/y+!pi/5*sin(!pi/5*y))^2))'
plottitle='B!DX!N;Error in B!DX!N;B!DZ!N;Error in B!DZ!N;pe;Error in pe'
!p.charsize=1.6
plotmode='contbar'
bottomline=0
firstpict=2
npictmax=1
multiplot=[3,6,1]
.r animate
close_device,/pdf

; 2. calculate errors and save them into a file
openw, 99, resdir + 'error.dat'
printf,99,'wave test in 2D'
printf,99,'n l1_error'

iws = [4,6,8]

filename=resdir+'10/GM/z*.outs'
npict=2
.r getpict
wref=w
wref(*,*,4)= (cos(!pi/5*x(*,*,1))*(1-(!pi/5)^2)-!pi/5*sin(!pi/5*x(*,*,1))/x(*,*,1))
wref(*,*,6)= ((1.0-cos(!pi/5*x(*,*,1)))*(1.0-1.0/x(*,*,1)^2)+(!pi/5)^2*cos(!pi/5*x(*,*,1))+!pi/5*sin(!pi/5*x(*,*,1))/x(*,*,1))
wref(*,*,8)= 1.0+(5.0/3-1.0)*((!pi/5*sin(!pi/5*x(*,*,1)))^2+((1.0-cos(!pi/5*x(*,*,1)))/x(*,*,1)+!pi/5*sin(!pi/5*x(*,*,1)))^2)
printf,99,10,rel_error(w,wref,iws)

filename=resdir+'20/GM/z*.outs'
.r getpict
wref=w
wref(*,*,4)= (cos(!pi/5*x(*,*,1))*(1-(!pi/5)^2)-!pi/5*sin(!pi/5*x(*,*,1))/x(*,*,1))
wref(*,*,6)= ((1.0-cos(!pi/5*x(*,*,1)))*(1.0-1.0/x(*,*,1)^2)+(!pi/5)^2*cos(!pi/5*x(*,*,1))+!pi/5*sin(!pi/5*x(*,*,1))/x(*,*,1))
wref(*,*,8)= 1.0+(5.0/3-1.0)*((!pi/5*sin(!pi/5*x(*,*,1)))^2+((1.0-cos(!pi/5*x(*,*,1)))/x(*,*,1)+!pi/5*sin(!pi/5*x(*,*,1)))^2)
printf,99,20,rel_error(w,wref,iws)

filename=resdir+'40/GM/z*.outs'
.r getpict
wref=w
wref(*,*,4)= (cos(!pi/5*x(*,*,1))*(1-(!pi/5)^2)-!pi/5*sin(!pi/5*x(*,*,1))/x(*,*,1))
wref(*,*,6)= ((1.0-cos(!pi/5*x(*,*,1)))*(1.0-1.0/x(*,*,1)^2)+(!pi/5)^2*cos(!pi/5*x(*,*,1))+!pi/5*sin(!pi/5*x(*,*,1))/x(*,*,1))
wref(*,*,8)= 1.0+(5.0/3-1.0)*((!pi/5*sin(!pi/5*x(*,*,1)))^2+((1.0-cos(!pi/5*x(*,*,1)))/x(*,*,1)+!pi/5*sin(!pi/5*x(*,*,1)))^2)
printf,99,40,rel_error(w,wref,iws)
close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps,/port
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),wlog(*,1),xrange=[1e-2,1e-1],yrange=[1e-4,3e-3],$
        ystyle=1,psym=-2,thick=4, $
        xtitle='Grid resolution', $
        ytitle='relative L1 error', $
        title="resistivity wave-test"
oplot,1/wlog(*,0),wlog(*,1),psym=-4,thick=4
oplot,[1e-2,1e-1],[2.3e-5,2.3e-3],linestyle=2,thick=3
xyouts,0.033,0.0002,'2nd order slope'
close_device,/pdf

exit
