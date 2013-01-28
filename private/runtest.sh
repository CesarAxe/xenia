python xenia-build.py xethunk
python xenia-build.py build

if [ "$?" -ne 0 ]; then
  echo "Build failed!"
  exit $?
fi

./build/xenia/release/xenia-run \
    private/$1 \
    --optimize_ir_modules=true \
    --optimize_ir_functions=true \
    --trace_kernel_calls=true \
    --trace_user_calls=false \
    --trace_instructions=false \
    1>build/run.txt
    #2>build/run.llvm.txt \

if [ ! -s build/run.llvm.txt ]; then
  rm build/run.llvm.txt
fi

if [ -e build/$1-preopt.bc ]; then
  ./build/llvm/release/bin/llvm-dis build/$1-preopt.bc
fi
if [ -e build/$1.bc ]; then
  ./build/llvm/release/bin/llvm-dis build/$1.bc
fi
