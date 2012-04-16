; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

resdir='test_wave_results/'

loadct,39
set_device,resdir+'biermann_wave.eps',/eps, /land
filename=resdir+'[124]0/GM/z*.outs'
func='bz {bz}+!pi^2/10000*sin(!pi/10*x)*sin(!pi/10*y)/(1+0.1*cos(!pi/10*x))^2
plottitle='B!DZ!N;Error in B!DZ!N'
!p.charsize=1.6
plotmode='contbar'
bottomline=0
firstpict=11
npictmax=1
multiplot=[2,3,0]
.r animate
close_device,/pdf

; 2. calculate errors and save them into a file
openw, 99, resdir + 'error.dat'
printf,99,'wave test in 2D'
printf,99,'n l1_error max_error'

iws = [6]

filename=resdir+'10/GM/z*.outs'
npict=11
.r getpict
wref=w
wref(*,*,6)=-!pi^2/10000*sin(!pi/10*x(*,*,0))*sin(!pi/10*x(*,*,1))/(1+0.1*cos(!pi/10*x(*,*,0)))^2
printf,99,10,rel_error(w,wref,iws),$
      max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))

filename=resdir+'20/GM/z*.outs'
.r getpict
wref=w
wref(*,*,6)=-!pi^2/10000*sin(!pi/10*x(*,*,0))*sin(!pi/10*x(*,*,1))/(1+0.1*cos(!pi/10*x(*,*,0)))^2
printf,99,20,rel_error(w,wref,iws),$
      max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))

filename=resdir+'40/GM/z*.outs'
.r getpict
wref=w
wref(*,*,6)=-!pi^2/10000*sin(!pi/10*x(*,*,0))*sin(!pi/10*x(*,*,1))/(1+0.1*cos(!pi/10*x(*,*,0)))^2
printf,99,40,rel_error(w,wref,iws),$
      max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))

filename=resdir+'80/GM/z*.outs'
.r getpict
wref=w
wref(*,*,6)=-!pi^2/10000*sin(!pi/10*x(*,*,0))*sin(!pi/10*x(*,*,1))/(1+0.1*cos(!pi/10*x(*,*,0)))^2
printf,99,80,rel_error(w,wref,iws),$
      max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),wlog(*,1),xrange=[1e-2,1e-1],yrange=[1e-3,1e-1],$
        psym=-2,thick=4, $
        xtitle='Grid resolution', $
        ytitle='relative error', $
        title="Biermann wave-test"
oplot,[1e-2,1e-1],[1e-3,1e-2],linestyle=2,thick=3
xyouts,0.03,0.002,'1st order slope',charsize=2,charthick=1
close_device,/pdf

exit
