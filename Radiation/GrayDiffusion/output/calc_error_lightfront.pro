function calc_error_lightfront,x,w
  nx = n_elements(x)
  wref=dblarr(nx)
  for ix=0,nx-1 do begin
     if x(ix) le 0.5 then begin
        wref(ix)=1
     endif else begin
        wref(ix)=0
     endelse
  endfor
  return,total(abs(w(*,0)-wref(*))*w(*,1))
end
