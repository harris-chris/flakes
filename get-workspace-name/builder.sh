export PATH="$coreutils/bin:$gcc/bin"
mkdir -p $out/bin
g++ -o $out/bin/getworkspacename $src
chmod +x $out/bin/getworkspacename
