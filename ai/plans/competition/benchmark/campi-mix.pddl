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

  ;; Nella definizione del problema
  ;; e' possibile che un campo venga dichiarato
  ;; come seminato senza essere dichiarato arato?
  (:action innaffiare
    :parameters (?cont ?cam)
    :precondition (and
      (contadino ?cont) (CAMPO ?cam)
      (not (impegnato ?cont))
      (at ?cont ?cam)
      (arato ?cam)
      (seminato ?cam)
      (not (innaffiato ?cam))
    )
    :effect (and
      ;; solo per correggere l'eventuale
      ;; errore nel testo per cui il campo
      ;; e' dichiarato come seminato senza
      ;; essere stato dichiarato come arato
      ;; (arato ?cam)
      
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


  (:action arare-vicinato
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
      (forall (?camps)
        (when
	  (and
	    (CONNESSO ?cam ?camps)
	    (not (arato ?camps))
	    (not (seminato ?camps))
	    (not (innaffiato ?camps))
	  )
	  (and
	    (arato ?camps)
	  )
	)
      )
    )
  )

  (:action seminare-vicinato
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
      (forall (?camps)
        (when
	  (and
	    (CONNESSO ?cam ?camps)
	    (arato ?camps)
	    (not (seminato ?camps))
	    (not (innaffiato ?camps))
	  )
	  (and
	    (seminato ?camps)
	  )
	)
      )
    )
  )

  (:action innaffiare-vicinato
    :parameters (?cont ?cam)
    :precondition (and
      (contadino ?cont) (CAMPO ?cam)
      (not (impegnato ?cont))
      (at ?cont ?cam)
      (seminato ?cam)
      (not (innaffiato ?cam))
    )
    :effect (and
      ;; solo per correggere l'eventuale
      ;; errore nel testo per cui il campo
      ;; e' dichiarato come seminato senza
      ;; essere stato dichiarato come arato
      (arato ?cam)
      
      (innaffiato ?cam)

      (forall (?camps)
        (when
	  (and
	    (CONNESSO ?cam ?camps)
	    (arato ?camps)
	    (seminato ?camps)
	    (not (innaffiato ?camps))
	  )
	  (and
	    (innaffiato ?camps)
	  )
	)
      )
    )
  )


  (:action guidare-due
    :parameters (?cont ?tra ?cam_from ?cam_mid ?cam_to)
    :precondition (and
      (contadino ?cont) (TRA ?tra) (CAMPO ?cam_from) (CAMPO ?cam_mid) (CAMPO ?cam_to)
      (not (= ?cam_from ?cam_mid))
      (not (= ?cam_mid ?cam_to))
      (not (= ?cam_from ?cam_to))
      (CONNESSO ?cam_from ?cam_mid)
      (CONNESSO ?cam_mid ?cam_to)
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

  (:action camminare-due
    :parameters (?cont ?cam_from ?cam_mid ?cam_to)
    :precondition (and
      (contadino ?cont) (CAMPO ?cam_from) (CAMPO ?cam_mid) (CAMPO ?cam_to)
      (not (= ?cam_from ?cam_mid))
      (not (= ?cam_mid ?cam_to))
      (not (= ?cam_from ?cam_to))
      (CONNESSO ?cam_from ?cam_mid)
      (CONNESSO ?cam_mid ?cam_to)
      (at ?cont ?cam_from)
      (not (impegnato ?cont))
    )
    :effect (and
      (at ?cont ?cam_to)
      (not (at ?cont ?cam_from))
    )
  )

  (:action arare-due
    :parameters (?cont ?tra ?aratro ?cam1 ?cam2)
    :precondition (and
      (contadino ?cont) (TRA-ARA ?tra) (TRA ?tra) (ARATRO ?aratro) (CAMPO ?cam1) (CAMPO ?cam2)
      ;;(impegnato ?cont)
      (on ?cont ?tra)
      ;;(occupato ?tra)
      (equipaggiato ?tra ?aratro)
      ;;(agganciato ?aratro)
      (not (= ?cam1 ?cam2))
      (CONNESSO ?cam1 ?cam2)
      (at ?cont ?cam1)
      (at ?tra ?cam1)
      (not (arato ?cam1))
      (not (seminato ?cam1))
      (not (innaffiato ?cam1))
      (not (arato ?cam2))
      (not (seminato ?cam2))
      (not (innaffiato ?cam2))
    )
    :effect (and
      (arato ?cam1)
      (arato ?cam2)
    )
  )

  (:action seminare-due
    :parameters (?cont ?tra ?seminatore ?cam1 ?cam2)
    :precondition (and
      (contadino ?cont) (TRA-SEMINA ?tra) (TRA ?tra) (SEMINATORE ?seminatore) (CAMPO ?cam1) (CAMPO ?cam2)
      ;;(impegnato ?cont)
      (on ?cont ?tra)
      ;;(occupato ?tra)
      (equipaggiato ?tra ?seminatore)
      ;;(agganciato ?seminatore)
      (not (= ?cam1 ?cam2))
      (CONNESSO ?cam1 ?cam2)
      (at ?cont ?cam1)
      (at ?tra ?cam1)
      (arato ?cam1)
      (not (seminato ?cam1))
      (not (innaffiato ?cam1))
      (arato ?cam2)
      (not (seminato ?cam2))
      (not (innaffiato ?cam2))
    )
    :effect (and
      (seminato ?cam1)
      (seminato ?cam2)
    )
  )

(:action innaffiare-due
    :parameters (?cont ?cam1 ?cam2)
    :precondition (and
      (contadino ?cont) (CAMPO ?cam1) (CAMPO ?cam2)
      (not (impegnato ?cont))
      (not (= ?cam1 ?cam2))
      (CONNESSO ?cam1 ?cam2)
      (at ?cont ?cam1)
      (arato ?cam1)
      (arato ?cam2)
      (seminato ?cam1)
      (seminato ?cam2)
      (not (innaffiato ?cam1))
      (not (innaffiato ?cam2))
    )
    :effect (and
      (arato ?cam1)
      (arato ?cam2)
      
      (innaffiato ?cam1)
      (innaffiato ?cam2)
    )
  )


)