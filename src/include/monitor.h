#ifndef MONITOR_H
#define MONITOR_H
extern volatile char* debug_char;
extern volatile char* debug_hex;
extern volatile char* debug_reset;

extern const char *ansi_white;
extern const char *ansi_red;
extern const char *ansi_yellow;

void monitor(void);
#endif