      subroutine tce_jacobi_x1(d_r1,k_r1_offset)
c
c $Id: tce_jacobi_x1.F 19706 2010-10-29 17:52:31Z d3y133 $
c
      implicit none
#include "global.fh"
#include "mafdecls.fh"
#include "sym.fh"
#include "util.fh"
#include "stdio.fh"
#include "errquit.fh"
#include "tce.fh"
#include "tce_main.fh"
#include "tce_diis.fh"
      integer d_r1
      integer p1b
      integer h2b
      integer p1
      integer h2
      integer k_r1_offset
      integer size
      integer l_r1,k_r1
      integer i
      integer nprocs
      integer count
      integer next
cc      integer nxtval
cc      external nxtval
      INTEGER NXTASK
      EXTERNAL NXTASK
      logical nodezero
      logical noloadbalance
c
      nodezero = (ga_nodeid().eq.0)
      noloadbalance = ((ioalg.eq.4).or. 
     1                ((ioalg.eq.6).and.(.not.fileisga(d_r1))))
      nprocs = ga_nnodes()
      count = 0
cc      next = nxtval(nprocs)
      next = NXTASK(nprocs, 1)
      do p1b = noab+1,noab+nvab
        do h2b = 1,noab
          if (noloadbalance.or.(next.eq.count)) then
            if (int_mb(k_spin+p1b-1) .eq. int_mb(k_spin+h2b-1)) then 
            if ((.not.restricted).or.(int_mb(k_spin+p1b-1)
     1        +int_mb(k_spin+h2b-1).ne.4)) then
            if (ieor(int_mb(k_sym+p1b-1),int_mb(k_sym+h2b-1))
     1        .eq.irrep_x) then
              size = int_mb(k_range+p1b-1) * int_mb(k_range+h2b-1)
              if (.not.ma_push_get(mt_dbl,size,'r1',l_r1,k_r1))
     1          call errquit('tce_jacobi_x1: MA problem',0,MA_ERR)
              call get_hash_block(d_r1,dbl_mb(k_r1),size,
     1          int_mb(k_r1_offset),((p1b-noab-1)*noab+h2b-1))
              i = 0
              do p1 = 1,int_mb(k_range+p1b-1)
                do h2 = 1,int_mb(k_range+h2b-1)
                  i = i + 1
                  dbl_mb(k_r1+i-1) = dbl_mb(k_r1+i-1)
     1           / (-dbl_mb(k_evl_sorted+int_mb(k_offset+p1b-1)+p1-1)
     2              +dbl_mb(k_evl_sorted+int_mb(k_offset+h2b-1)+h2-1))
                enddo
              enddo
              call put_hash_block(d_r1,dbl_mb(k_r1),size,
     1          int_mb(k_r1_offset),((p1b-noab-1)*noab+h2b-1))
              if (.not.ma_pop_stack(l_r1))
     1          call errquit('tce_jacobi_x1: MA problem',1,MA_ERR)
            endif
            endif
            endif
cc            next = nxtval(nprocs)
      next = NXTASK(nprocs, 1)
          endif
          count = count + 1
        enddo
      enddo
cc      next = nxtval(-nprocs)
      next = NXTASK(-nprocs, 1)
      call ga_sync()
      return
      end
