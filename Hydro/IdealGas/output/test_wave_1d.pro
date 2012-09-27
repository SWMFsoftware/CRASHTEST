; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

; use local procedure to write out resolution only
.r putbottom 

resdir='test_wave_1d_results/'

firstpict=11
npictmax=1
func='rho ux p'
!p.charsize=1.4
!p.thick=3

filename = resdir+'Linde2_*0_/GM/*.outs'
set_device,resdir+'linde.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov2_*0_/GM/*.outs'
set_device,resdir+'godunov2.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov4_*0_NONCONS/GM/*.outs'
set_device,resdir+'godunov4_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Simple4_*0_NONCONS/GM/*.outs'
set_device,resdir+'simple4_noncons.eps',/eps, /land
.r animate
close_device,/pdf

; 2. calculate errors and save them into a file

filename='test_wave_1d_ref.out'
.r getpict
wref = w

openw,99,resdir+'error.dat'
printf,99,'Wave test in 1D for Godunov, Linde, Rusanov and Simple schemes'+ $
       ', 2nd and 4th order, energy and pressure equations'
printf,99,'n g2e g2p l2e l2p r4n r4p s4n s4p'

; array of errors indexed by methods and grid resolutions
errors = fltarr(8,3)

; read the last state for comparison
npict=11

; compare density, momentum and energy only (momentum error dominates)
iws=[0,1,3]

; read at most 3 files at a time
filename=resdir+'Godunov2_???_/GM/*.outs'
.r getpict
errors(0,*) = [rel_error(w0,wref), rel_error(w1,wref), rel_error(w2,wref)]

filename=resdir+'Godunov2_???_NONCONS/GM/*.outs'
.r getpict
errors(1,*) = [rel_error(w0,wref), rel_error(w1,wref), rel_error(w2,wref)]

filename=resdir+'Linde2_???_/GM/c*.outs'
.r getpict
errors(2,*) = [rel_error(w0,wref), rel_error(w1,wref), rel_error(w2,wref)]

filename=resdir+'Linde2_???_NONCONS/GM/*.outs'
.r getpict
errors(3,*) = [rel_error(w0,wref), rel_error(w1,wref), rel_error(w2,wref)]

filename=resdir+'Rusanov4_???_/GM/*.outs'
.r getpict
errors(4,*) = [rel_error(w0,wref), rel_error(w1,wref), rel_error(w2,wref)]

filename=resdir+'Rusanov4_???_NONCONS/GM/*.outs'
.r getpict
errors(5,*) = [rel_error(w0,wref), rel_error(w1,wref), rel_error(w2,wref)]

filename=resdir+'Simple4_???_/GM/*.outs'
.r getpict
errors(6,*) = [rel_error(w0,wref), rel_error(w1,wref), rel_error(w2,wref)]

filename=resdir+'Simple4_???_NONCONS/GM/*.outs'
.r getpict
errors(7,*) = [rel_error(w0,wref), rel_error(w1,wref), rel_error(w2,wref)]

printf,99,100,errors(*,0),format='(i3,8e10.3)'
printf,99,200,errors(*,1),format='(i3,8e10.3)'
printf,99,400,errors(*,2),format='(i3,8e10.3)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1
!p.thick=3

set_device,resdir+'error.eps',/eps, /land
logfilename=resdir+'error.dat'
.r getlog

; error.dat header: 'n godunov g_noncons linde l_noncons'

plot_oo,[1e-2,1e-1],[1e-4,1e-2], $
  xrange=[1e-3,1e-1],yrange=[1e-6,5e-2],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Sound wave test in 1D"

oplot,[1e-2,1e-1],[1e-6,1e-2],linestyle=1

oplot,4/wlog(*,0),wlog(*,1),psym=-1
oplot,4/wlog(*,0),wlog(*,2),psym=-2
oplot,4/wlog(*,0),wlog(*,3),psym=-4
oplot,4/wlog(*,0),wlog(*,4),psym=-5

oplot,4/wlog(*,0),wlog(*,5),psym=-1,symsize=2
oplot,4/wlog(*,0),wlog(*,6),psym=-2,symsize=2
oplot,4/wlog(*,0),wlog(*,7),psym=-4,symsize=2
oplot,4/wlog(*,0),wlog(*,8),psym=-5,symsize=2

oplot,[0.0002,0.0017],[0.0005,0.0005],linestyle=2
xyouts,0.002,0.0005,'2nd order slope'
oplot,[0.0015],[0.002],psym=1 & xyouts,0.002,0.002,'Godunov2 conserv.'
oplot,[0.0015],[0.004],psym=2 & xyouts,0.002,0.004,'Godunov2 noncons.'
oplot,[0.0015],[0.008],psym=5 & xyouts,0.002,0.008,'Linde2 noncons.'
oplot,[0.0015],[0.016],psym=4 & xyouts,0.002,0.016,'Linde2 conserv.'

oplot,[0.0015],[0.00002],psym=1 & xyouts,0.002,0.00002,'Rusanov4 conserv.'
oplot,[0.0015],[0.00004],psym=2 & xyouts,0.002,0.00004,'Rusanov4 noncons.'
oplot,[0.0015],[0.00008],psym=5 & xyouts,0.002,0.00008,'Simple4 noncons.'
oplot,[0.0015],[0.00016],psym=4 & xyouts,0.002,0.00016,'Simple4 conserv.'

oplot,[0.0002,0.0017],[0.000005,0.000005],linestyle=1
xyouts,0.002,0.000005,'4th order slope'

close_device,/pdf

exit
