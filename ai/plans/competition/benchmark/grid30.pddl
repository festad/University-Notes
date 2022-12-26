(define (problem Grid25)

(:domain CAMPI)
(:objects

traA1
traA2
traS1
traS2
aratro1
aratro2
seminatore1
seminatore2
contadino1
contadino2
contadino3
contadino4

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

(CONNESSO cam0 cam1)
(CONNESSO cam1 cam0)
(CONNESSO cam1 cam2)
(CONNESSO cam2 cam1)
(CONNESSO cam2 cam3)
(CONNESSO cam3 cam2)
(CONNESSO cam3 cam4)
(CONNESSO cam4 cam3)
(CONNESSO cam4 cam5)
(CONNESSO cam5 cam4)
(CONNESSO cam5 cam6)
(CONNESSO cam6 cam5)
(CONNESSO cam6 cam7)
(CONNESSO cam7 cam6)
(CONNESSO cam7 cam8)
(CONNESSO cam8 cam7)
(CONNESSO cam8 cam9)
(CONNESSO cam9 cam8)
(CONNESSO cam9 cam10)
(CONNESSO cam10 cam9)
(CONNESSO cam10 cam11)
(CONNESSO cam11 cam10)
(CONNESSO cam11 cam12)
(CONNESSO cam12 cam11)
(CONNESSO cam12 cam13)
(CONNESSO cam13 cam12)
(CONNESSO cam13 cam14)
(CONNESSO cam14 cam13)
(CONNESSO cam14 cam15)
(CONNESSO cam15 cam14)
(CONNESSO cam15 cam16)
(CONNESSO cam16 cam15)
(CONNESSO cam16 cam17)
(CONNESSO cam17 cam16)
(CONNESSO cam17 cam18)
(CONNESSO cam18 cam17)
(CONNESSO cam18 cam19)
(CONNESSO cam19 cam18)
(CONNESSO cam19 cam20)
(CONNESSO cam20 cam19)
(CONNESSO cam20 cam21)
(CONNESSO cam21 cam20)
(CONNESSO cam21 cam22)
(CONNESSO cam22 cam21)
(CONNESSO cam22 cam23)
(CONNESSO cam23 cam22)
(CONNESSO cam23 cam24)
(CONNESSO cam24 cam23)
(CONNESSO cam24 cam25)
(CONNESSO cam25 cam24)
(CONNESSO cam25 cam26)
(CONNESSO cam26 cam25)
(CONNESSO cam26 cam27)
(CONNESSO cam27 cam26)
(CONNESSO cam27 cam28)
(CONNESSO cam28 cam27)
(CONNESSO cam28 cam29)
(CONNESSO cam29 cam28)

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



(at traA1 cam1)
(at traA2 cam6)
(at traS1 cam14)
(at traS2 cam11)
(at aratro1 cam3)
(at aratro2 cam7)
(at seminatore1 cam2)
(at seminatore2 cam9)
(at contadino1 cam1)
(at contadino2 cam4)
(at contadino3 cam8)
(at contadino4 cam12)

)
   
(:goal (and

(arato cam0)
(arato cam1)
(arato cam2)
(arato cam3)
(arato cam4)
(arato cam5)
(arato cam6)
(arato cam7)
(arato cam8)
(arato cam9)
(seminato cam10)
(seminato cam11)
(seminato cam12)
(seminato cam13)
(seminato cam14)
(seminato cam15)
(seminato cam16)
(seminato cam17)
(seminato cam18)
(seminato cam19)
(seminato cam20)
(innaffiato cam21)
(innaffiato cam22)
(innaffiato cam23)
(innaffiato cam24)
(innaffiato cam25)
(innaffiato cam26)
(innaffiato cam27)
(innaffiato cam28)
(innaffiato cam29)

)
)
)