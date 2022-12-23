(define
  (domain CAMPI)

  (:requirements
    :strips :conditional-effects
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

    ;; (agganciato ?aratro)
    ;; (agganciato ?seminatore)
    (agganciato ?x)

    ;; Un trattore puo' essere equipaggiato
    ;; con un aratro o con un seminatore,
    ;; il predicato 'equipaggiato' non si
    ;; cura di distinguere quale dei due
    (equipaggiato ?tra ?x)

    ;; Quando un trattore e' equipaggiato
    ;; con un aratro o un seminatore
    ;; allora e' occupato e non puo;
    ;; essere nuovamente equipaggiato
    (occupato ?tra)


    ;; (at contadino campo)
    ;; (at trattore campo)
    ;; (at aratro campo)
    ;; (at seminatore campo)
    (at ?x ?y)

    (on ?contadino ?trattore)

    ;; IMPEGNATO:
    ;; quando (on contadino trattore)
    ;; e' true, indipendentemente dal trattore,
    ;; utile per non permettere a un contadino
    ;; su un trattore di innaffiare, efficiente
    ;; perche' non importa sapere se il contadino
    ;; si trovi su un particolare trattore ma solo
    ;; se sia o meno alla guida di un qualsiasi trattore
    (impegnato ?contadino)


  )

  (:action salire
    :parameters (?cont ?tra ?cam)
    :precondition (and
      (contadino ?cont) (TRA ?tra) (CAMPO ?cam)
      (at ?cont ?cam)
      (at ?tra ?cam)
      (not (impegnato ?cont))
    )
    :effect (and
      (on ?cont ?tra)
      (impegnato ?cont)
    )
  )

  (:action guidare
    :parameters (?cont ?tra ?cam_from ?cam_to)
    :precondition (and
      (contadino ?cont) (TRA ?tra) (CAMPO ?cam_from) (CAMPO ?cam_to)
      (CONNESSO ?cam_from ?cam_to)
      (at ?cont ?cam_from)
      (at ?tra ?cam_from)
      (on ?cont ?tra)
    )
    :effect (and
    
      ;; Tutti i contadini sul trattore
      ;; si spostano a destinazione
      (forall (?conts)
        (when
	  (and
	    (contadino ?conts)
	    (on ?conts ?tra)
	  )
	  (and
	    (at ?conts ?cam_to)
	    (not (at ?conts ?cam_from))
	  )
	)
      )

      ;; Se il trattore e' equipaggiato
      ;; con un aratro o un seminatore,
      ;; si sposta anche l'aratro o il seminatore
      (forall (?equip)
        (when
	  (and
	    ;; (or (ARATRO ?equip) (SEMINATORE ?equip))
	    (equipaggiato ?tra ?equip)
	  )
	  (and
	    (at ?equip ?cam_to)
	    (not (at ?equip ?cam_from))
	  )
	)
      )
      
      (at ?tra ?cam_to)
      (not (at ?tra ?cam_from))
    )
  )

  (:action arare
    :parameters (?cont ?tra ?aratro ?cam)
    :precondition (and
      (contadino ?cont) (TRA-ARA ?tra) (TRA ?tra) (ARATRO ?aratro) (CAMPO ?cam)
      ;; (impegnato ?cont)
      (on ?cont ?tra)
      ;; (occupato ?tra)
      (equipaggiato ?tra ?aratro)
      ;; (agganciato ?aratro)
      (at ?cont ?cam)
      (at ?tra ?cam)
      (not (arato ?cam))
      (not (seminato ?cam))
      (not (innaffiato ?cam))
    )
    :effect (and
      (arato ?cam)
    )
  )

  ;; Nella definizione del problema
  ;; e' possibile che un campo venga dichiarato
  ;; come seminato senza essere dichiarato arato?
  (:action seminare
    :parameters (?cont ?tra ?seminatore ?cam)
    :precondition (and
      (contadino ?cont) (TRA-SEMINA ?tra) (TRA ?tra) (SEMINATORE ?seminatore) (CAMPO ?cam)
      ;; (impegnato ?cont)
      (on ?cont ?tra)
      ;; (occupato ?tra)
      (equipaggiato ?tra ?seminatore)
      ;; (agganciato ?seminatore)
      (at ?cont ?cam)
      (at ?tra ?cam)
      (arato ?cam)
      (not (seminato ?cam))
      (not (innaffiato ?cam))
    )
    :effect (and
      (seminato ?cam)
    )
  )

  (:action scendere
    :parameters (?cont ?tra ?cam)
    :precondition (and
      (contadino ?cont) (TRA ?tra) (CAMPO ?cam)
      (at ?cont ?cam)
      (at ?tra ?cam)
      (on ?cont ?tra)
      ;; (impegnato ?cont)
    )
    :effect (and
      (not (on ?cont ?tra))
      (not (impegnato ?cont))
    )
  )

  (:action camminare
    :parameters (?cont ?cam_from ?cam_to)
    :precondition (and
      (contadino ?cont) (CAMPO ?cam_from) (CAMPO ?cam_to)
      (CONNESSO ?cam_from ?cam_to)
      (at ?cont ?cam_from)
      (not (impegnato ?cont))
    )
    :effect (and
      (at ?cont ?cam_to)
      (not (at ?cont ?cam_from))
    )
  )

  (:action innaffiare
    :parameters (?cont ?cam)
    :precondition (and
      (contadino ?cont) (CAMPO ?cam)
      (not (impegnato ?cont))
      (at ?cont ?cam)
      ;;(or
      ;;(and (not (arato ?cam)) (seminato ?cam) (not (innaffiato ?cam)))
      ;;(and (arato ?cam)       (seminato ?cam) (not (innaffiato ?cam)))
      ;;)
      (arato ?cam)
      (seminato ?cam)
      (not (innaffiato ?cam))
    )
    :effect (and
      (innaffiato ?cam)
    )
  )

  (:action agganciare_aratro
    :parameters (?cont ?tra ?aratro ?cam)
    :precondition (and
      (contadino ?cont) (TRA-ARA ?tra) (TRA ?tra) (ARATRO ?aratro) (CAMPO ?cam)
      (not (impegnato ?cont))
      (at ?cont ?cam)
      (at ?tra ?cam)
      (at ?aratro ?cam)
      (not (occupato ?tra))
      (not (agganciato ?aratro))
    )
    :effect (and
      (occupato ?tra)
      (equipaggiato ?tra ?aratro)
      (agganciato ?aratro)
    )
  )

  (:action sganciare_aratro
    :parameters (?cont ?tra ?aratro ?cam)
    :precondition (and
      (contadino ?cont) (TRA ?tra) (ARATRO ?aratro) (CAMPO ?cam)
      (not (impegnato ?cont))
      (at ?cont ?cam)
      (at ?tra ?cam)
      (occupato ?tra)
      (equipaggiato ?tra ?aratro)
      ;;(agganciato ?aratro) ;; <- might be removed
    )
    :effect (and
      (not (occupato ?tra))
      (not (equipaggiato ?tra ?aratro))
      (not (agganciato ?aratro))
    )
  )

  (:action agganciare_seminatore
    :parameters (?cont ?tra ?seminatore ?cam)
    :precondition (and
      (contadino ?cont) (TRA-SEMINA ?tra) (TRA ?tra) (SEMINATORE ?seminatore) (CAMPO ?cam)
      (not (impegnato ?cont))
      (at ?cont ?cam)
      (at ?tra ?cam)
      (at ?seminatore ?cam)
      (not (occupato ?tra))
      (not (agganciato ?seminatore))
    )
    :effect (and
      (occupato ?tra)
      (equipaggiato ?tra ?seminatore)
      (agganciato ?seminatore)
    )
  )

  (:action sganciare_seminatore
    :parameters (?cont ?tra ?seminatore ?cam)
    :precondition (and
      (contadino ?cont) (TRA ?tra) (SEMINATORE ?seminatore) (CAMPO ?cam)
      (not (impegnato ?cont))
      (at ?cont ?cam)
      (at ?tra ?cam)
      (occupato ?tra)
      (equipaggiato ?tra ?seminatore)
      (agganciato ?seminatore) ;; <- might be removed
    )
    :effect (and
      (not (occupato ?tra))
      (not (equipaggiato ?tra ?seminatore))
      (not (agganciato ?seminatore))
    )
  )

  ;;(:action diramazione
  ;;)

  ;;(:action triangolazione
  ;;)



)