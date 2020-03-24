PROGRAM JULIA
  IMPLICIT NONE
  !##########################################################
  !# Illustriation of Julia set using escape time algorithm
  !#   F(Z)=Z^2 + 0.7885EXP(i*alpha)
  !# where alpha in (0,2Pi]
  !#
  !# We will use smooth coloring to remove the aliasing effect
  !#
  !##########################################################
  REAL(8) :: x, y, iter
  COMPLEX*16 :: z, con
  REAL(8) :: dx, dy, xmin, ymin, xmax, ymax, angle, dangle, mag, nu, logzn
  INTEGER :: nX, nY, i, j, k, nK, niter
  COMPLEX*16, PARAMETER :: coni=(0.d0,1.d0)
  REAL(8), PARAMETER :: pi=3.14159265359d0

  ! Define grid
  nX = 200
  nY = 200
  nK = 100
  niter = 256
  xmin=-2.0d0
  ymin=-1.0d0
  xmax=1.5d0
  ymax=1.d0
  dx = (xmax-xmin)/DBLE(nX-1)
  dy = (ymax-ymin)/DBLE(nY-1)
  dangle = 2.d0*pi/DBLE(nK-1)


  OPEN(UNIT=100, FILE='output.dat', STATUS='REPLACE')
  DO k=1,nK
    con = 0.7885*EXP(coni*(DBLE(k-1)*dangle))
    DO i=1,nX
      x=xmin+DBLE(i-1)*dx
      DO j=1,nY
        y=ymin+DBLE(j-1)*dy
        z = x+coni*y
        mag = DBLE(z)**2 + DIMAG(z)**2
        iter=1
        ! Escape time loop
        DO WHILE (mag.LT.4.d0)
          z = z**2 + con
          mag = DBLE(z)**2 + DIMAG(z)**2
          iter = iter + 1
          IF (iter.GT.niter) THEN
            iter=256
            EXIT
          ENDIF
        ENDDO

        ! Pixel smoothing
        IF (iter.LT.niter) THEN
          logzn=LOG(DBLE(z)**2 + DIMAG(z)**2)/LOG(2.d0)
          nu=LOG(logzn/LOG(2.d0))/LOG(2.d0)
          iter=iter+1-nu
        ENDIF
        WRITE(100,*) x, y, iter
      ENDDO
    ENDDO
  WRITE(100,*)
  ENDDO

  CLOSE(100)
END
