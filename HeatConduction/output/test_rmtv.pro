; 1. plot results, 2. calculate errors, 3. plot errors

transform='n'

; 1. plot results for various solvers and resolutions
resdir='test_rmtv_results/'

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

close,99

; 3. Create a figure of convergence rates
!p.charsize=2
!p.charthick=1

set_device, resdir + 'error.eps', /eps, /land
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
