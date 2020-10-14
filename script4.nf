/*
 * pipeline input parameters
 */
params.reads = "$baseDir/data/ggal/gut_{1,2}.fq"
params.transcript = "$baseDir/data/ggal/transcriptome.fa"
params.multiqc = "$baseDir/multiqc"
params.outdir = "results"

log.info """\
         R N A S E Q - N F   P I P E L I N E
         ===================================
         transcriptome: ${params.transcript}
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()


/*
 * define the `index` process that create a binary index
 * given the transcriptome file
 */
process index {

    input:
    path transcriptome from params.transcript

    output:
    path 'index' into index_ch

    script:
    """
    salmon index --threads $task.cpus -t $transcriptome -i index
    """
}


Channel
    .fromFilePairs( params.reads, checkIfExists:true )
    .set { read_pairs_ch }

/*
 * Run Salmon to perform the quantification of expression using
 * the index and the matched read files
 */
process quantification {

    // add some directives. I want to see the processed pair in log and publish results
    tag "$pair_id"
    publishDir "${params.outdir}/quant"

    input:
    // is the output of the first process
    // ex: /home/paolo/Projects/NEXTFLOWetude/nextflow-training/work/4f/78ecdd7ba57de9197350b1b999805c/index
    path index from index_ch

    // this is defined from the fromFilePairs channel
    // ex: [gut, [/home/paolo/Projects/NEXTFLOWetude/nextflow-training/data/ggal/gut_1.fq, /home/paolo/Projects/NEXTFLOWetude/nextflow-training/data/ggal/gut_2.fq]]
    tuple val(pair_id), path(reads) from read_pairs_ch

    output:
    path(pair_id) into quant_ch

    script:
    """
    # --libType=U: is a salmon setting
    # $index comes from first process
    # since path(reads) is a tuple, we access the two files with index: ${reads[0]} -2 ${reads[1]}
    # finally $pair_id as the output name directory taken from sample id
    salmon quant --threads $task.cpus --libType=U -i $index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}
