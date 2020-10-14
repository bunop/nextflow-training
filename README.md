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
