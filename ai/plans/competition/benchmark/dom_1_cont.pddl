(define
  (domain CAMPI)

  (:requirements
    :strips :conditional-effects :equality
  )

  (:predicates
  
    (contadino  ?cont)
    
    (CAMPO      ?cam)
    
    (arato      ?cam)
    (seminato   ?cam)
    (innaffiato ?cam)
    (CONNESSO   ?cam1 ?cam2)

    (TRA        ?tra)

    (ARATRO     ?aratro)
    (TRA-ARA    ?tra)

    (SEMINATORE ?seminatore)
    (TRA-SEMINA ?tra)

    ;;strumento non più a terra
    (agganciato ?x)

    ;;trattore equipaggiato con un attrezzo x
    (equipaggiato ?tra ?x)

    ;;trattore ha agganciato qualcosa
    (occupato ?tra)
    ;;trattore ha agganciato un aratro
    (equip_arat ?tra)
    ;;trattore ha agganciato un seminatore
    (equip_sem ?tra)

    ;;il trattore è governato da un contadino
    (guidato ?tra)

    ;;qualunque cosa (x) si trova in un campo y
    (at ?x ?y)

    ;;un contadino è su un trattore
    (on ?contadino ?trattore)


  )

  (:action salire
    :parameters (?cont ?tra ?cam)
    :precondition (and
      ;;tipi
      (contadino ?cont) (TRA ?tra) (CAMPO ?cam)

      ;;luogo
      (at ?cont ?cam)
      (at ?tra ?cam)

      ;;inizio
      (not (guidato ?tra))
    )
    :effect (and
      (on ?cont ?tra)
      (guidato ?tra)
      (not (at ?cont ?cam))
    )
  )

  (:action guidare
    :parameters (?tra ?cam_from ?cam_to)
    :precondition (and
      ;;tipi
      (TRA ?tra) (CAMPO ?cam_from) (CAMPO ?cam_to)

      ;;luogo - inizio
      (at ?tra ?cam_from)

      ;;condizioni
      (CONNESSO ?cam_from ?cam_to)
      (guidato ?tra)
    )
    :effect (and
      (at ?tra ?cam_to)
      (not (at ?tra ?cam_from))
    )
  )

  (:action arare
    :parameters (?tra ?cam)
    :precondition (and
      ;;tipi
      (TRA-ARA ?tra) (CAMPO ?cam)

      ;;condizioni
      (equip_arat ?tra)
      (guidato ?tra)
      (not (arato ?cam))
      (not (seminato ?cam))
      (not (innaffiato ?cam))

      ;;luogo
      (at ?tra ?cam)
    )
    :effect (and
      (arato ?cam)
    )
  )

  (:action seminare
    :parameters (?tra ?cam)
    :precondition (and
      ;;tipi
      (TRA-SEMINA ?tra) (CAMPO ?cam)

      ;;condizioni
      (equip_sem ?tra)
      (guidato ?tra)
      (arato ?cam)

      ;;luogo
      (at ?tra ?cam)
    )
    :effect (and
      (not (arato ?cam))
      (seminato ?cam)
    )
  )

  (:action scendere
    :parameters (?cont ?tra ?cam)
    :precondition (and
      ;;tipi
      (contadino ?cont) (TRA ?tra) (CAMPO ?cam)

      ;;condizioni
      (on ?cont ?tra)

      ;;luogo
      (at ?tra ?cam)
    )
    :effect (and
      (not (on ?cont ?tra))
      (not (guidato ?tra))

      ;;luogo
      (at ?cont ?cam)
    )
  )

  (:action camminare
    :parameters (?cont ?cam_from ?cam_to)
    :precondition (and
      ;;tipi
      (contadino ?cont) (CAMPO ?cam_from) (CAMPO ?cam_to)

      ;;condizioni
      (not (= ?cam_from ?cam_to))
      (CONNESSO ?cam_from ?cam_to)

      ;;luogo
      (at ?cont ?cam_from)
    )
    :effect (and
      (at ?cont ?cam_to)
      (not (at ?cont ?cam_from))
    )
  )

  (:action innaffiare
    :parameters (?cont ?cam)
    :precondition (and
      ;;tipi
      (contadino ?cont) (CAMPO ?cam)

      ;;condizioni
      (seminato ?cam)

      ;;luogo
      (at ?cont ?cam)
    )
    :effect (and
      (innaffiato ?cam)
      (not (seminato ?cam))
    )
  )

  (:action agganciare_aratro
    :parameters (?cont ?tra ?aratro ?cam)
    :precondition (and
      ;;tipi
      (contadino ?cont) (TRA-ARA ?tra) (ARATRO ?aratro) (CAMPO ?cam)

      ;;condizioni
      (not (occupato ?tra))
      (not (agganciato ?aratro))

      ;;luogo
      (at ?cont ?cam)
      (at ?tra ?cam)
      (at ?aratro ?cam)
    )
    :effect (and
      (occupato ?tra)
      (equip_arat ?tra)
      (equipaggiato ?tra ?aratro)
      (agganciato ?aratro)

      ;;luogo
      (not (at ?aratro ?cam))
    )
  )

  (:action sganciare_aratro
    :parameters (?cont ?tra ?aratro ?cam)
    :precondition (and
      ;;tipi
      (contadino ?cont) (TRA-ARA ?tra) (ARATRO ?aratro) (CAMPO ?cam)

      ;;condizioni
      (equipaggiato ?tra ?aratro)

      ;;luogo
      (at ?cont ?cam)
      (at ?tra ?cam)
    )
    :effect (and
      (not (occupato ?tra))
      (not (equip_arat ?tra))
      (not (agganciato ?aratro))
      (not (equipaggiato ?tra ?aratro))

      ;;luogo
      (at ?aratro ?cam)
    )
  )


  (:action agganciare_seminatore
    :parameters (?cont ?tra ?seminatore ?cam)
    :precondition (and
      ;;tipi
      (contadino ?cont) (TRA-SEMINA ?tra) (SEMINATORE ?seminatore) (CAMPO ?cam)

      ;;condizioni
      (not (occupato ?tra))
      (not (agganciato ?seminatore))

      ;;luogo
      (at ?cont ?cam)
      (at ?tra ?cam)
      (at ?seminatore ?cam)
    )
    :effect (and
      (occupato ?tra)
      (equip_sem ?tra)
      (equipaggiato ?tra ?seminatore)
      (agganciato ?seminatore)

      ;;luogo
      (not (at ?seminatore ?cam))
    )
  )

  (:action sganciare_seminatore
    :parameters (?cont ?tra ?seminatore ?cam)
    :precondition (and
      ;;tipi
      (contadino ?cont) (TRA-SEMINA ?tra) (SEMINATORE ?seminatore) (CAMPO ?cam)

      ;;condizioni
      (equipaggiato ?tra ?seminatore)

      ;;luogo
      (at ?cont ?cam)
      (at ?tra ?cam)
    )
    :effect (and
      (not (occupato ?tra))
      (not (equip_sem ?tra))
      (not (agganciato ?seminatore))
      (not (equipaggiato ?tra ?seminatore))

      ;;luogo
      (at ?seminatore ?cam)
    )
  )
)
