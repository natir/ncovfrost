
threads_max = 32

rule query:
    input:
        reads="reads/{filename}.fasta",
        graph="graphs/graph_k{kmer}.gfa",

    output:
        query="queries/{filename}_k{kmer}_e{kmer_ratio}.tsv",

    threads: threads_max
             
    shell:
        "Bifrost query -t {threads} -e {wildcards.kmer_ratio} -n -g {input.graph} -q {input.reads} -o {output.query}"
        
rule build_graph:
    input:
        human="references/human.fasta",
        covid="references/covid.fasta",

    output:
        "graphs/graph_k{kmer}.gfa",

    threads: threads_max
        
    shell:
        "Bifrost build -t {threads} -k {wildcards.kmer} -r {input.human} -r {input.covid} -o {output}"
