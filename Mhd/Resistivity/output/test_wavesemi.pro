; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

resdir='test_wavesemi_results/'

set_device,resdir+'wave.eps',/eps,/port
filename=resdir+'*/GM/z*.outs'
; in the following Delta(t)=0.025, eta=20
func='bx {bx}-exp(-10.0*0.025*(!pi/5)^2)*cos(!pi/5*y) bz {bz}+exp(-10.0*0.025*(!pi/5)^2)*sin(!pi/5*y) pe {pe}-(1.0-2./3*0.5*(exp(-2.*10.*0.025*(!pi/5)^2)-1.))'
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
printf,99,'n l1_error linf_error'

iws = [4,6,8]

filename=resdir+'10/GM/z*.outs'
npict=2
.r getpict
wref=w
wref(*,*,4)= exp(-10.0*0.025*(!pi/5)^2)*cos(!pi/5*x(*,*,1))
wref(*,*,6)=-exp(-10.0*0.025*(!pi/5)^2)*sin(!pi/5*x(*,*,1))
wref(*,*,8)= 1.0-2./3*0.5*(exp(-2.*10.*0.025*(!pi/5)^2)-1.)
printf,99,10,rel_error(w,wref,iws),$
       max(abs(w(*,*,4)-wref(*,*,4)))/max(abs(wref(*,*,4)))+$
       max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))+$
       max(abs(w(*,*,8)-wref(*,*,8)))/max(abs(wref(*,*,8)))

filename=resdir+'20/GM/z*.outs'
.r getpict
wref=w
wref(*,*,4)= exp(-10.0*0.025*(!pi/5)^2)*cos(!pi/5*x(*,*,1))
wref(*,*,6)=-exp(-10.0*0.025*(!pi/5)^2)*sin(!pi/5*x(*,*,1))
wref(*,*,8)= 1.0-2./3*0.5*(exp(-2.*10.*0.025*(!pi/5)^2)-1.)
printf,99,20,rel_error(w,wref,iws),$
       max(abs(w(*,*,4)-wref(*,*,4)))/max(abs(wref(*,*,4)))+$
       max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))+$
       max(abs(w(*,*,8)-wref(*,*,8)))/max(abs(wref(*,*,8)))

filename=resdir+'40/GM/z*.outs'
.r getpict
wref=w
wref(*,*,4)= exp(-10.0*0.025*(!pi/5)^2)*cos(!pi/5*x(*,*,1))
wref(*,*,6)=-exp(-10.0*0.025*(!pi/5)^2)*sin(!pi/5*x(*,*,1))
wref(*,*,8)= 1.0-2./3*0.5*(exp(-2.*10.*0.025*(!pi/5)^2)-1.)
printf,99,40,rel_error(w,wref,iws),$
       max(abs(w(*,*,4)-wref(*,*,4)))/max(abs(wref(*,*,4)))+$
       max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))+$
       max(abs(w(*,*,8)-wref(*,*,8)))/max(abs(wref(*,*,8)))
close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps,/port
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),wlog(*,1),xrange=[1e-2,1e-1],yrange=[6e-5,5e-3],$
        ystyle=1,psym=-2,thick=4, $
        xtitle='Grid resolution', $
        ytitle='relative error', $
        title="resistivity wave-test"
oplot,1/wlog(*,0),wlog(*,2),psym=-4,thick=4
oplot,[1e-2,1e-1],[1.1e-5,1.1e-3],linestyle=2,thick=3
oplot,[1e-2,1e-1],[4.2e-5,4.2e-3],linestyle=2,thick=3
xyouts,0.05,0.0002,'L1'
xyouts,0.05,0.00075,'Linf'
xyouts,0.025,0.002,'2nd order slope'
close_device,/pdf

exit
