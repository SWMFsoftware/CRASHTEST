; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

; use local procedure to write out resolution only
.r putbottom 

resdir='test_wave_1d_results/'

firstpict=15
npictmax=1
func='rho ux p Eint'
!p.charsize=1.4

filename = resdir+'Godunov_*0_/GM/*.outs'
set_device,resdir+'godunov.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*0_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'godunov_limit_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*0_MIXED_LIMIT/GM/*.outs'
set_device,resdir+'godunov_mixed_limit.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*0_MIXED_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'godunov_mixed_limit_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*0_NONCONS_LOOKUP/GM/*.outs'
set_device,resdir+'godunov_noncons_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*0_NONCONS_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'godunov_noncons_limit_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*0_NONCONS_MIXED_LIMIT/GM/*.outs'
set_device,resdir+'godunov_noncons_mixed_limit.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov_*0_NONCONS_MIXED_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'godunov_noncons_mixed_limit_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_/GM/*.outs'
set_device,resdir+'linde.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'linde_limit_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_MIXED_LIMIT/GM/*.outs'
set_device,resdir+'linde_mixed_limit.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_MIXED_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'linde_mixed_limit_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_NONCONS_LOOKUP/GM/*.outs'
set_device,resdir+'linde_noncons_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_NONCONS_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'linde_noncons_limit_lookup.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_NONCONS_MIXED_LIMIT/GM/*.outs'
set_device,resdir+'linde_noncons_mixed_limit.eps',/epe, /land
.r animate
close_device,/pdf

filename = resdir+'Linde_*0_NONCONS_MIXED_LIMIT_LOOKUP/GM/*.outs'
set_device,resdir+'linde_noncons_mixed_limit_lookup.eps',/epe, /land
.r animate
close_device,/pdf

; 2. calculate errors and save them into a file

filename='test_wave_1d_ref.out'
.r getpict
wref = w

openw,99,resdir+'error.dat'
printf,99,'Wave test in 1D'
printf,99,'n godunov g_noncons linde l_noncons'

; array of errors for a given resolution
errors = fltarr(4,3)

; read the last state for comparison
npict=21

; read at most 3 files at a time
filename=resdir+'Godunov_???_LIMIT_LOOKUP/GM/c*.outs'
.r getpict
errors(0,*)=[calc_error(w0,wref), calc_error(w1,wref), calc_error(w2,wref)]

filename=resdir+'Godunov_???_NONCONS_LIMIT_LOOKUP/GM/c*.outs'
.r getpict
errors(1,*)=[calc_error(w0,wref), calc_error(w1,wref), calc_error(w2,wref)]

filename=resdir+'Linde_???_LIMIT_LOOKUP/GM/c*.outs'
.r getpict
errors(2,*)=[calc_error(w0,wref), calc_error(w1,wref), calc_error(w2,wref)]

filename=resdir+'Linde_???_NONCONS_LIMIT_LOOKUP/GM/c*.outs'
.r getpict
errors(3,*)=[calc_error(w0,wref), calc_error(w1,wref), calc_error(w2,wref)]

printf,99,100,errors(*,0),format='(i3,12f7.4)'
printf,99,200,errors(*,1),format='(i3,12f7.4)'
printf,99,400,errors(*,2),format='(i3,12f7.4)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1
!p.thick=3

set_device,resdir+'error.eps',/epe, /land
logfilename=resdir+'error.dat'
.r getlog

; error.dat header: 'n godunov g_noncons linde l_noncons'

plot_oo,[1e-2,1e-1],[1e-3,1e-1], $
  xrange=[1e-3,1e-1],yrange=[1e-3,5e-1],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Be/Xe wave test in 1D"
oplot,4/wlog(*,0),wlog(*,1),psym=-1
oplot,4/wlog(*,0),wlog(*,2),psym=-2
oplot,4/wlog(*,0),wlog(*,3),psym=-4
oplot,4/wlog(*,0),wlog(*,4),psym=-5

oplot,[0.0012,0.0017],[0.005,0.005],linestyle=2
xyouts,0.002,0.005,'2nd order slope'
oplot,[0.0015],[0.16],psym=4 & xyouts,0.002,0.16,'Linde conserv.'
oplot,[0.0015],[0.08],psym=1 & xyouts,0.002,0.08,'Godunov conserv.'
oplot,[0.0015],[0.04],psym=5 & xyouts,0.002,0.04,'Linde noncons.'
oplot,[0.0015],[0.02],psym=2 & xyouts,0.002,0.02,'Godunov noncons.'

close_device,/pdf

exit
