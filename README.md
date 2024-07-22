# 导学第二阶段作业   
# 作业1   
## 1.安装依赖：   
安装 `flex` 工具。 `flex` 是一个生成词法分析器（lexical analyzer）的工具，它在编译 Linux 内核时是必需的。   
```
sudo apt-get install flex
```
安装 `bison` 工具。`bison` 是一个生成语法分析器（parser）的工具，它在编译 Linux 内核时是必需的。   
```
sudo apt-get install bison
```
安装 LLD 工具。`ld.lld` 是 LLVM 的链接器，它在使用 LLVM/Clang 编译时是必需的。   
```
sudo apt-get install lld
```
安装  `libelf` 库   
```
sudo apt-get install libelf-dev

```
安装 OpenSSL 库   
```
sudo apt-get install libssl-dev
```
`bc` 是一个基本计算器工具，内核编译过程中需要使用。   
```
sudo apt-get install bc
```
 --- 
## 2.指定 Rust 版本   
安装指定版本的 Rust 工具链（包括标准库源代码）：   
```
rustup toolchain install 1.62.0 --component rust-src

```
## 3.进入Linux文件夹，使用如下命令进行编译：   
   
```
make x86_64_defconfig
```
用来生成一个基于 x86\_64 架构的默认配置文件。这个配置文件包含了适用于大多数 x86\_64 系统的默认选项。执行这个命令后，会在当前目录下生成一个 `.config` 文件。   
   
 --- 
```
make LLVM=1 menuconfig
```
这一行命令使用 `menuconfig` 进行内核配置，允许用户通过图形界面（基于 ncurses 的终端界面）来配置内核选项。其中 `LLVM=1` 表示使用 LLVM/Clang 作为编译器，而不是默认的 GCC。   
   
```
#set the following config to yes
General setup
        ---> [*] Rust support

```
启用“Rust support”选项。这将会在内核中启用对 Rust 编程语言的支持。   
   
保证rustc的version: 1.62.0和bindgen —version 0.56.0   
   
 --- 
```
make LLVM=1 -j$(nproc)
```
这行命令用于编译内核， `LLVM=1` 再次指定使用 LLVM/Clang 作为编译器。
`-j$(nproc)` 选项表示使用所有可用的 CPU 核心进行并行编译，以加快编译速度。 `$(nproc)` 会自动替换为当前系统中的 CPU 核心数。   

   
![image.png](files\image.png)    
   
# 作业2   
## 编译内核模块   
进入src\_e1000目录，执行以下命令，该文件夹内的代码将编译成一个内核模块   
```
$make LLVM=1
make -C ../linux M=$PWD
make[1]: Entering directory '/home/zyko/cicv-r4l-3-ZykoWen/linux'
  RUSTC [M] /home/zyko/cicv-r4l-3-ZykoWen/src_e1000/r4l_e1000_demo.o
  MODPOST /home/zyko/cicv-r4l-3-ZykoWen/src_e1000/Module.symvers
  CC [M]  /home/zyko/cicv-r4l-3-ZykoWen/src_e1000/r4l_e1000_demo.mod.o
  LD [M]  /home/zyko/cicv-r4l-3-ZykoWen/src_e1000/r4l_e1000_demo.ko
make[1]: Leaving directory '/home/zyko/cicv-r4l-3-ZykoWen/linux'

```
> Q: 在该文件夹中调用make LLVM=1，该文件夹内的代码将编译成一个内核模块。请结合你学到的知识，回答以下两个问题：   

1、编译成内核模块，是在哪个文件中以哪条语句定义的？   
答：
   
