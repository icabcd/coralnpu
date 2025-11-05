#set env on a new Ubuntu22.04
sudo apt update
sudo apt upgrade
sudo apt install open-vm-tools
sudo apt install open-vm-tools-desktop
apt-cache policy open-vm-tools*
sudo apt install g++ unzip zip
sudo apt install openjdk-11-jdk
#download bazel and install
sudo ./bazel-6.2.1-installer-linux-x86_64.sh 
sudo apt install git
sudo apt install vim-gtk3
sudo apt install wget git tmux make clang llvm time curl flex autoconf bison sqlite3 libsqlite3-dev zstd libzstd-dev libreadline6-dev libsdl2-dev g++-riscv64-linux-gnu zlib1g-dev device-tree-compiler 
sudo apt install srecord

sudo apt install python3-pip
pip3 install cocotb==2.0.0
pip3 index versions cocotb
pip3 index versions cocotb-bus
pip3 index versions cocotb-test
pip3 install cocotb-bus cocotb-test
python3 -c "import cocotb; print(cocotb.__version__)"

cd Downloads/
wget https://github.com/OpenXiangShan/xs-env/blob/master/install-verilator.sh
#change verilator version and install
chmod +x install-verilator.sh 
sudo ./install-verilator.sh 


mkdir work
cd work/
git clone https://github.com/google-coral/coralnpu.git
cd coralnpu/

#search googleapis and replace which local file (file:///home/Downloads/files)
grep googleapis . -r
gvim ./rules/repos.bzl
gvim ./WORKSPACE
gvim ./utils/coralnpu.dockerfile
gvim ./third_party/tflite-micro/Tflite-Micro-CoralNPU-integration.patch
gvim ./third_party/python/requirements.bzl

bazel run //tests/cocotb:core_mini_axi_sim_cocotb
bazel build //examples:coralnpu_v2_hello_world_add_floats
bazel build //examples:coralnpu_v2_hello_world_add_floats
bazel build //tests/verilator_sim:core_mini_axi_sim
#if any files cannot be downloaded,use local file
grep 20230802 . -r
gvim ./rules/repos.bzl
bazel build //tests/verilator_sim:core_mini_axi_sim
bazel-bin/tests/verilator_sim/core_mini_axi_sim --binary bazel-out/k8-fastbuild-ST-dd8dc713f32d/bin/examples/coralnpu_v2_hello_world_add_floats.elf

