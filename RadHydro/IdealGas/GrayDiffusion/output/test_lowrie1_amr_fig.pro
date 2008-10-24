set_device,'test_lowrie1_amr.eps',/eps
logfilename='test_lowrie1_amr.err'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-1],yrange=[1e-4,1e-0],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 1"
oplot,[1e-3,1e-1],[2e-4,2e+0],linestyle=2  
xyouts,0.01,0.3,'2nd order slope',charsize=2,charthick=1
close_device

exit
