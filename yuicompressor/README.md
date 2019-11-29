A Docker image with Yui Compressor

docker pull ivories/yuicompressor
echo "alias yuicompressor='docker run --rm -v $(pwd):/data -w /data ivories/yuicompressor java -jar /yuicompressor-2.4.8.jar'" >> ~/.bashrc
