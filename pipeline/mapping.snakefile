include: "define.snakefile"

rule mapping:
    input:
        reads = "reads/{reads}.fasta",
        bwa_index = "references/{reference}.fasta.bwt",

    output:
        mapping = "mapping/{reads}_{reference}.bam",

    benchmark:
        "benchmark/mapping_{reads}_{reference}.tsv"
        
    threads: threads_max
        
    shell:
        "bwa mem -t {threads} references/{wildcards.reference}.fasta {input.reads} | samtools sort - > {output.mapping}"

        
rule index:
    input:
        reference = "references/{reference}.fasta",
        
    output:
        reference = "references/{reference}.fasta.bwt",

    shell:
        "bwa index {input.reference}"