```
make LLVM=1
make -C ../linux M=$PWD

```
这里的 `make -C ../linux M=$PWD` 命令是关键。 `-C` 参数指定了内核源代码目录，而 `M=$PWD` 指定了模块的源代码目录（当前工作目录）。内核的 `Makefile` 会识别 `M` 参数，并调用模块目录中的 `Makefile` 或 `Kbuild` 文件来编译模块。   
2、该模块位于独立的文件夹内，却能编译成Linux内核模块，这叫做out-of-tree module，请分析它是如何与内核代码产生联系的？   
答：**Out-of-tree module**（OFT模块）是指模块的源代码不在内核源代码树中，但仍然可以被内核编译系统编译为内核模块。以下是它如何与内核代码产生联系的分析：   
- 模块目录的 `Makefile` 或 **`Kbuild` 文件**：
模块目录中的 `Makefile` 或 `Kbuild` 文件定义了模块的编译规则。这些规则告诉内核的 `Makefile` 如何编译模块。   
- 内核 **`Makefile` 的处理**：
内核的 `Makefile` 包含了处理外部模块的规则。当你使用 `make -C <内核源代码目录> M=<模块源代码目录>` 命令时，内核的 `Makefile` 会识别 `M` 参数指定的目录，并调用该目录下的 `Makefile` 或 `Kbuild` 文件来编译模块。   
- **模块与内核的联系**：
模块的编译依赖于内核的头文件和一些内核的编译选项。内核的 `Makefile` 会传递必要的头文件路径和编译选项到模块的编译过程中。这样，模块就可以访问到内核的 API 和数据结构。   
- **模块的安装和加载**：
编译完成后，模块会被安装到内核的模块目录（通常是 `/lib/modules/<内核版本>/extra`），并且可以被内核的模块加载机制（如 `modprobe`）加载。   
   
本题：模块位于 `/home/zyko/cicv-r4l-3-ZykoWen/src\_e1000` 目录中。通过以下命令：   
```
make LLVM=1
make -C ../linux M=$PWD

```
- `make LLVM=1` 可能是一个项目特定的编译命令，其中 `LLVM` 可能是一个编译选项，用于指定使用 LLVM 编译器。   
- `make -C ../linux M=$PWD` 命令指定了内核源代码目录为 `../linux`，模块源代码目录为当前目录（ `$PWD`），并开始编译模块。   
   
内核的 `Makefile` 会识别 `M` 参数，并调用 `/home/zyko/cicv-r4l-3-ZykoWen/src\_e1000` 目录中的 `Makefile` 或 `Kbuild` 文件来编译模块。这使得模块虽然不在内核源代码树内，但仍然可以利用内核的编译系统进行编译和管理。   
## 禁用e1000网卡   
启动menuconfig进行配置   
```
make menuconfig

```
（配置路径Device Drivers > Network device support > Ethernet driver support > Intel devices, Intel(R) PRO/1000 Gigabit Ethernet support）并禁用   
## 重新编译内核   
进入 Linux 内核文件夹：   
```
make LLVM=1 -j$(nproc)
```
## 运行build\_image.sh脚本   
```
./build_image.sh

```
进入 qemu 环境，加载驱动：   
```
insmod r4l_e1000_demo.ko
```
![image.png](files\image_z.png)    
使用以下命令验证模块是否正确加载：   
```
lsmod | grep r4l_e1000_demo

```
![image.png](files\image_m.png)    
配置联网：   
```
ip link set eth0 up
ip addr add broadcast 10.0.2.255 dev eth0
ip addr add 10.0.2.15/255.255.255.0 dev eth0 
ip route add default via 10.0.2.1
ping 10.0.2.2

```
![image.png](files\image_w.png)    
![image.png](files\image_d.png)    
![image.png](files\image_r.png)    
验证   
![image.png](files\image_i.png)    
   
# 作业3   
## 将rust\_helloworld放入rust文件下   
![image.png](files\image_k.png)    
## 设置Kconfig   
```
config SAMPLE_RUST_HELLOWORLD
	tristate "Print Helloworld in Rust"
	help
          This option enables the My Rust Module. It is a minimal sample that
          prints "Hello World from Rust module" on initialization.

          If unsure, say N.
```
## 设置Makefile   
```
obj-$(CONFIG_SAMPLE_RUST_HELLOWORLD)		+= rust_helloworld.o
```
## 代码编译   
如果你添加的配置正确，那么可以运行   
```
make LLVM=1 menuconfig


```
更改该模块的配置，使之编译成模块   
```
Kernel hacking
  ---> Sample Kernel code
      ---> Rust samples
              ---> <M>Print Helloworld in Rust (NEW)


```
## 重新编译内核   
进入 Linux 内核文件夹：   
```
make LLVM=1 -j$(nproc)
```
![image.png](files\image_u.png)    
## 运行src\_e1000/build\_image.sh   
```
./build_image.sh

```
## 测试样例   
![image.png](files\image_j.png)    
![image.png](files\image_6.png)    
![image.png](files\image_0.png)    
![image.png](files\image_13.png)    
# 作业4   
## 修改 rust for linux 库函数   
- `linux/rust/kernel/net.rs`   
- `linux/rust/kernel/pci.rs`   
   
