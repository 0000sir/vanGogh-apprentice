#! /bin/bash

#cd ~/neural-style/
#th ~/neural-style/neural_style.lua -style_image $1 -content_image $2 -output_image $3 -gpu 0 -backend clnn $4 -num_iterations 500 -image_size 512

cd ~/texture_nets/texture_nets-master/
th test.lua -cpu -image_size 512 -input_image $2 -save_path $3 -model_t7 $1
