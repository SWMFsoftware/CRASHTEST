; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions

resdir='test_wave_1d_results/'

firstpict=[9,11,11]
npictmax=1
func='rho ux p'
!p.charsize=1.4
!p.thick=3
bottomline='"              n ="+snx'

filename = resdir+'Rusanov2_[345]*_/GM/*.outs'
set_device,resdir+'rusanov2.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov2_[345]*_/GM/*.outs'
set_device,resdir+'godunov2.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Rusanov2_[345]*_NONCONS/GM/*.outs'
set_device,resdir+'rusanov2_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Godunov2_[345]*_/GM/*.outs'
set_device,resdir+'godunov2_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Rusanov3_[345]*_/GM/*.outs'
set_device,resdir+'rusanov3.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Rusanov4_[345]*_/GM/*.outs'
set_device,resdir+'rusanov4.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Rusanov5_[345]*_/GM/*.outs'
set_device,resdir+'rusanov5.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovMP5RK3_[345]*_/GM/*.outs'
set_device,resdir+'rusanovMP5RK3.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovMP5RK4_[345]*_/GM/*.outs'
set_device,resdir+'rusanovMP5RK4.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovCWENO5RK3_[345]*_/GM/*.outs'
set_device,resdir+'rusanovCWENO5RK3.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovCWENO5RK4_[345]*_/GM/*.outs'
set_device,resdir+'rusanovCWENO5RK4.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovFDCWENO5RK4_[345]*_/GM/*.outs'
set_device,resdir+'rusanovFDCWENO5RK4.eps',/eps, /land
.r animate
close_device,/pdf