## 配置ping通   
![image.png](files\image_9.png)    
## 移除模块   
```
rmmod r4l_e1000_demo.ko
```
![image.png](files\image_n.png)    
## 重新安装模块   
```
insmod r4l_e1000_demo.ko
```
## 重新配置ping通   
![image.png](files\image_4.png)    
   
   
   
# 作业5   
## 修改函数   
```
fn write(this: &Self, _file: &file::File, reader: &mut impl IoBufferReader, offset: u64) -> Result<usize> {
    let offset = offset.try_into()?;
    let mut vec = this.inner.lock();
    let len = core::cmp::min(reader.len(), vec.len().saturating_sub(offset));
    reader.read_slice(&mut vec[offset..][..len])?;
    Ok(len)
}

fn read(this: &Self, _file: &file::File, writer: &mut impl IoBufferWriter, offset: u64) -> Result<usize> {
    let offset = offset.try_into()?;
    let vec = this.inner.lock();
    let len = core::cmp::min(writer.len(), vec.len().saturating_sub(offset));
    writer.write_slice(&vec[offset..][..len])?;
    Ok(len)
}
```
## 修改配置   
```
make LLVM=1 menuconfig

```
更改该模块的配置，使之编译成模块   
```
Kernel hacking
  ---> Sample Kernel code
      ---> Rust samples
              ---> <*>Character device (NEW)

```
## 重新编译内核   
进入 Linux 内核文件夹：   
```
make LLVM=1 -j$(nproc)
```
## 测试   
![image.png](files\image_p.png)    
## Question:   
- **作业5中的字符设备 `/dev/cicv` 是怎么创建的？它的设备号是多少**？**它是如何与我们写的字符设备驱动关联上的？**   
    设备文件 `/dev/cicv` 通过设备号与字符设备驱动关联。当应用程序对 `/dev/cicv` 进行读写操作时，内核会通过设备号将这些操作路由到对应的字符设备驱动。在驱动代码中，使用 `chrdev::Registration` 注册字符设备，并指定了设备名称和设备号。   
    ```
let mut chrdev_reg = chrdev::Registration::new_pinned(name, 0, module)?;
```
    这段代码注册了一个名为 `name` 的字符设备，并指定了次设备号为 0。内核会为该设备分配一个主设备号。当加载驱动模块后，通过 `mknod` 命令创建的设备文件 `/dev/cicv` 就会与该驱动关联。当应用程序对 `/dev/cicv` 进行读写操作时，内核会调用驱动中的 `read` 和 `write` 函数处理这些操作。   
   
   
