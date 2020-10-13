#!/usr/bin/env nextflow

params.greeting  = 'Hello world!'

// create a channel from a parameter
greeting_ch = Channel.from(params.greeting)

process splitLetters {

    input:
    // type / variable / from a channel
    val x from greeting_ch

    output:
    // type / variable / into a channel
    file 'chunk_*' into letters

    // whatever we have from the cannel, we can use it as a variable
    """
    printf '$x' | split -b 6 - chunk_
    """
}

process convertToUpper {

    input:
    file y from letters.flatten()

    output:
    stdout into result

    // """
    // cat $y | tr '[a-z]' '[A-Z]'
    // """
    """
    rev $y
    """
}

result.view{ it.trim() }
