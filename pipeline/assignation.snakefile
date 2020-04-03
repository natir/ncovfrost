include: "define.snakefile"

rule query:
    input:
        reads = "reads/{filename}.fasta",
        graph = "graphs/graph_k{kmer}.gfa",
        color = "graphs/graph_k{kmer}.bfg_colors",
        
    output:
        query = "queries/{filename}_k{kmer}_e{kmer_ratio}.tsv",

    benchmark:
        "benchmark/queries_{filename}_k{kmer}_e{kmer_ratio}.tsv"
        
    threads: threads_max
             
    shell:
        "Bifrost query -t {threads} -e {wildcards.kmer_ratio} -n -g {input.graph} -f {input.color} -q {input.reads} -o queries/{wildcards.filename}_k{wildcards.kmer}_e{wildcards.kmer_ratio}"

        
rule build_graph:
    input:
        human = "references/human.fasta",
        sras = "references/sras.fasta",

    output:
        graph = "graphs/graph_k{kmer}.gfa",
        color = "graphs/graph_k{kmer}.bfg_colors",
        
    threads: threads_max
        
    shell:
        "Bifrost build -t {threads} -c -k {wildcards.kmer} -r {input.human} -r {input.sras} -o graphs/graph_k{wildcards.kmer}"
