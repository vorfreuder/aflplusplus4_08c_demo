set -e

# 编译AFL++
cd $(dirname "$(realpath "$0")")
export CC=clang
export CXX=clang++
make source-only NO_NYX=1

# 查看插桩前后的IR
rm -rf test-instr
rm -rf test-instr_origin.ll
rm -rf test-instr.ll
export AFL_LLVM_INSTRUMENT=CLASSIC
./afl-clang-fast -O0 test-instr.c -o test-instr
clang -S -emit-llvm -O0 test-instr.c -o test-instr_origin.ll
./afl-clang-fast -S -emit-llvm -O0 test-instr.c -o test-instr.ll
