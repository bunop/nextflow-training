
/*
 * pipeline input parameters
 */
params.reads = "$baseDir/data/ggal/*_{1,2}.fq"
params.transcriptome = "$baseDir/data/ggal/transcriptome.fa"
params.multiqc = "$baseDir/multiqc"
params.outdir = "results"

println """\
         R N A S E Q - N F   P I P E L I N E
         ===================================
         transcriptome: ${params.transcriptome}
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()


/*
 * define the `index` process that create a binary index
 * given the transcriptome file
 */
process index {
    // set cpus using directives
    cpus 2

    input:
    // a path from parameters
    path transcriptome from params.transcriptome

    output:
    // when index task is complete, nextflow will look for a index directory
    // (specified in salmon command) and will place it into the index_ch
    path 'index' into index_ch

    script:
    // --threads is a salmon option. $task.cpus access to config in cmd
    """
    salmon index --threads $task.cpus -t $transcriptome -i index
    """
}

// index_ch is a single element and this single element is the directory where
// index is stored
index_ch.view()
