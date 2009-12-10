function calc_linf,w
  sizew = size(w)
  ndim = sizew(0) - 1

  case ndim of
     1: begin
        return, max(abs(w(*,0)-w(*,1)))
     end
     2: begin
        return, max(abs(w(*,*,0)-w(*,*,1)))
     end
     3: begin
        return, max(abs(w(*,*,*,0)-w(*,*,*,1)))
     end
  endcase
end
