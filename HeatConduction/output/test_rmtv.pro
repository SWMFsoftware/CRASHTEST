; 1. plot results, 2. calculate errors, 3. plot errors

transform='n'

; 1. plot results for various solvers and resolutions
resdir='test_rmtv_results/'

!p.charsize=1.5
!p.charthick=1

filename=resdir+'200/GM/cut_var_3*.outs'
npict=8
.r getpict
set_device, resdir + 'final_solution_z=0.eps', /eps, /port
plot,x,w(*,4), $
  /norm,POS=[0.12,0.7,0.9,0.93], $
  psym=0,thick=2, $
  xtitle='Radius', $
  ytitle='density', $
  title='Reinicke Meyer-ter Vehn test!Cz=0 cut'
oplot,x,w(*,0),psym=1,thick=2
oplot,[0.69,0.73],[41.,41.],psym=0,thick=2 & xyouts,0.75,40.,'reference'
oplot,[0.695,0.725],[34.,34.],psym=1,thick=2 & xyouts,0.75,33.,'numerical'
plot,x,w(*,5), $
  /noerase, $
  /norm,POS=[0.12,0.39,0.9,0.62], $
  psym=0,thick=2, $
  xtitle='Radius', $
  ytitle='temperature'
oplot,x,w(*,1),psym=1,thick=2
plot,x,w(*,7), $
  /noerase, $
  /norm,POS=[0.12,0.08,0.9,0.31], $
  psym=0,thick=2, $
  xtitle='Radius', $
  ytitle='radial velocity'
oplot,x,w(*,3),psym=1,thick=1
close_device,/pdf

filename = resdir + '[24]00/GM/z*.outs'
bottomline=0
firstpict=8
npictmax=1
func='temp {temp}-{temp0}'
plottitle='temperature;temperature error'
plotmode='contbar'
multiplot=[2,2,0]
set_device, resdir + 'temperature.eps', /epe, /land
.r animate
xyouts,0.5,1.07,'Reinicke Meyer-ter Vehn test!Ctop row: 200x200, bottom row 400x400',/norm,charsize=2,alignment=0.5
close_device,/pdf

filename = resdir + '[24]00/GM/z*.outs'
bottomline=0
firstpict=8
npictmax=1
func='rho {rho}-{rho0}'
plottitle='density;density error'
plotmode='contbar'
multiplot=[2,2,0]
set_device, resdir + 'density.eps', /epe, /land
.r animate
xyouts,0.5,1.07,'Reinicke Meyer-ter Vehn test!Ctop row: 200x200, bottom row 400x400',/norm,charsize=2,alignment=0.5
close_device,/pdf


; 2. calculate errors and save it into a file
openw, 99, resdir + 'error.dat'
printf,99,'Reinicke Meyer-ter Vehn test'
printf,99,'n error'

; read the last snapshot 
npict=100

filename=resdir+'100/GM/z*.outs'
.r getpict
printf,99,100,calc_error(w)

filename=resdir+'200/GM/z*.outs'
.r getpict
printf,99,200,calc_error(w)

filename=resdir+'400/GM/z*.outs'
.r getpict
printf,99,400,calc_error(w)

;filename=resdir+'800/GM/z*.outs'
;.r getpict
;printf,99,800,calc_error(w)

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /epe, /land
logfilename = resdir + 'error.dat'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-2,1e-0],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='relative error', $
        title="Reinicke Meyer-ter Vehn"
oplot,[1e-3,1e-1],[3e-2,3e-0],linestyle=2,thick=3
xyouts,0.005,0.5,'1st order slope',charsize=2,charthick=1
close_device,/pdf

exit
