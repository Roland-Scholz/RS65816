void *far_heap_start = (void *)0x010000;
void *far_heap_end = (void *)0x02ffff;

void *heap_start = (void *)0x030000;
void *heap_end = (void *)0x03ffff;


#asm
	clc
	xce
	rep #$30
	lda #$fddf
	tcs
	lda #$8000
	tcd
	jmp _~main
#endasm

#ifdef EXCLUE
void debug(const char *format, ...) {
	va_list args;

	char *strbuf = malloc(256);
	
    va_start(args, format);
    vsprintf(strbuf, format, args);
    va_end(args);
	
	write(0, strbuf, strlen(strbuf));
	free(strbuf);
}

int unlink(const char *pchar) {
	debug("unlink called name: %s\n", pchar);

	return 1;
}

void print_str(const char *str) {
	while(*str) {
		*debug_char = *str++;
	}
}

size_t write(int fd, void *buf, size_t size) {
	char *p = (char *)buf;
	const char *ansi;
	//char str[16];
	
	//sprintf(str, "%d\n", size);
	//print_str(str);
	
	switch (fd) {
		case 0:
			ansi = ansi_yellow;
			break;
		case 2:
			ansi = ansi_red;
			break;
		default:
			ansi = NULL;
			break;
	}
	
	print_str(ansi);
	
	for(;size > 0; size--) {
		if (fd < 3 && *p == '\n') {
			*debug_char = '\r';
		}
		*debug_char = *p;
		p++;
	}
	
	if (ansi) 
		print_str(ansi_white);
	
	return size;
}

size_t read(int fd, void *buf, size_t size) {
	return *debug_char;
}
int close(int fd) {
	return 1;
}
int open(const char * _name, int _mode) {
	debug("open called name:%s, mode:%d\n", _name, _mode);
	return 1;
}

int isatty(int fd) {
	debug("isatty called fd:%d\n", fd);
	return 1;
}
long lseek(int fd, long offset, int whence) {
	debug("lseek called fd:%d, offset:%d, whence:%d\n", fd, offset, whence);

	return 1;
}
#endif