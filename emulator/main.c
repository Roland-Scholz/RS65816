#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include <conio.h>
#include <windows.h>
#include <process.h>

#include "lib65816/cpu.h"
#include "lib65816/cpuevent.h"

static byte memory[256*64*1024];
bool recycle = false;

unsigned __stdcall MeineThreadFunktion(void* pArguments)
{
    /* Casten des void-Pointers zurück auf unsere Datenstruktur */
    //ThreadData* data = (ThreadData*)pArguments;

    for(;;)
    {
        CPU_addIRQ(1);
        //printf(".");
        Sleep(100);
    }

    /* Thread beenden und einen Rückgabewert (Exit-Code) liefern */
    _endthreadex(0);
    return 0;
}

int get_char_by_event()
{
    HANDLE hStdin = GetStdHandle(STD_INPUT_HANDLE);
    INPUT_RECORD irInBuf;
    DWORD count;

    if (hStdin == INVALID_HANDLE_VALUE) return 0;

    // Endlosschleife, bis ein echtes Tastatur-Event eintrifft
    while (1)
    {
        // Warte auf ein Event in der Konsole (Tastatur, Maus, Fenstergröße etc.)
        ReadConsoleInput(hStdin, &irInBuf, 1, &count);

        // Prüfen, ob das Event von der Tastatur kommt UND die Taste GEDRÜCKT wurde (nicht losgelassen)
        if (irInBuf.EventType == KEY_EVENT && irInBuf.Event.KeyEvent.bKeyDown)
        {

            // Ignoriere Modifikatoren wie Shift, Alt, Strg, wenn sie alleine gedrückt werden
            char c = irInBuf.Event.KeyEvent.uChar.AsciiChar;
            if (c != 0)
            {
                return c; // Gibt das Zeichen sofort zurück
            }
        }
    }
}

void read_file(char *filename, word32 address)
{
    FILE *fin;
    int flen;

    fin = fopen(filename, "rb");
    if (fin)
    {
        flen = fread(&memory[address], 1, 0xffff, fin);
        fclose(fin);
        printf("%s : %d 0x%04X bytes read into 0x%04X \n", filename, flen, flen, (unsigned int)address);
    }
    else
    {
        printf("can't read file: %s\n", filename);
    }
}

void load_mem_wdc()
{
    printf("\033[2J\033[H");

    read_file("..\\release\\wdc\\monitor\\monitor.bin", 0x0000);
    read_file("..\\release\\wdc\\rtos\\rtos.bin", 0x010000);

    /*
        set reset address
    */
    memory[0xfffc] = 0x00;
    memory[0xfffd] = 0x00;

    /*
        set IRQ vector
    */
    memory[0xffee] = 0xfa;
    memory[0xffef] = 0xdf;

    memory[0xdffa] = 0x40;      //RTI
}

void load_mem_calypsi()
{
    read_file("..\\release\\calypsi\\vectors.raw", 0xffe0);
    read_file("..\\release\\calypsi\\test_calypsi.raw", 0x0200);
}

byte MEM_readMem(word32 address, word32 timestamp, word32 emulFlags)
{
    switch (address)
    {
    case 0xfffff0:
        return get_char_by_event();
    default:
        return memory[address];
    }

}

void MEM_writeMem(word32 address, byte b, word32 timestamp)
{
    switch (address)
    {
    case 0xfffff0:
        printf("%c", b);
        break;
    case 0xfffff1:
        printf("%02X", b);
        break;
    case 0xfffff2:
        recycle = true;
        break;
    default:
        break;
    }


    /*
        if (address >= 0x100 && address < 0x200)
        {
            if (address < stack)
            {
                stack = address;
                printf("0x%04X, 0x%02X ", (unsigned int)stack, (unsigned int)b);
            }
        }
    */
    memory[address] = b;
}

void EMUL_handleWDM(byte opcode, word32 timestamp)
{
    int i, j;

    switch (opcode)
    {
    case 0:
        printf("--- WDM Emulator Exit Requested\n");
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
    case 8:
        printf("--- emulator infinite loop\n");
        for(;;) {}
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
    /* Thread erstellen und sofort starten */
#ifndef THREAD
    HANDLE hThread = (HANDLE)_beginthreadex(
                         NULL,                   /* Standard-Sicherheitsattribute */
                         0,                      /* Standard-Stackgröße (meist 1 MB) */
                         MeineThreadFunktion,    /* Zeiger auf die Thread-Funktion */
                         NULL,                   /* Zeiger auf die Übergabeparameter */
                         0,                      /* Start-Flag (0 = startet sofort) */
                         NULL                    /* Adresse für die Thread-ID (NULL falls nicht benötigt) */
                     );
    /* Fehlerprüfung */
    if (hThread == NULL)
    {
        printf("[Main] Fehler beim Erstellen des Threads!\n");
        return 1;
    }
#endif
    while (true)
    {
        recycle = false;
        load_mem_wdc();
        //load_mem_calypsi();

        printf("----------------------------------------\n");
        printf("- Emulation started\n");
        printf("----------------------------------------\n");

        fflush(stdout);

        CPUEvent_initialize();
        CPU_reset();
        CPU_setTrace(0);
        CPU_run();
    }

    return 0;
}


