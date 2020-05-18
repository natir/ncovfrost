# ncovfrost

A small pipeline to determinate if reads match with covid19 genome.

## Setup

1. Create file `references/sras.fasta` with your covid references see [CDCgov SARS-CoV2_Sequencing repe](https://github.com/CDCgov/SARS-CoV-2_Sequencing#bioinformatics)
2. Create file `references/human.fasta` with your favorite human references.
3. Move or create link to your reads file in `data/reads/raw/{dataset}.fastq`
4. Move or create link to your barcode file in `data/barcodes/{dataset}.csv`

## Run

```
snakemake -s rules/main.snk --configfile config/basic.json -j 8 --use-conda
```

## Configuration

By edit file `config/basic.json` you can change:
- threads\_max control the maximal number of threads use by a task
- reverse\_seq is the adaptater sequence used to perform reverse
- deconvolution\_mismatch control the number of mismatch allow durring deconvolution
- kmer\_size control the kmer size use to build the kmer set
- match\_threshold control the number of kmer need to be present in query to be assign to a reference
- run\_mapping control if we run a classic mapping method to assign reads
