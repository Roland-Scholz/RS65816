int _Stub_close(int fd) {
    return 0;
}

long _Stub_lseek(int fd, long offset, int whence) {
    return 0;
}

void _write(char c) {
    __asm (
        " sep #0x20\n"
        " sta 0xD800\n"
        " rep #0x20"
    ); 
}

void debug_byte(char c) {
    __asm (
        " sep #0x20\n"
        " sta 0xD801\n"
        " rep #0x20"
    ); 
}

void debug_word(unsigned int i) {
	debug_byte(i >> 8);
	debug_byte(i & 0xff);
	_write(' ');
}


size_t _Stub_write(int fd, const void *buf, size_t count) {
	
    char *b = (char *)buf;
	
	//debug_word(count);
	
    for(;count > 0; count--) {
        _write(*b);
		b++;
    }
	return 0;
}