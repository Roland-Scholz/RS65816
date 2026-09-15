const char * stars = "**************************************";

void print_wolcome() {
    printf("%s\n", stars);
}

void print_prompt() {
    printf(">");
}

void do_function(char c) {
    printf(%c\n");
}

void monitor() {
    char c;

    print_welcome();

    for(;;) {
        print_prompt();
        c = getchar();
        do_function(c);
    }
}
