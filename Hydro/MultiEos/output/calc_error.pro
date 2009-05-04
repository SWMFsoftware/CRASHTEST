function calc_error,win,wrefin

  w     = win
  wref  = wrefin

  s     = size(w)
  ndim  = s(0) - 1
  sref  = size(wref)
  nx    = s(1)
  nxref = sref(1)

  ;w    = w(0:nx/10-1,*)
  ;wref = wref(0:nxref/10-1,*)

  if ndim eq 1 then begin
                                ; 1D: errors in rho, ux, p, Eint
                                ; Coarsen the reference solution if needed
     if nxref ne nx then wref = coarsen(wref, [nxref/nx, 1])
     return, (  total(abs(w(*,0)-wref(*,0)))/ total(abs(wref(*,0))) $
              + total(abs(w(*,1)-wref(*,1)))/ total(abs(wref(*,1))) $
              + total(abs(w(*,4)-wref(*,4)))/ total(abs(wref(*,4))) $
              + total(abs(w(*,5)-wref(*,5)))/ total(abs(wref(*,5))))/4
  endif else $
                                ; 2D: errors in rho, ux, uy (norm ux), p, Eint
     return, (  total(abs(w(*,*,0)-wref(*,*,0)))/ total(abs(wref(*,*,0))) $
              + total(abs(w(*,*,1)-wref(*,*,1)))/ total(abs(wref(*,*,1))) $
              + total(abs(w(*,*,2)-wref(*,*,2)))/ total(abs(wref(*,*,1))) $
              + total(abs(w(*,*,4)-wref(*,*,4)))/ total(abs(wref(*,*,4))) $
              + total(abs(w(*,*,5)-wref(*,*,5)))/ total(abs(wref(*,*,5))))/5

end