# 小测验   
## 添加环境变量   
```
export R4L_EXP=/root/cicv-r4l-3-ZykoWen/r4l_experiment
//验证 R4L_EXP 环境变量是否正确设置：
echo $R4L_EXP

```
## 创建initramfs镜像   
```
mkdir -p cicv-r4l-3-ZykoWen/r4l_experiment/initramfs
cd $R4L_EXP/initramfs
# Create necessary directories
mkdir -p {bin,dev,etc,lib,lib64,mnt,proc,root,sbin,sys,tmp}

# Set Permission
chmod 1777 tmp

# Copy necessary device files from host, root privilege maybe needed.
sudo cp -a /dev/{null,console,tty,ttyS0} dev/

```
### 将之前静态编译的busybox拷贝到initramf/bin下   
```
cd $R4L_EXP/initramfs

cp cp /root/cicv-r4l-3-ZykoWen/busybox-1.36.1/busybox  ./bin/
chmod +x bin/busybox
# Install busybox
bin/busybox --install bin
bin/busybox --install sbin

```
### 编写init脚本   
```
cd $R4L_EXP/initramfs

cat << EOF > init
#!/bin/busybox sh

# Mount the /proc and /sys filesystems.
mount -t proc none /proc
mount -t sysfs none /sys

# Boot real things.

# NIC up
ip link set eth0 up
ip addr add 10.0.2.15/24 dev eth0
ip link set lo up

# Wait for NIC ready
sleep 0.5

# Make the new shell as a login shell with -l option
# Only login shell read /etc/profile
setsid sh -c 'exec sh -l </dev/ttyS0 >/dev/ttyS0 2>&1'

EOF

chmod +x init

```
### 更多设置   
```
cd $R4L_EXP/initramfs

# name resolve
cat << EOF > etc/hosts
127.0.0.1    localhost
10.0.2.2     host_machine
EOF

# common alias
cat << EOF > etc/profile
alias ll='ls -l'
EOF

# busybox saves password in /etc/passwd directly, no /etc/shadow is needed.
cat << EOF > etc/passwd
root:x:0:0:root:/root:/bin/bash
EOF

# group file
cat << EOF > etc/group
root:x:0:
EOF

```
### 构建initramfs镜像   
```
cd $R4L_EXP/initramfs

find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz

```
### 通过boot.sh脚本启动   
```
cd $R4L_EXP

# 以下是boot.sh的内容：
#!/bin/sh
kernel_image="../linux/arch/x86/boot/bzImage"

qemu-system-x86_64 \
-kernel $kernel_image \
-append "console=ttyS0" \
-initrd ./initramfs.cpio.gz \
-nographic

# 然后执行以下命令启动
chmod +x boot.sh
./boot.sh  # Press <C-A> x to terminate QEMU.

```
## 支持NFC   
### 在主机上设置NFS服务器   
注意$R4L\_EXP   
```
sudo apt-get install nfs-kernel-server
sudo bash -c "echo \
'$R4L_EXP/driver     127.0.0.1(insecure,rw,sync,no_root_squash)' \
    >> /etc/exports"
sudo /etc/init.d/rpcbind restart
sudo /etc/init.d/nfs-kernel-server restart
```
### 在qemu执行   
```
# Add this line in init script. Put it just after the line of sleep 0.5.
mount -t nfs -o nolock host_machine:/host/cicv-r4l-3-ZykoWen/r4l_experiment/driver /mnt

# 然后rebuild initramfs
cd $R4L_EXP/initramfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz

```
## 支持telnet server   
### 首先设置 pts device node   
```
cd $R4L_EXP/initramfs

mkdir dev/pts
mknod -m 666 dev/ptmx c 5 2
# 同样在init脚本中设置自动挂载，在NFS设置后面加入
mount -t devpts devpts  /dev/pts
# 然后rebuild initramfs
cd $R4L_EXP/initramfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz

```
### 在boot.sh中加入一下qemu启动参数：   
```
-netdev user,id=host_net,hostfwd=tcp::7023-:23 \
-device e1000,mac=52:54:00:12:34:50,netdev=host_net \

```
### 开启telnet server：   
```
# 同样在init脚本中设置自动启动，在telnetserver设置后面加入
telnetd -l /bin/sh
# 然后rebuild initramfs
cd $R4L_EXP/initramfs
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz

```
### 在本机通过telnet server连接qemu控制台   
```
telnet localhost 7023

```
## 重构测试   
### 根据002\_complement重构代码新建文件为003\_complement\_rust   
![image.png](files\image_2.png)    
### 将该代码块编译   
```
make LLVM=1 -j$(nproc)
```
### 通过 `telnet` 链接虚拟环境：   
需要首先在另一个命令行中执行./boot.sh脚本   
```
telnet localhost 7023
```
### 加载模块   
```
cd /mnt/003_completion_rust

```
### 执行脚本   
```
./load_module.sh
```
![image.png](files\image_3.png)    
### 测试   
![image.png](files\image_t.png)    
   
   
