      SUBROUTINE tce_dens_hphh_offset(l_a_offset,k_a_offset,size)
C     i0 ( h5 p3 h1 h2 )
      IMPLICIT NONE
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "errquit.fh"
#include "tce.fh"
      INTEGER l_a_offset
      INTEGER k_a_offset
      INTEGER size
      INTEGER length
      INTEGER addr
      INTEGER h1b
      INTEGER p2b
      INTEGER h3b
      INTEGER h4b
      length = 0
      DO h1b = 1,noab
      DO p2b = noab+1,noab+nvab
      DO h3b = 1,noab
      DO h4b = h3b,noab
      IF (int_mb(k_spin+h1b-1)+int_mb(k_spin+p2b-1) .eq. int_mb(k_spin+h
     &3b-1)+int_mb(k_spin+h4b-1)) THEN
      IF (ieor(int_mb(k_sym+h1b-1),ieor(int_mb(k_sym+p2b-1),ieor(int_mb(
     &k_sym+h3b-1),int_mb(k_sym+h4b-1)))) .eq. irrep_e) TH
     &EN
      IF ((.not.restricted).or.(int_mb(k_spin+h1b-1)+int_mb(k_spin+p2b-1
     &)+int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('vt1t1_1_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h1b = 1,noab
      DO p2b = noab+1,noab+nvab
      DO h3b = 1,noab
      DO h4b = h3b,noab
      IF (int_mb(k_spin+h1b-1)+int_mb(k_spin+p2b-1) .eq. int_mb(k_spin+h
     &3b-1)+int_mb(k_spin+h4b-1)) THEN
      IF (ieor(int_mb(k_sym+h1b-1),ieor(int_mb(k_sym+p2b-1),ieor(int_mb(
     &k_sym+h3b-1),int_mb(k_sym+h4b-1)))) .eq. irrep_e) TH
     &EN
      IF ((.not.restricted).or.(int_mb(k_spin+h1b-1)+int_mb(k_spin+p2b-1
     &)+int_mb(k_spin+h3b-1)+int_mb(k_spin+h4b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = h4b - 1 + noab * (h3b - 1 + noab * 
     &(p2b - noab - 1+ nvab * (h1b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+p2b-1) * int_mb(k_range+h1b-1) * int_
     &mb(k_range+h3b-1) * int_mb(k_range+h4b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
c $Id: tce_dens_hphh_offset.F 21176 2011-10-10 06:35:49Z d3y133 $
