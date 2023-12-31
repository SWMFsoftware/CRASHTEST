; 1. plot results, 2. calculate errors, 3. plot errors

; 1. plot results for various solvers and resolutions
resdir='test_shu_osher_1d_results/'

filename_ref = 'test_shu_osher_1d_ref.out '

!x.range=[0,3]
firstpict=[1,10]
npictmax=1
func='rho'
multiplot=1
bottomline=1

filename = filename_ref + resdir+'Rusanov2_*/GM/1d*.outs'
plottitle='Rusanov2 n=200, 400, 800 vs reference'
set_device, resdir + 'Rusanov2.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Linde2_*/GM/1d*.outs'
plottitle='Linde2 n=200, 400, 800 vs reference'
set_device, resdir + 'Linde2.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Godunov2_*/GM/1d*.outs'
plottitle='Godunov2 n=200, 400, 800 vs reference'
set_device, resdir + 'Godunov2.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Rusanov3_*/GM/1d*.outs'
plottitle='Rusanov3 n=200, 400, 800 vs reference'
set_device, resdir + 'Rusanov3.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Linde3_*/GM/1d*.outs'
plottitle='Linde3 n=200, 400, 800 vs reference'
set_device, resdir + 'Linde3.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Godunov3_*/GM/1d*.outs'
plottitle='Godunov3 n=200, 400, 800 vs reference'
set_device, resdir + 'Godunov3.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Rusanov4_*/GM/1d*.outs'
plottitle='Rusanov4 n=200, 400, 800 vs reference'
set_device, resdir + 'Rusanov4.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Linde4_*/GM/1d*.outs'
plottitle='Linde4 n=200, 400, 800 vs reference'
set_device, resdir + 'Linde4.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Godunov4_*/GM/1d*.outs'
plottitle='Godunov4 n=200, 400, 800 vs reference'
set_device, resdir + 'Godunov4.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Rusanov5_*/GM/1d*.outs'
plottitle='Rusanov5 n=200, 400, 800 vs reference'
set_device, resdir + 'Rusanov5.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Linde5_*/GM/1d*.outs'
plottitle='Linde5 n=200, 400, 800 vs reference'
set_device, resdir + 'Linde5.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'Godunov5_*/GM/1d*.outs'
plottitle='Godunov5 n=200, 400, 800 vs reference'
set_device, resdir + 'Godunov5.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'RusanovMP5_[248]00/GM/1d*.outs'
plottitle='RusanovMP5 n=200, 400, 800 vs reference'
set_device, resdir + 'RusanovMP5.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'LindeMP5_[248]00/GM/1d*.outs'
plottitle='LindeMP5 n=200, 400, 800 vs reference'
set_device, resdir + 'LindeMP5.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'GodunovMP5_[248]00/GM/1d*.outs'
plottitle='GodunovMP5 n=200, 400, 800 vs reference'
set_device, resdir + 'GodunovMP5.eps', /eps, /land
.r animate
close_device,/pdf


filename = filename_ref + resdir+'RusanovCWENO5_[248]00/GM/1d*.outs'
plottitle='RusanovCWENO5 n=200, 400, 800 vs reference'
set_device, resdir + 'RusanovCWENO5.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'LindeCWENO5_[248]00/GM/1d*.outs'
plottitle='LindeCWENO5 n=200, 400, 800 vs reference'
set_device, resdir + 'LindeCWENO5.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'GodunovCWENO5_[248]00/GM/1d*.outs'
plottitle='GodunovCWENO5 n=200, 400, 800 vs reference'
set_device, resdir + 'GodunovCWENO5.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'RusanovMP5_InterpolateFlux_[248]00/GM/1d*.outs'
plottitle='RusanovMP5_InterpolateFlux n=200, 400, 800 vs reference'
set_device, resdir + 'RusanovMP5_InterpolateFlux.eps', /eps, /land
.r animate
close_device,/pdf

filename = filename_ref + resdir+'RusanovCWENO5_InterpolateFlux_[248]00/GM/1d*.outs'
plottitle='RusanovCWENO5_InterpolateFlux n=200, 400, 800 vs reference'
set_device, resdir + 'RusanovCWENO5_InterpolateFlux.eps', /eps, /land
.r animate
close_device,/pdf

