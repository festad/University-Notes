(define (domain CAMPI)
	(:requirements :strips :equality :conditional-effects);;magari tolgo equality...###
	(:predicates
		(CONTADINO ?c)
		(CAMPO ?c)
		(TRA ?t)
		(TRA-ARA ?t)
		(TRA-SEMINA ?t)
		(ARATRO ?a)
		(SEMINATORE ?s)
		
		(at ?o ?c)
		(innaffiato ?c)
		(seminato ?c)
		(arato ?c)
		(CONNESSO ?c1 ?c2)

		(equipaggiato-con-strumento ?t)
		(equipaggiato-con-aratro ?t ?a)
		(equipaggiato-con-seminatore ?t ?s)

	(:action cammina
		:parameters (?cont ?orig ?dest)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			;;(CAMPO ?orig)
			;;(CAMPO ?dest)

			;;connessione
			(CONNESSO ?orig ?dest)

			;;inizio
			(at ?cont ?orig))
		:effect (and
			(not (at ?cont ?orig))
			(at ?cont ?dest)))

	(:action guida
		:parameters (?cont ?tra ?orig ?dest)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA ?tra)
			;;(CAMPO ?orig)
			;;(CAMPO ?dest)

			;;connessione
			(CONNESSO ?orig ?dest)

			;;inizio
			(at ?cont ?orig)
			(at ?tra ?orig))
		:effect (and
			(not (at ?cont ?orig))
			(not (at ?tra ?orig))
			(at ?cont ?dest)
			(at ?tra ?dest)))

	(:action monta-aratro
		:parameters (?cont ?tra ?arat ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA-ARA ?tra)
			(ARATRO ?arat);; potrei cambiare da ARATRO a montato	###
			;;(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)
			(at ?arat ?lieu)

			;;inizio
			(not (equipaggiato-con-strumento ?tra))

		:effect (and
			(not (at ?arat ?lieu))
			(equipaggiato-con-strumento ?tra)
			(equipaggiato-con-aratro ?tra ?arat)))
			

	(:action smonta-aratro
		:parameters (?cont ?tra ?arat ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA ?tra)
			(ARATRO ?arat)
			;;(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)

			;;inizio
			(equipaggiato-con-aratro ?tra ?arat)
		:effect (and
			(at ?arat ?lieu)
			(not (equipaggiato-con-strumento ?tra))
			(not (equipaggiato-con-aratro ?tra ?arat))))

	(:action monta-seminatore
		:parameters (?cont ?tra ?sem ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA-SEMINA ?tra)
			(SEMINATORE ?sem)
			;;(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)
			(at ?sem ?lieu)

			;;inizio
			(not (equipaggiato-con-strumento ?tra))
			
		:effect (and
			(not (at ?sem ?lieu))
			(equipaggiato-con-strumento ?tra)
			(equipaggiato-con-seminatore ?tra ?sem)

	(:action smonta-seminatore
		:parameters (?cont ?tra ?sem ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA ?tra)
			(SEMINATORE ?sem)
			;;(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)

			;;inizio
			(equipaggiato-con-seminatore ?tra ?sem))
		:effect (and
			(at ?sem ?lieu)
			(not (equipaggiato-con-strumento ?tra))
			(not (equipaggiato-con-seminatore ?tra ?sem))))

	(:action ara
		:parameters (?cont ?tra ?lieu ?arat)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			;;(TRA-ARA ?tra)
			;;(CAMPO ?lieu)
			;;(ARATRO ?arat)

			(equipaggiato-con-aratro ?tra ?arat)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)

			;;inizio
			(not (arato ?lieu))
			(not (seminato ?lieu))
			(not (innaffiato ?lieu)));;non sicuro		###
		:effect (and
			(arato ?lieu)))

	(:action semina
		:parameters (?cont ?tra ?lieu ?sem)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			;;(TRA-SEMINA ?tra)
			;;(CAMPO ?lieu)
			;;(SEMINATORE ?sem)

			(equipaggiato-con-seminatore ?tra ?sem)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)

			;;inizio
			(arato ?lieu))
		:effect (and
			(not (arato ?lieu))
			(seminato ?lieu)))

	(:action innaffia
		:parameters (?cont ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			;;(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)

			;;inizio
			(seminato ?lieu))
		:effect (and
			(not(seminato ?lieu))
			(innaffiato ?lieu))))