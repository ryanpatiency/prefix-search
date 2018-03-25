#include <stdio.h>
#define IN_FILE "cities.txt"
#define OUT_FILE "command.txt"
#define MAX 256

int main()
{
    FILE *infp = fopen(IN_FILE, "r");
    FILE *outfp = fopen(OUT_FILE, "w");
    char word[MAX];
    char city[MAX];
    char country[MAX];
    while(fgets(word, MAX, infp)) {
        sscanf(word, "%[^,], %s", city, country);
        city[4] = '\0';
        fprintf(outfp, "s\n%s\n", city);
    }
    fprintf(outfp, "q\n");
    fclose(infp);
    fclose(outfp);
}
