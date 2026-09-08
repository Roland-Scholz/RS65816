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

static byte memory[256*64*1024];

void read_file(char *filename, word32 address) {
    FILE *fin;
    int flen;

    fin = fopen(filename, "rb");
    if (fin)
    {
        flen = fread(&memory[address], 1, 0xffff, fin);
        fclose(fin);
        printf("%d 0x%04X bytes read into %04X \n", flen, flen, address);
    } else {
        printf("can't read file: %s\n", filename);
    }
}

void load_mem_wdc()
{
    read_file("..\\release\\testwdc.bin", 0x0000);

    memory[0xfffc] = 0x00;
    memory[0xfffd] = 0x02;
}

void load_mem_calypsi()
{
    read_file("..\\release\\vectors.raw", 0xffe0);
    read_file("..\\release\\testc.raw", 0x0200);


}

byte MEM_readMem(word32 address, word32 timestamp, word32 emulFlags)
{
    return memory[address];
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
        break;
    }

    memory[address] = b;
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
    /*
    printf("LONG   : %d\n", sizeof(long));
    printf("INT    : %d\n", sizeof(int));
    printf("SHORT  : %d\n", sizeof(short));
    printf("PTR    : %d\n", sizeof(void *));
    printf("word32 : %d\n", sizeof(word32));
    printf("size_t : %d\n", sizeof(size_t));
    fflush(stdout);
    */

    load_mem_wdc();
    //load_mem_calypsi();

    printf("----------------------------------------\n");
    printf("- Emulation started\n");
    printf("----------------------------------------\n");

    CPUEvent_initialize();
    CPU_reset();
    CPU_setTrace(0);
    CPU_run();

    return 0;
}


