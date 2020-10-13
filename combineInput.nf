
// basedir is the path where this is script is executed
params.transcriptome = "$baseDir/data/ggal/transcriptome.fa"
params.reads = "$baseDir/data/ggal/*_{1,2}.fq"

reads_ch = Channel.fromFilePairs(params.reads, checkIfExists: true)

process foo {
  input:
    // using a valuechannel to feed path input
    path(transcriptome) from params.transcriptome
    tuple val(sample_id), path(reads) from reads_ch

  script:
    """
    echo align ${sample_id} against ${transcriptome} > ${sample_id}.txt
    """
}
