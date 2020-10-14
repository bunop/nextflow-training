
// basedir is the path where this is script is executed
params.transcriptome = "$baseDir/data/ggal/transcriptome.fa"
params.reads = "$baseDir/data/ggal/*_{1,2}.fq"

reads_ch = Channel.fromFilePairs(params.reads, checkIfExists: true)

process foo {
  input:
    // using a value channel (automatically created) to feed path input
    path(transcriptome) from params.transcriptome
    // this is my fromFilePairs channel
    tuple val(sample_id), path(reads) from reads_ch

  script:
    """
    echo align ${sample_id} against ${transcriptome}
    """
}
