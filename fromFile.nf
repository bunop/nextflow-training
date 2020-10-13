
params.path = 'data/ggal/*_{1,2}.fq'
reads_ch = Channel.fromFilePairs(params.path, checkIfExists: true).view()

process get_reads {
  input:
  tuple val(sample_id), file(reads_file) from reads_ch

  output:
  file("${sample_id}.txt") into fastqc_ch

  script:
  """
  echo ${sample_id} > ${sample_id}.txt
  """
}
