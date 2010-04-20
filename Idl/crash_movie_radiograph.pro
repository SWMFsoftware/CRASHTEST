; create a radiograph movie
;window,xsize=640,ysize=388
window,xsize=960,ysize=582
filename = 'los*.outs'
loadct,3
transform='n'
!p.charsize=1.8
!p.font=0
npict=1
.r getpict
cut=grid(100:300,150:250)
plottitle='radiograph'
func='randomn(seed,400,400,poisson=50)*smooth(exp({radiograph}/1000),3)'
plotmode='contbarlog'
multiplot=0
!x.range=0
!y.range=0
bottomline = "'time = ' + string(time*1e9, format='(f4.1)')+' ns'"
spawn, 'rm -rf Movie'
savemovie='png'
firstpict=1
npictmax=1000
.r animate
