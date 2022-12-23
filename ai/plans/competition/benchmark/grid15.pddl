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

(CONNESSO cam0 cam1)
(CONNESSO cam1 cam0)
(CONNESSO cam0 cam5)
(CONNESSO cam5 cam0)
(CONNESSO cam1 cam2)
(CONNESSO cam2 cam1)
(CONNESSO cam1 cam6)
(CONNESSO cam6 cam1)
(CONNESSO cam2 cam3)
(CONNESSO cam3 cam2)
(CONNESSO cam2 cam7)
(CONNESSO cam7 cam2)
(CONNESSO cam3 cam4)
(CONNESSO cam4 cam3)
(CONNESSO cam3 cam8)
(CONNESSO cam8 cam3)
(CONNESSO cam5 cam6)
(CONNESSO cam6 cam5)
(CONNESSO cam5 cam10)
(CONNESSO cam10 cam5)
(CONNESSO cam6 cam7)
(CONNESSO cam7 cam6)
(CONNESSO cam6 cam11)
(CONNESSO cam11 cam6)
(CONNESSO cam7 cam8)
(CONNESSO cam8 cam7)
(CONNESSO cam7 cam12)
(CONNESSO cam12 cam7)
(CONNESSO cam8 cam9)
(CONNESSO cam9 cam8)
(CONNESSO cam8 cam13)
(CONNESSO cam13 cam8)

(CONNESSO cam4 cam9)
(CONNESSO cam9 cam4)
(CONNESSO cam9 cam14)
(CONNESSO cam14 cam9)

(CONNESSO cam10 cam11)
(CONNESSO cam11 cam10)
(CONNESSO cam11 cam12)
(CONNESSO cam12 cam11)
(CONNESSO cam12 cam13)
(CONNESSO cam13 cam12)
(CONNESSO cam13 cam14)
(CONNESSO cam14 cam13)




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

(seminato cam0)
(seminato cam1)
(seminato cam2)
(seminato cam3)
(seminato cam4)
(seminato cam3)
(seminato cam4)
(seminato cam5)
(innaffiato cam6)
(innaffiato cam7)
(innaffiato cam6)
(innaffiato cam7)
(innaffiato cam8)
(innaffiato cam9)
(innaffiato cam10)

)
)
)