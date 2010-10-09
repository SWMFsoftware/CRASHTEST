; create a radiation movie for multigroup full system runs
;window,xsize=640,ysize=388
window,xsize=960,ysize=582
filename = 'z=0_var_2_*.outs'
npict=1
transform='n'
.r getpict

loadct,39
!p.charsize=1.7
!p.font=0
!x.range=[0,2300]

; check for electron pressure
if fix(total(wnames eq 'pe')) then $
  func='level I11 I13 I15 trkev I17 I19 I21' $
else $
  func='level I11 I13 I15 trkev I17 I19 I21'

multiplot=[2,4,1]
plotmode='contbar contbarlog contbarlog contbarlog contbarlog contbarlog contbarlog contbarlog'
plottitle='Material level;I11;I13;I15;log Radiation Temp. [keV];I17;I19;I21'
bottomline = "'time = ' + string(time*1e9, format='(f4.1)')+' ns'"
spawn, 'rm -rf Movie'
savemovie='png'
firstpict=1
npictmax=1000
.r animate

