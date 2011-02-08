; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

resdir='test_wave_results/'

set_device,resdir+'biermann_wave.eps',/eps
filename=resdir+'*/GM/z*.outs'
func='bz {bz}+0.05*!pi^2/10000*sin(!pi/10*x)*sin(!pi/10*y)/(1+0.1*cos(!pi/10*x))^2
plottitle='B!DZ!N;Error in B!DZ!N'
!p.charsize=1.6
plotmode='contbar'
bottomline=0
firstpict=2
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
npict=2
.r getpict
wref=w
wref(*,*,6)=-0.05*!pi^2/10000*sin(!pi/10*x(*,*,0))*sin(!pi/10*x(*,*,1))/(1+0.1*cos(!pi/10*x(*,*,0)))^2
printf,99,10,rel_error(w,wref,iws),$
      max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))

filename=resdir+'20/GM/z*.outs'
.r getpict
wref=w
wref(*,*,6)=-0.05*!pi^2/10000*sin(!pi/10*x(*,*,0))*sin(!pi/10*x(*,*,1))/(1+0.1*cos(!pi/10*x(*,*,0)))^2
printf,99,20,rel_error(w,wref,iws),$
      max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))

filename=resdir+'40/GM/z*.outs'
.r getpict
wref=w
wref(*,*,6)=-0.05*!pi^2/10000*sin(!pi/10*x(*,*,0))*sin(!pi/10*x(*,*,1))/(1+0.1*cos(!pi/10*x(*,*,0)))^2
printf,99,40,rel_error(w,wref,iws),$
      max(abs(w(*,*,6)-wref(*,*,6)))/max(abs(wref(*,*,6)))
close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps,/port
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),wlog(*,1),xrange=[1e-2,1e-1],yrange=[5e-4,1e-0],$
        psym=-2,thick=4, $
        xtitle='Grid resolution', $
        ytitle='relative error', $
        title="Biermann wave-test"
oplot,1/wlog(*,0),wlog(*,2),psym=-4,thick=4
oplot,[1e-2,1e-1],[6e-2,6e-1],linestyle=2,thick=3
xyouts,0.03,0.5,'1st order slope',charsize=2,charthick=1
oplot,[1e-2,1e-1],[1.5e-4,1.5e-2],linestyle=2,thick=3
xyouts,0.03,0.01,'2nd order slope',charsize=2,charthick=1
oplot,[0.03],[0.0003],psym=4 & xyouts,0.035,0.00028,'maximum error'
oplot,[0.03],[0.0002],psym=2 & xyouts,0.035,0.00018,'L1 error'
close_device,/pdf

exit
