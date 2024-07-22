cmd_/root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.o := RUST_MODFILE=/root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion rustc --edition=2021 -Zbinary_dep_depinfo=y -Dunsafe_op_in_unsafe_fn -Drust_2018_idioms -Dunreachable_pub -Dnon_ascii_idents -Wmissing_docs -Drustdoc::missing_crate_level_docs -Dclippy::correctness -Dclippy::style -Dclippy::suspicious -Dclippy::complexity -Dclippy::perf -Dclippy::let_unit_value -Dclippy::mut_mut -Dclippy::needless_bitwise_bool -Dclippy::needless_continue -Wclippy::dbg_macro --target=./rust/target.json -Cpanic=abort -Cembed-bitcode=n -Clto=n -Cforce-unwind-tables=n -Ccodegen-units=1 -Csymbol-mangling-version=v0 -Crelocation-model=static -Zfunction-sections=n -Dclippy::float_arithmetic -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2 -Ztune-cpu=generic -Cno-redzone=y -Ccode-model=kernel -Copt-level=2 -Cdebug-assertions=n -Coverflow-checks=y -Dwarnings  --cfg MODULE  @./include/generated/rustc_cfg -Zallow-features=allocator_api,bench_black_box,core_ffi_c,generic_associated_types,const_ptr_offset_from,const_refs_to_cell -Zcrate-attr=no_std -Zcrate-attr='feature(allocator_api,bench_black_box,core_ffi_c,generic_associated_types,const_ptr_offset_from,const_refs_to_cell)' --extern alloc --extern kernel --crate-type rlib --out-dir /root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust -L ./rust/ --crate-name completion --emit=dep-info,obj /root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.rs; mv /root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.d /root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/.completion.o.d; sed -i '/^$(pound)/d' /root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/.completion.o.d

source_/root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.o := /root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.rs

deps_/root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.o := \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libcore.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libcompiler_builtins.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libkernel.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libbindings.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libmacros.so \
  /root/cicv-r4l-3-ZykoWen/linux/rust/liballoc.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libbuild_error.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libcore.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libcompiler_builtins.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libkernel.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libbindings.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libmacros.so \
  /root/cicv-r4l-3-ZykoWen/linux/rust/liballoc.rmeta \
  /root/cicv-r4l-3-ZykoWen/linux/rust/libbuild_error.rmeta \

/root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.o: $(deps_/root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.o)

$(deps_/root/cicv-r4l-3-ZykoWen/r4l_experiment/driver/003_completion_rust/completion.o):
