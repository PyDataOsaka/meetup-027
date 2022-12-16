#!/bin/bash
#docker run -it --rm mamba_custom
docker run -it --rm -v $(pwd)/pysoundfile-feedstock:/tmp/pysoundfile-feedstock mamba_custom
