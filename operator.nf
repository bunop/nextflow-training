words_ch = Channel.from('hello', 'world').map{ word -> [ word, word.size() ]}

process greeting {
  // same behaviour of using -process.echo when calling nextflow
  echo true

  input:
    tuple val(word), val(word_size) from words_ch

  script:
    """
    echo Word is $word a d Size is $word_size
    """

}
