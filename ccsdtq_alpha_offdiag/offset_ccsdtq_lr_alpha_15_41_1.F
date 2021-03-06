      SUBROUTINE OFFSET_ccsdtq_lr_alpha_15_41_1(l_a_offset,k_a_offset,si
     &ze)
C     $Id: offset_ccsdtq_lr_alpha_15_41_1.F 19703 2010-10-29 17:30:23Z d3y133 $
C     This is a Fortran77 program generated by Tensor Contraction Engine v.1.0
C     Copyright (c) Battelle & Pacific Northwest National Laboratory (2002)
C     i2 ( h11 p17 h16 p9 )_ytrbtra
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
      INTEGER h11b
      INTEGER p17b
      INTEGER h16b
      INTEGER p9b
      length = 0
      DO h11b = 1,noab
      DO p17b = noab+1,noab+nvab
      DO h16b = 1,noab
      DO p9b = noab+1,noab+nvab
      IF (int_mb(k_spin+h11b-1)+int_mb(k_spin+p17b-1) .eq. int_mb(k_spin
     &+h16b-1)+int_mb(k_spin+p9b-1)) THEN
      IF (ieor(int_mb(k_sym+h11b-1),ieor(int_mb(k_sym+p17b-1),ieor(int_m
     &b(k_sym+h16b-1),int_mb(k_sym+p9b-1)))) .eq. ieor(irrep_y,ieor(irre
     &p_trb,irrep_tra))) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h11b-1)+int_mb(k_spin+p17b
     &-1)+int_mb(k_spin+h16b-1)+int_mb(k_spin+p9b-1).ne.8)) THEN
      length = length + 1
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      IF (.not.MA_PUSH_GET(mt_int,2*length+1,'noname',l_a_offset,k_a_off
     &set)) CALL ERRQUIT('ccsdtq_lr_alpha_15_41_1',0,MA_ERR)
      int_mb(k_a_offset) = length
      addr = 0
      size = 0
      DO h11b = 1,noab
      DO p17b = noab+1,noab+nvab
      DO h16b = 1,noab
      DO p9b = noab+1,noab+nvab
      IF (int_mb(k_spin+h11b-1)+int_mb(k_spin+p17b-1) .eq. int_mb(k_spin
     &+h16b-1)+int_mb(k_spin+p9b-1)) THEN
      IF (ieor(int_mb(k_sym+h11b-1),ieor(int_mb(k_sym+p17b-1),ieor(int_m
     &b(k_sym+h16b-1),int_mb(k_sym+p9b-1)))) .eq. ieor(irrep_y,ieor(irre
     &p_trb,irrep_tra))) THEN
      IF ((.not.restricted).or.(int_mb(k_spin+h11b-1)+int_mb(k_spin+p17b
     &-1)+int_mb(k_spin+h16b-1)+int_mb(k_spin+p9b-1).ne.8)) THEN
      addr = addr + 1
      int_mb(k_a_offset+addr) = p9b - noab - 1 + nvab * (h16b - 1 + noab
     & * (p17b - noab - 1 + nvab * (h11b - 1)))
      int_mb(k_a_offset+length+addr) = size
      size = size + int_mb(k_range+h11b-1) * int_mb(k_range+p17b-1) * in
     &t_mb(k_range+h16b-1) * int_mb(k_range+p9b-1)
      END IF
      END IF
      END IF
      END DO
      END DO
      END DO
      END DO
      RETURN
      END
