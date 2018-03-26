#include <stdio.h>
#include <stdlib.h>
#define IN_FILE "ref1.txt"
#define OUT_FILE "ref_freq.txt"
#define MAX 256

double hi_bound = 0.0021;
double n = 10;

int get_idx(double time)
{
    return (int)((time * n) / hi_bound);
}
double get_low_bound(int idx)
{
    return idx * hi_bound / n;
}

int main()
{
    FILE *infp = fopen(IN_FILE, "r");
    FILE *outfp = fopen(OUT_FILE, "w");

    double time;
    int *a = calloc(n, 4);
    char word[MAX];

    while(fgets(word, MAX, infp)) {
        sscanf(word, "%lf", &time);
        a[get_idx(time)] += 1;
    }
    for(int i = 0; i < n; i++) {
        fprintf(outfp, "%f %d\n", get_low_bound(i), a[i]);
    }
    fclose(infp);
    fclose(outfp);
    free(a);
}
