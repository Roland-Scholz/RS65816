/*
 * Kestrel 2 Baseline Emulator
 * Release 1p1
 *
 * Copyright (c) 2006 Samuel A. Falvo II
 * All Rights Reserved
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lib65816/cpu.h"
#include "lib65816/cpuevent.h"

static byte memory[64*1024];

void load_mem()
{
    FILE *fin;
    int flen;

    fin = fopen("..\\release\\vectors.raw", "rb");
    if (fin)
    {
        flen = fread(&memory[0xffe0], 1, 32, fin);
        fclose(fin);
        printf("%d bytes read into 0xffe0 \n", flen);
    }

    fin = fopen("..\\release\\testc.raw", "rb");
    if (fin)
    {
        flen = fread(&memory[0x0200], 1, 0x8000, fin);
        fclose(fin);
        printf("%d bytes read into 0x0200 \n", flen);
    }

    printf("----------------------------------------\n");
    printf("- Emulation started\n");
    printf("----------------------------------------\n");
}

byte MEM_readMem(word32 address, word32 timestamp, word32 emulFlags)
{
    return memory[address & 0xffff];
}

void MEM_writeMem(word32 address, byte b, word32 timestamp)
{
    switch (address)
    {
    case 0xd800:
        printf("%c", b);
        break;
    case 0xd801:
        printf("%02X", b);
        break;
    default:
    }

    memory[address & 0xffff] = b;
}

void EMUL_handleWDM(byte opcode, word32 timestamp)
{
    int i, j;

    switch (opcode)
    {
    case 0:
        fprintf( stderr, "WDM Emulator Exit Requested\n");
        exit(0);
        break;

    case 1:
        //CPU_setTrace(1);
        cpu_cycle_start = cpu_cycle_sum;
        cpu_cycle_pause = 0;
        break;
    case 2:
        //CPU_setTrace(0);
        cpu_cycle_end = cpu_cycle_sum;
        fprintf(stderr, "CPU cycles: %d\n", (int)(cpu_cycle_end - cpu_cycle_start));
        break;
    case 4:
        cpu_cycle_pause += (cpu_cycle_sum - cpu_cycle_start);
        fprintf(stderr, "CPU cycles: %d\n", (int)cpu_cycle_pause);
        break;
    case 5:
        cpu_cycle_start = cpu_cycle_sum;
        break;
    case 6:
        CPU_setTrace(0);
        break;
    case 7:
        CPU_setTrace(1);
        break;
    case 3: /* simple stack trace */
        i = S.W & 0xFFF0;

        for (j = 0; j < 64; j++)
        {
            if ((j & 15) == 0)
                fprintf( stderr, "\n%04X - ", i);
            if (i == S.W)
                fprintf( stderr, "*%02X", MEM_readMem(i, timestamp, 0));
            else
                fprintf( stderr, " %02X", MEM_readMem(i, timestamp, 0));
            i += 1;
        }
        fprintf( stderr, "\n");
        break;

    default:
        fprintf( stderr, "Unknown WDM opcode $%02X at %p\n", opcode, (void *)(size_t)PC.A);
        break;
    }
}

int main(int argc, char *argv[])
{
    long l;
    int i;
    short s;
    char *ptr, ptr1[256];
    word32 w32;
    size_t st;

    printf("LONG   : %lld\n", sizeof(l));
    printf("INT    : %lld\n", sizeof(i));
    printf("SHORT  : %lld\n", sizeof(s));
    printf("PTR    : %lld\n", sizeof(ptr));
    printf("PTR1   : %lld\n", sizeof(ptr1));
    printf("word32 : %lld\n", sizeof(w32));
    printf("size_t : %lld\n", sizeof(st));
    fflush(stdout);

    CPUEvent_initialize();

    load_mem();

    CPU_reset();
    CPU_setTrace(0);
    CPU_run();

    return 0;
}


