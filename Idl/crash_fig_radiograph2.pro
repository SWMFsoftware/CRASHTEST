; create a radiograph figure
filename = 'los*.outs'
loadct,3
transform='n'
!p.charsize=1.8
!p.font=0
npict=1000
.r getpict
cut=grid(100:300,150:250)
plottitle='radiograph'
func='radiograph randomn(seed,400,400,poisson=50)*smooth(exp({radiograph}/1000),3) radiograph'
plotmode='contbar contbarlog
contourlevel=100
multiplot=-2
!x.range=0
!y.range=0
bottomline = "'time = ' + string(time*1e9, format='(f4.1)')+' ns'"
set_device,'crash_radiograph.eps',/eps,/port
.r plotfunc
close_device,/pdf
