(define (problem Dieci-Campi)
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

   (at traA1 cam2);; dynamic predicates
   (at traA2 cam2)
   (at traS1 cam2)
   (at traS2 cam2)
   (at aratro1 cam4)
   (at aratro2 cam4)
   (at seminatore1 cam6)
   (at seminatore2 cam6)
   (at contadino1 cam0)
   (at contadino2 cam0)
   )
   
  (:goal (and
   (innaffiato cam9)
   (not (arato cam8))
   (not (seminato cam8))
   (not (innaffiato cam8)))))