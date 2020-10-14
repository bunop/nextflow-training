
// those are parameters
params.reads = "$baseDir/data/ggal/*_{1,2}.fq"
params.transcriptome = "$baseDir/data/ggal/transcriptome.fa"
params.multiqc = "$baseDir/multiqc"

// exercise 1: add a parameter for output directory
params.outdir = "results"

// you can change parameters from command line, by providing --<parameter name>.
// for example: nextflow run script1.nf --reads this/and/that

// a simple groovy command (print a parameter)
println "reads: $params.reads"

// exercise 2: print all pipeline parameters in a single log.info
log.info """\
         R N A S E Q - N F   P I P E L I N E
         ===================================
         reads        : ${params.reads}
         transcriptome: ${params.transcriptome}
         multiqc      : ${params.multiqc}
         outdir       : ${params.outdir}
         """
         .stripIndent()