!x.range=0

; 2. calculate errors and save it into a file

; read the reference solution
npict=1
filename = filename_ref
.r getpict
wref = w

; start writing error.dat
openw, 99, resdir + 'error.dat'
printf,99,'Shu-Osher test in 1D for Rusanov, Linde and Godunov schemes'+ $
       ' with TVD2, FIVOL using 3, 4 or 5 ghost cells, MP5 and CWENO5'
printf,99,'n r2 l2 g2 r3 l3 g3 r4 l4 g4 r5 l5 g5 rMP5 lMP5 gMP5 rCWENO5 lCWENO5 gWENO5 MP5_interp_flux CWENO5_interp_flux'

; array of errors indexed by methods and grid resolutions
errors = fltarr(20,3)

; read the last snapshot 
npict=10

; read at most 3 files at a time
filename=resdir+'Rusanov2_?00/GM/1d*.outs'
.r getpict
errors(0,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Linde2_?00/GM/1d*.outs'
.r getpict
errors(1,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Godunov2_?00/GM/1d*.outs'
.r getpict
errors(2,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Rusanov3_?00/GM/1d*.outs'
.r getpict
errors(3,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Linde3_?00/GM/1d*.outs'
.r getpict
errors(4,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Godunov3_?00/GM/1d*.outs'
.r getpict
errors(5,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Rusanov4_?00/GM/1d*.outs'
.r getpict
errors(6,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Linde4_?00/GM/1d*.outs'
.r getpict
errors(7,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Godunov4_?00/GM/1d*.outs'
.r getpict
errors(8,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Rusanov5_?00/GM/1d*.outs'
.r getpict
errors(9,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Linde5_?00/GM/1d*.outs'
.r getpict
errors(10,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'Godunov5_?00/GM/1d*.outs'
.r getpict
errors(11,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'RusanovMP5_?00/GM/1d*.outs'
.r getpict
errors(12,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'LindeMP5_?00/GM/1d*.outs'
.r getpict
errors(13,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'GodunovMP5_?00/GM/1d*.outs'
.r getpict
errors(14,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'RusanovCWENO5_?00/GM/1d*.outs'
.r getpict
errors(15,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'LindeCWENO5_?00/GM/1d*.outs'
.r getpict
errors(16,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'GodunovCWENO5_?00/GM/1d*.outs'
.r getpict
errors(17,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'RusanovMP5_InterpolateFlux_?00/GM/1d*.outs'
.r getpict
errors(18,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

filename=resdir+'RusanovCWENO5_InterpolateFlux_?00/GM/1d*.outs'
.r getpict
errors(19,*) = rel_errors(w0,w1,w2,wref,ivar=[0])

printf,99,200,errors(*,0),format='(i3,20e10.3)'
printf,99,400,errors(*,1),format='(i3,20e10.3)'
printf,99,800,errors(*,2),format='(i3,20e10.3)'

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
loadct,39
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,[1e-3,1e-1],[1e-3,1e-1], $
  xrange=[1e-3,1e-1],yrange=[2e-3,2e-1],linestyle=2,ystyle=1, $
  xtitle='Grid resolution', $
  ytitle='Relative error', $
  title="Shu-Osher test in 1D"
oplot,10/wlog(*,0),wlog(*,1),psym=-4,thick=3
oplot,10/wlog(*,0),wlog(*,2),psym=-5,thick=3
oplot,10/wlog(*,0),wlog(*,3),psym=-6,thick=3

oplot,10/wlog(*,0),wlog(*,4),psym=-4,thick=3,color=100
oplot,10/wlog(*,0),wlog(*,5),psym=-5,thick=3,color=100
oplot,10/wlog(*,0),wlog(*,6),psym=-6,thick=3,color=100

oplot,10/wlog(*,0),wlog(*,7),psym=-4,thick=3,color=150
oplot,10/wlog(*,0),wlog(*,8),psym=-5,thick=3,color=150
oplot,10/wlog(*,0),wlog(*,9),psym=-6,thick=3,color=150

oplot,10/wlog(*,0),wlog(*,10),psym=-4,thick=3,color=250,symsize=2
oplot,10/wlog(*,0),wlog(*,11),psym=-5,thick=3,color=250,symsize=2
oplot,10/wlog(*,0),wlog(*,12),psym=-6,thick=3,color=250,symsize=2

oplot,10/wlog(*,0),wlog(*,13),psym=-4,thick=3,color=50,symsize=2
oplot,10/wlog(*,0),wlog(*,14),psym=-5,thick=3,color=50,symsize=2
oplot,10/wlog(*,0),wlog(*,15),psym=-6,thick=3,color=50,symsize=2

oplot,10/wlog(*,0),wlog(*,16),psym=-4,thick=3,color=200,symsize=2
oplot,10/wlog(*,0),wlog(*,17),psym=-5,thick=3,color=200,symsize=2
oplot,10/wlog(*,0),wlog(*,18),psym=-6,thick=3,color=200,symsize=2

oplot,10/wlog(*,0),wlog(*,19),psym=-1,thick=3,color=15,symsize=2
oplot,10/wlog(*,0),wlog(*,20),psym=-7,thick=3,color=15,symsize=2

x0=0.0012
x1=0.0015
x2=0.0017
x=0.002
y=0.16
dy=1.32
dy2=1.07

oplot,[x0,x2],[y,y],linestyle=2 & xyouts,x,y/dy2,'1st order slope'

y=y/dy & oplot,[x1],[y],psym=4 & xyouts,x,y/dy2,'Rusanov2'
y=y/dy & oplot,[x1],[y],psym=5 & xyouts,x,y/dy2,'Linde2'
y=y/dy & oplot,[x1],[y],psym=6 & xyouts,x,y/dy2,'Godunov2'

y=y/dy & oplot,[x1],[y],psym=4,color=100 & xyouts,x,y/dy2,'Rusanov3'
y=y/dy & oplot,[x1],[y],psym=5,color=100 & xyouts,x,y/dy2,'Linde3'
y=y/dy & oplot,[x1],[y],psym=6,color=100 & xyouts,x,y/dy2,'Godunov3'

y=y/dy & oplot,[x1],[y],psym=4,color=150 & xyouts,x,y/dy2,'Rusanov4'
y=y/dy & oplot,[x1],[y],psym=5,color=150 & xyouts,x,y/dy2,'Linde4'
y=y/dy & oplot,[x1],[y],psym=6,color=150 & xyouts,x,y/dy2,'Godunov4'

y=y/dy & oplot,[x1],[y],psym=4,color=250,symsize=2 & xyouts,x,y/dy2,'Rusanov5'
y=y/dy & oplot,[x1],[y],psym=5,color=250,symsize=2 & xyouts,x,y/dy2,'Linde5'
y=y/dy & oplot,[x1],[y],psym=6,color=250,symsize=2 & xyouts,x,y/dy2,'Godunov5'

y=y/dy & oplot,[x1],[y],psym=4,color=50,symsize=2 & xyouts,x,y/dy2,'RusanovMP5'
y=y/dy & oplot,[x1],[y],psym=5,color=50,symsize=2 & xyouts,x,y/dy2,'LindeMP5'
y=y/dy & oplot,[x1],[y],psym=6,color=50,symsize=2 & xyouts,x,y/dy2,'GodunovMP5'

y=0.16
dy2=1.07
dy=1.32
x1=0.008
x=0.01

oplot,[x1],[y],psym=1,color=15,symsize=2 & xyouts,x,y/dy2,'MP5_Interpolate_Flux'
y=y/dy & oplot,[x1],[y],psym=7,color=15,symsize=2 & xyouts,x,y/dy2,'CWENO5_Interpolate_Flux'
y=y/dy & oplot,[x1],[y],psym=4,color=200,symsize=2 & xyouts,x,y/dy2,'RusanovCWENO5'
y=y/dy & oplot,[x1],[y],psym=5,color=200,symsize=2 & xyouts,x,y/dy2,'LindeCWENO5'
y=y/dy & oplot,[x1],[y],psym=6,color=200,symsize=2 & xyouts,x,y/dy2,'GodunovCWENO5'

close_device,/pdf

exit
