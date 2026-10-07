
void * malloc (size_t size) {
	return pvPortMalloc( size ); 
}

void * calloc (size_t size, size_t num) {
	return pvPortCalloc( size, num );
}

void free (void * p) {
	vPortFree( p );
}
