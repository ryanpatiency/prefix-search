#include <stdio.h>
#include <stdlib.h>
#define REF_FILE "ref1.txt"
#define CPY_FILE "cpy1.txt"
#define OUT_REF_FILE "ref_freq.txt"
#define OUT_CPY_FILE "cpy_freq.txt"
#define MAX 256

double hi_bound = 0.0021;
double n = 10;

int get_idx(double time)
{
    int idx = (int)((time * n) / hi_bound);
    return idx > n ? n : idx;
}
double get_low_bound(int idx)
{
    return idx * hi_bound / n;
}

int main()
{

    double time;
    int *a = calloc(n, 4);
    char word[MAX];

    FILE *inreffp = fopen(REF_FILE, "r");
    FILE *outreffp = fopen(OUT_REF_FILE, "w");
    while(fgets(word, MAX, inreffp)) {
        sscanf(word, "%lf", &time);
        a[get_idx(time)] += 1;
    }
    for(int i = 0; i < n; i++) {
        fprintf(outreffp, "%f %d\n", get_low_bound(i), a[i]);
    }
    fclose(inreffp);
    fclose(outreffp);
    free(a);

    a = calloc(n, 4);
    FILE *incpyfp = fopen(CPY_FILE, "r");
    FILE *outcpyfp = fopen(OUT_CPY_FILE, "w");
    while(fgets(word, MAX, incpyfp)) {
        sscanf(word, "%lf", &time);
        a[get_idx(time)] += 1;
    }
    for(int i = 0; i < n; i++) {
        fprintf(outcpyfp, "%f %d\n", get_low_bound(i), a[i]);
    }
    fclose(incpyfp);
    fclose(outcpyfp);
    free(a);
}
