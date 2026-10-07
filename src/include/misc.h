#ifndef MISC_H
#define MISC_H

void * farmalloc ( unsigned long size );
void * farcalloc ( unsigned long num, unsigned long size );
void farfree( void * ptr );

#endif