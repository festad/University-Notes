(define (problem Grid25)
  (:domain CAMPI)
  (:objects traA1 traA2 traS1 traS2 aratro1 aratro2 seminatore1 seminatore2
     contadino1 contadino2


cam0
cam1
cam2
cam3
cam4
cam5
cam6
cam7
cam8
cam9
cam10
cam11
cam12
cam13
cam14
cam15
cam16
cam17
cam18
cam19
cam20
cam21
cam22
cam23
cam24
cam25
cam26
cam27
cam28
cam29
cam30
cam31
cam32
cam33
cam34
cam35


     )
  (:init
(contadino contadino1)
(contadino contadino2)

(CAMPO cam0)
(CAMPO cam1)
(CAMPO cam2)
(CAMPO cam3)
(CAMPO cam4)
(CAMPO cam5)
(CAMPO cam6)
(CAMPO cam7)
(CAMPO cam8)
(CAMPO cam9)
(CAMPO cam10)
(CAMPO cam11)
(CAMPO cam12)
(CAMPO cam13)
(CAMPO cam14)
(CAMPO cam15)
(CAMPO cam16)
(CAMPO cam17)
(CAMPO cam18)
(CAMPO cam19)
(CAMPO cam20)
(CAMPO cam21)
(CAMPO cam22)
(CAMPO cam23)
(CAMPO cam24)
(CAMPO cam25)
(CAMPO cam26)
(CAMPO cam27)
(CAMPO cam28)
(CAMPO cam29)
(CAMPO cam30)
(CAMPO cam31)
(CAMPO cam32)
(CAMPO cam33)
(CAMPO cam34)
(CAMPO cam35)

(CONNESSO cam0 cam1)
(CONNESSO cam1 cam0)
(CONNESSO cam0 cam6)
(CONNESSO cam6 cam0)
(CONNESSO cam1 cam2)
(CONNESSO cam2 cam1)
(CONNESSO cam1 cam7)
(CONNESSO cam7 cam1)
(CONNESSO cam2 cam3)
(CONNESSO cam3 cam2)
(CONNESSO cam2 cam8)
(CONNESSO cam8 cam2)
(CONNESSO cam3 cam4)
(CONNESSO cam4 cam3)
(CONNESSO cam3 cam9)
(CONNESSO cam9 cam3)
(CONNESSO cam4 cam5)
(CONNESSO cam5 cam4)
(CONNESSO cam4 cam10)
(CONNESSO cam10 cam4)
(CONNESSO cam6 cam7)
(CONNESSO cam7 cam6)
(CONNESSO cam6 cam12)
(CONNESSO cam12 cam6)
(CONNESSO cam7 cam8)
(CONNESSO cam8 cam7)
(CONNESSO cam7 cam13)
(CONNESSO cam13 cam7)
(CONNESSO cam8 cam9)
(CONNESSO cam9 cam8)
(CONNESSO cam8 cam14)
(CONNESSO cam14 cam8)
(CONNESSO cam9 cam10)
(CONNESSO cam10 cam9)
(CONNESSO cam9 cam15)
(CONNESSO cam15 cam9)
(CONNESSO cam10 cam11)
(CONNESSO cam11 cam10)
(CONNESSO cam10 cam16)
(CONNESSO cam16 cam10)
(CONNESSO cam12 cam13)
(CONNESSO cam13 cam12)
(CONNESSO cam12 cam18)
(CONNESSO cam18 cam12)
(CONNESSO cam13 cam14)
(CONNESSO cam14 cam13)
(CONNESSO cam13 cam19)
(CONNESSO cam19 cam13)
(CONNESSO cam14 cam15)
(CONNESSO cam15 cam14)
(CONNESSO cam14 cam20)
(CONNESSO cam20 cam14)
(CONNESSO cam15 cam16)
(CONNESSO cam16 cam15)
(CONNESSO cam15 cam21)
(CONNESSO cam21 cam15)
(CONNESSO cam16 cam17)
(CONNESSO cam17 cam16)
(CONNESSO cam16 cam22)
(CONNESSO cam22 cam16)
(CONNESSO cam18 cam19)
(CONNESSO cam19 cam18)
(CONNESSO cam18 cam24)
(CONNESSO cam24 cam18)
(CONNESSO cam19 cam20)
(CONNESSO cam20 cam19)
(CONNESSO cam19 cam25)
(CONNESSO cam25 cam19)
(CONNESSO cam20 cam21)
(CONNESSO cam21 cam20)
(CONNESSO cam20 cam26)
(CONNESSO cam26 cam20)
(CONNESSO cam21 cam22)
(CONNESSO cam22 cam21)
(CONNESSO cam21 cam27)
(CONNESSO cam27 cam21)
(CONNESSO cam22 cam23)
(CONNESSO cam23 cam22)
(CONNESSO cam22 cam28)
(CONNESSO cam28 cam22)
(CONNESSO cam24 cam25)
(CONNESSO cam25 cam24)
(CONNESSO cam24 cam30)
(CONNESSO cam30 cam24)
(CONNESSO cam25 cam26)
(CONNESSO cam26 cam25)
(CONNESSO cam25 cam31)
(CONNESSO cam31 cam25)
(CONNESSO cam26 cam27)
(CONNESSO cam27 cam26)
(CONNESSO cam26 cam32)
(CONNESSO cam32 cam26)
(CONNESSO cam27 cam28)
(CONNESSO cam28 cam27)
(CONNESSO cam27 cam33)
(CONNESSO cam33 cam27)
(CONNESSO cam28 cam29)
(CONNESSO cam29 cam28)
(CONNESSO cam28 cam34)
(CONNESSO cam34 cam28)
(CONNESSO cam5 cam11)
(CONNESSO cam11 cam5)
(CONNESSO cam11 cam17)
(CONNESSO cam17 cam11)
(CONNESSO cam17 cam23)
(CONNESSO cam23 cam17)
(CONNESSO cam23 cam29)
(CONNESSO cam29 cam23)
(CONNESSO cam29 cam35)
(CONNESSO cam35 cam29)
(CONNESSO cam30 cam31)
(CONNESSO cam31 cam30)
(CONNESSO cam31 cam32)
(CONNESSO cam32 cam31)
(CONNESSO cam32 cam33)
(CONNESSO cam33 cam32)
(CONNESSO cam33 cam34)
(CONNESSO cam34 cam33)
(CONNESSO cam34 cam35)
(CONNESSO cam35 cam34)


   (TRA traA1)
   (TRA traA2)
   (TRA traS1)
   (TRA traS2)
   (TRA-ARA traA1)
   (TRA-ARA traA2)
   (TRA-SEMINA traS1)
   (TRA-SEMINA traS2)
   (ARATRO aratro1)
   (ARATRO aratro2)
   (SEMINATORE seminatore1)
   (SEMINATORE seminatore2)



   (at traA1 cam17)
   (at traA2 cam23)
   (at traS1 cam7)
   (at traS2 cam19)
   (at aratro1 cam3)
   (at aratro2 cam15)
   (at seminatore1 cam21)
   (at seminatore2 cam13)
   (at contadino1 cam1)
   (at contadino2 cam24)
   )
   
  (:goal (and

(arato cam0)
(seminato cam4)
(seminato cam5)
(innaffiato cam6)
(innaffiato cam19)
(innaffiato cam35)


   )
   )
  )