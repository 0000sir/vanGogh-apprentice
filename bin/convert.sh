#! /bin/bash

cd ~/neural-style/
th ~/neural-style/neural_style.lua -style_image $1 -content_image $2 -output_image $3 -gpu 0 -backend clnn $4 -image_size 512
