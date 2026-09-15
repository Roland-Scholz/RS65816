(define memories
'(
    (memory DirectPage (address (#x0 . #xff))
        (section registers))

    (memory STACK (address (#x0100 . #x01ff))
		(section stack))
    (block stack (size #x100)) ; machine stack size
 
	(memory COMPACT (address (#x0200 . #x7fff))
        (section compactcode cfar ifar switch data_init_table code))

	(memory farVAR (address (#xf000 . #xffdf))
        (section far zfar))

    (memory HEAPMEM (address (#x010000 . #x02ffff))
        (section heap))
    (block heap (size #x020000)) ; heap size

		
	(memory VECTORS (address (#xffe0 . #xffff))
		(section (reset #xfffc)))

    (base-address _DirectPageStart DirectPage 0)
    (base-address _NearBaseAddress COMPACT 0)
))