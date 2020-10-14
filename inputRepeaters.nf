sequences = Channel.fromPath('data/ggal/*.fq')
methods = ['regular', 'expresso', 'psicoffee']

process alignSequences {
  input:
  path seq from sequences
  each mode from methods

  """
  echo t_coffee -in $seq -mode $mode
  """
}