filename = resdir+'Rusanov3_[345]*_NONCONS/GM/*.outs'
set_device,resdir+'rusanov3_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Rusanov4_[345]*_NONCONS/GM/*.outs'
set_device,resdir+'rusanov4_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'Rusanov5_[345]*_NONCONS/GM/*.outs'
set_device,resdir+'rusanov5_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovMP5RK3_[345]*_NONCONS/GM/*.outs'
set_device,resdir+'rusanovMP5RK3_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovMP5RK4_NONCONS[345]*/GM/*.outs'
set_device,resdir+'rusanovMP5RK4_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovCWENO5RK3_[345]*_NONCONS/GM/*.outs'
set_device,resdir+'rusanovCWENO5RK3_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovCWENO5RK4_[345]*_NONCONS/GM/*.outs'
set_device,resdir+'rusanovCWENO5RK4_noncons.eps',/eps, /land
.r animate
close_device,/pdf

filename = resdir+'RusanovFDCWENO5RK4_[345]*_NONCONS/GM/*.outs'
set_device,resdir+'rusanovFDCWENO5RK4_noncons.eps',/eps, /land
.r animate
close_device,/pdf

; 2. calculate errors and save them into a file

filename='test_wave_1d_ref.out'
.r getpict
wref = w

openw,99,resdir+'error.dat'
printf,99,'Wave test in 1D for Rusanov and Godunov flux'+ $
       ' with TVD2, FIVOL with 3, 4, and 5 ghost cells, MP5 with RK3 and RK4, CWENO5, FDCWENO5'+ $
       ' energy and pressure equations'

printf,99,'n g2e g2p r2e r2p g3e g3p r3e r3p r4e r4p r5e r5p mp5e mp5p mp5rk4e mp5rk4p cweno5rk3e cweno5rk3p cweno5rk4e cweno5rk4p fdcweno5rk4e fdcweno5rk4p'

; array of errors indexed by methods and grid resolutions
errors = fltarr(22,5)

; read the last state for comparison
npict=11

; compare density, momentum and energy (momentum error dominates)
ivar=[0,1,3]

; read at most 3 files at a time
filename=resdir+'Godunov2_??_/GM/*.outs'
.r getpict
errors(0,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Godunov2_???_/GM/*.outs'
.r getpict
errors(0,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Godunov2_??_NONCONS/GM/*.outs'
.r getpict
errors(1,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Godunov2_???_NONCONS/GM/*.outs'
.r getpict
errors(1,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Rusanov2_??_/GM/*.outs'
.r getpict
errors(2,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Rusanov2_???_/GM/*.outs'
.r getpict
errors(2,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Rusanov2_??_NONCONS/GM/*.outs'
.r getpict
errors(3,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Rusanov2_???_NONCONS/GM/*.outs'
.r getpict
errors(3,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Godunov3_??_/GM/*.outs'
.r getpict
errors(4,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Godunov3_???_/GM/*.outs'
.r getpict
errors(4,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Godunov3_??_NONCONS/GM/*.outs'
.r getpict
errors(5,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Godunov3_???_NONCONS/GM/*.outs'
.r getpict
errors(5,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Rusanov3_??_/GM/*.outs'
.r getpict
errors(6,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Rusanov3_???_/GM/*.outs'
.r getpict
errors(6,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Rusanov3_??_NONCONS/GM/*.outs'
.r getpict
errors(7,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Rusanov3_???_NONCONS/GM/*.outs'
.r getpict
errors(7,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Rusanov4_??_/GM/*.outs'
.r getpict
errors(8,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Rusanov4_???_/GM/*.outs'
.r getpict
errors(8,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Rusanov4_??_NONCONS/GM/*.outs'
.r getpict
errors(9,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Rusanov4_???_NONCONS/GM/*.outs'
.r getpict
errors(9,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Rusanov5_??_/GM/*.outs'
.r getpict
errors(10,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Rusanov5_???_/GM/*.outs'
.r getpict
errors(10,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'Rusanov5_??_NONCONS/GM/*.outs'
.r getpict
errors(11,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'Rusanov5_???_NONCONS/GM/*.outs'
.r getpict
errors(11,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovMP5RK3_??_/GM/*.outs'
.r getpict
errors(12,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovMP5RK3_???_/GM/*.outs'
.r getpict
errors(12,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovMP5RK3_??_NONCONS/GM/*.outs'
.r getpict
errors(13,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovMP5RK3_???_NONCONS/GM/*.outs'
.r getpict
errors(13,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovMP5RK4_??_/GM/*.outs'
.r getpict
errors(14,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovMP5RK4_???_/GM/*.outs'
.r getpict
errors(14,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovMP5RK4_??_NONCONS/GM/*.outs'
.r getpict
errors(15,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovMP5RK4_???_NONCONS/GM/*.outs'
.r getpict
errors(15,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovCWENO5RK3_??_/GM/*.outs'
.r getpict
errors(16,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovCWENO5RK3_???_/GM/*.outs'
.r getpict
errors(16,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovCWENO5RK3_??_NONCONS/GM/*.outs'
.r getpict
errors(17,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovCWENO5RK3_???_NONCONS/GM/*.outs'
.r getpict
errors(17,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovCWENO5RK4_??_/GM/*.outs'
.r getpict
errors(18,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovCWENO5RK4_???_/GM/*.outs'
.r getpict
errors(18,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovCWENO5RK4_??_NONCONS/GM/*.outs'
.r getpict
errors(19,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovCWENO5RK4_???_NONCONS/GM/*.outs'
.r getpict
errors(19,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovFDCWENO5RK4_??_/GM/*.outs'
.r getpict
errors(20,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovFDCWENO5RK4_???_/GM/*.outs'
.r getpict
errors(20,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

filename=resdir+'RusanovFDCWENO5RK4_??_NONCONS/GM/*.outs'
.r getpict
errors(21,0:1) = rel_errors(w0,w1,wref,ivar=ivar)
filename=resdir+'RusanovFDCWENO5RK4_???_NONCONS/GM/*.outs'
.r getpict
errors(21,2:4) = rel_errors(w0,w1,w2,wref,ivar=ivar)

printf,99, 30,errors(*,0),format='(i3,22e10.3)'
printf,99, 50,errors(*,1),format='(i3,22e10.3)'
printf,99,100,errors(*,2),format='(i3,22e10.3)'
printf,99,200,errors(*,3),format='(i3,22e10.3)'
printf,99,400,errors(*,4),format='(i3,22e10.3)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1
!p.thick=3

set_device,resdir+'error.eps',/eps, /land
loadct,39
logfilename=resdir+'error.dat'
.r getlog

plot_oo,[1e-2,1e0],[1e-3,1e1],  $
  xrange=[1e-3,2e-1], yrange=[1e-6,1e-1], xstyle=1, ystyle=3, $
  linestyle=2, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Sound wave test in 1D"

oplot,[1e-2,1e0],[3e-6,3e2],linestyle=1

oplot,4/wlog(*,0),wlog(*,1),psym=-1
oplot,4/wlog(*,0),wlog(*,2),psym=-7
oplot,4/wlog(*,0),wlog(*,3),psym=-6
oplot,4/wlog(*,0),wlog(*,4),psym=-4

oplot,4/wlog(*,0),wlog(*,5),psym=-1,color=150
oplot,4/wlog(*,0),wlog(*,6),psym=-7,color=150
oplot,4/wlog(*,0),wlog(*,7),psym=-6,color=150
oplot,4/wlog(*,0),wlog(*,8),psym=-4,color=150

oplot,4/wlog(*,0),wlog(*, 9),psym=-1,color=250
oplot,4/wlog(*,0),wlog(*,10),psym=-7,color=250
oplot,4/wlog(*,0),wlog(*,11),psym=-6,color=250
oplot,4/wlog(*,0),wlog(*,12),psym=-4,color=250

oplot,4/wlog(*,0),wlog(*,13),psym=-1,color=100
oplot,4/wlog(*,0),wlog(*,14),psym=-7,color=100
oplot,4/wlog(*,0),wlog(*,15),psym=-6,color=100
oplot,4/wlog(*,0),wlog(*,16),psym=-4,color=100

oplot,4/wlog(*,0),wlog(*,17),psym=-1,color=200
oplot,4/wlog(*,0),wlog(*,18),psym=-7,color=200
oplot,4/wlog(*,0),wlog(*,19),psym=-6,color=200
oplot,4/wlog(*,0),wlog(*,20),psym=-4,color=200

oplot,[0.0011,0.0015],[0.004,0.004],linestyle=2 & xyouts,0.0016,0.004,'2nd order slope'
oplot,[0.0012],[0.008],psym=1 & xyouts,0.0016,0.008,'Godunov2 conserv.'
oplot,[0.0012],[0.016],psym=7 & xyouts,0.0016,0.016,'Godunov2 noncons.'
oplot,[0.0012],[0.032],psym=6 & xyouts,0.0016,0.032,'Rusanov2 conserv.'
oplot,[0.0012],[0.064],psym=4 & xyouts,0.0016,0.064,'Rusanov2 noncons.'

oplot,[0.0012],[0.00008],psym=1,color=150 & xyouts,0.0016,0.00008,'Godunov3 conserv.'
oplot,[0.0012],[0.00016],psym=7,color=150 & xyouts,0.0016,0.00016,'Godunov3 noncons.'
oplot,[0.0012],[0.00032],psym=6,color=150 & xyouts,0.0016,0.00032,'Rusanov3 conserv.'
oplot,[0.0012],[0.00064],psym=4,color=150 & xyouts,0.0016,0.00064,'Rusanov3 noncons.'

oplot,[0.0012],[0.000005],psym=1,color=250 & xyouts,0.0016,0.000005,'Rusanov4 conserv.'
oplot,[0.0012],[0.00001] ,psym=7,color=250 & xyouts,0.0016,0.00001, 'Rusanov4 noncons.'
oplot,[0.0012],[0.00002] ,psym=6,color=250 & xyouts,0.0016,0.00002, 'Rusanov5 conserv.'
oplot,[0.0012],[0.00004] ,psym=4,color=250 & xyouts,0.0016,0.00004, 'Rusanov5 noncons.'

oplot,[0.03],[6e-5] ,  psym=1,color=100 & xyouts,0.035,6e-5, 'Rusanov MP5RK3 cons.',charsize=1.5
oplot,[0.03],[1e-4] ,  psym=7,color=100 & xyouts,0.035,1e-4, 'Rusanov MP5RK3 nonc.',charsize=1.5
oplot,[0.03],[3e-5] ,  psym=6,color=100 & xyouts,0.035,3e-5, 'Rusanov MP5RK4 cons.',charsize=1.5
oplot,[0.03],[1.5e-5] ,psym=4,color=100 & xyouts,0.035,1.5e-5, 'Rusanov MP5RK4 nonc.',charsize=1.5
oplot,[0.017],[8e-6],  psym=1,color=200 & xyouts,0.02,8e-6, 'Rusanov CWENO5RK3 cons.',charsize=1.5
oplot,[0.017],[5e-6],  psym=7,color=200 & xyouts,0.02,5e-6, 'Rusanov CWENO5RK3 nonc.',charsize=1.5
oplot,[0.017],[2e-6],  psym=6,color=200 & xyouts,0.02,2e-6, 'Rusanov CWENO5RK4 cons.',charsize=1.5
oplot,[0.017],[1e-6],  psym=4,color=200 & xyouts,0.02,1e-6, 'Rusanov CWENO5RK4 nonc.',charsize=1.5

oplot,[0.0011,0.0015],[2e-6,2e-6],linestyle=1 & xyouts,0.0016,2e-6,'4th order slope'

close_device,/pdf

exit
