      parameter (l=256)
      integer matriz(1:l,1:l),vectori (1:l*l),vectorj (1:l*l),aux
      integer enx, eny, pbc(0:l+1),nx(1:4),ny(1:4),vx,vy, contador
      real*8 x,p,f
      logical percola
      DOUBLE PRECISION, EXTERNAL :: dran_u
      
      call dran_ini(45)

      do while (.true.)
         open(10, file='output.txt', status='replace')
         nx(1)=1
         ny(1)=0
         nx(2)=-1
         ny(2)=0
         nx(3)=0
         ny(3)=1
         nx(4)=0
         ny(4)=-1

         p=0.6
         percola=.false.

         do i=1,l
            pbc(i)=i
         end do
         pbc(0)=l
         pbc(l+1)=1



         do i=1,l
            do j=1,l
               matriz(i,j)=2
               write(10,*) i,',', j,',', (2.0)/3
            enddo
         enddo

         n=0
            
            
         matriz(l/2,l/2)=1

         enx=l/2
         eny=l/2
         write(10,*) enx,',', eny,',',(1.0)/3
            

         do i=1,4
               
            n=n+1
            matriz (enx+nx(i),eny+ny(i))=0
            vectori(n)=enx+nx(i)
            vectorj(n)=eny+ny(i)
            write(10,*) enx+nx(i),',',eny+ny(i),',',0

         end do

         do while (n.gt.0)

            aux=i_dran(n)
            x=dran_u()
            
            if (x.lt.p) then
               matriz(vectori(aux),vectorj(aux))=1
               enx=vectori(aux)
               eny=vectorj(aux)
               write(10,*) enx,',',eny,',',1
               do i=1,4
                  vx=pbc(enx+nx(i))
                  vy=pbc(eny+ny(i))
                  if (matriz(vx,vy).eq.2) then
                     n=n+1
                     matriz(vx,vy)=0
                     vectori(n)=vx
                     vectorj(n)=vy

                     if ((vectori(n).eq.1).or.(vectori(n).eq.l)) then
                        percola=.true.
                     end if
                     if ((vectorj(n).eq.1).or.(vectorj(n).eq.l)) then
                        percola=.true.
                     end if
                     write(10,*) vx,',',vy,',',0
                  end if

               end do
            else
               matriz(vectori(aux),vectorj(aux))=3
               write(10,*) vectori(aux),',',vectorj(aux),',',(1.0)/3
            end if

            vectori(aux)=vectori(n)
            vectorj(aux)=vectorj(n)
            n=n-1

         end do
         write(*,*) 'Ready for next'
         close (10)
         read (*,*)
      end do


      
      end



     
