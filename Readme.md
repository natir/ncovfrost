# ncovfrost

A small pipeline to determinate if reads match with covid19 genome.

## Setup

1. Install [Bifrost](https://github.com/pmelsted/bifrost) in your path
2. Create file `references/covid.fasta` with your covid references see [CDCgov SARS-CoV2_Sequencing repe](https://github.com/CDCgov/SARS-CoV-2_Sequencing#bioinformatics)
3. Create file `references/human.fasta` with your favorite human references.
4. Move or create link to your reads file in `reads` directory

## Run

```
snakemake -s pipeline/main.snakefile -j 8 queries/{file1}_k31_e0.8.tsv queries/{file2}_k31_e0.8.tsv …
```

You can change the kmer size `k{kmer size}`. The kmer fraction before to say if match with a reference genome or not `e{kmer fraction}`. 
.
