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
		(connnesso ?c1 ?c2)
		(montato ?a))

	(:action cammina
		:parameters (?cont ?orig ?dest)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(CAMPO ?orig)
			(CAMPO ?dest)

			;;connessione
			(connesso ?orig ?dest)

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
			(CAMPO ?orig)
			(CAMPO ?dest)

			;;connessione
			(connesso ?orig ?dest)

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
			(TRA ?tra)
			(ARATRO ?arat);; potrei cambiare da ARATRO a montato	###
			(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)
			(at ?arat ?lieu)

			;;inizio
			(not (TRA-ARA ?tra))
			(not (TRA-SEMINA ?tra))
			(not (montato ?arat)));;non sicuro		###
		:effect (and
			(not (at ?arat ?lieu))
			(TRA-ARA ?tra)
			(montato ?arat)))

	(:action smonta-aratro
		:parameters (?cont ?tra ?arat ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA-ARA ?tra)
			(ARATRO ?arat)
			(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)

			;;inizio
			(montato ?arat))
		:effect (and
			(not (montato ?arat))
			(at ?arat ?lieu)
			(not (TRA-ARA ?tra))))

	(:action monta-seminatore
		:parameters (?cont ?tra ?sem ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA ?tra)
			(SEMINATORE ?sem)
			(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)
			(at ?sem ?lieu)

			;;inizio
			(not (TRA-ARA ?tra))
			(not (TRA-SEMINA ?tra))
			(not (montato ?sem)));;non sicuro		###
		:effect (and
			(not (at ?sem ?lieu))
			(TRA-SEMINA ?tra)
			(montato ?sem)))

	(:action smonta-seminatore
		:parameters (?cont ?tra ?sem ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA-SEMINA ?tra)
			(SEMINATORE ?sem)
			(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)

			;;inizio
			(montato ?sem))
		:effect (and
			(not (montato ?sem))
			(at ?sem ?lieu)
			(not (TRA-SEMINA ?tra))))

	(:action ara
		:parameters (?cont ?tra ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA-ARA ?tra)
			(CAMPO ?lieu)

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
		:parameters (?cont ?tra ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(TRA-SEMINA ?tra)
			(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)
			(at ?tra ?lieu)

			;;inizio
			(arato ?lieu)
		:effect (and
			(not (arato ?lieu))
			(seminato ?lieu)))

	(:action innaffia
		:parameters (?cont ?lieu)
		:precondition (and
			;;tipi
			(CONTADINO ?cont)
			(CAMPO ?lieu)

			;;luogo
			(at ?cont ?lieu)

			;;inizio
			(seminato ?lieu))
		:effect (and
			(not(seminato ?lieu))
			(innaffiato ?lieu)))