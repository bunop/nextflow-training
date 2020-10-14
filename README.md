nextflow-training
=================

Run some examples
-----------------

```
$ nextflow run combineInput.nf -resume -process.echo
$ nextflow run inputRepeaters.nf -resume -process.echo
```

How to use containers with nextflow
-----------------------------------

Create a file `nextflow.config` (mind `''` for delimiting the paramters):

```
process.container='nextflow/rnaseq-nf'
docker.runOptions='-u $(id -u):$(id -g)'
```

Pull a docker image:

```
$ docker pull nextflow/rnaseq-nf
```

Then call nextflow with `with-docker` parameter:

```
$ nextflow run script2.nf -with-docker
```

Adding:

```
docker.enabled=true
```

to `nextflow.config` let to avoid specifing `-with-docker` parameter when calling nextflow

Override parameters using cmd
-----------------------------

Override the default `reads` parameter:

```
$ nextflow run script3.nf --reads 'data/ggal/*_{1,2}.fq' -resume
```

Calling:

```
$ nextflow run script4.nf
$ nextflow run script4.nf -resume --reads 'data/ggal/*_{1,2}.fq'
```

will execute only the new calculations and will re-use the old computed results
