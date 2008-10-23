set_device,'test_lowrie3_2d.eps',/eps
logfilename='test_lowrie3_2d.err'
.r getlog
plot_oo,1/wlog(*,0),(wlog(*,1)),xrange=[1e-3,1e-2],yrange=[1e-3,1e-1],$
        psym=-4,charsize=2,thick=3, $
        xtitle='Grid resolution', $
        ytitle='Relative error', $
        title="Lowrie radhydro test 3"
oplot,[1e-3,1e-2],[2e-3,2e-2],linestyle=2  
xyouts,0.004,0.0052,'1st order slope',charsize=2,charthick=1
close_device
