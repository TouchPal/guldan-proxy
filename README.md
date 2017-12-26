# guldan proxy

guldan proxy是一个独立运行的程序，它为整个操作系统服务，操作系统上的所有进程都可以通过guldan proxy获取他们的配置，并获得实时更新。
这为多个进程使用相同的配置提供了方便，降低了系统消耗。另外以独立进程的形式提供，也提供了一定程度上的隔离。

## guldan proxy获取

### 从源码编译

由于gudlan proxy使用go语言编写，如果选择源码编译，还请安装好[go语言环境](https://golang.org/doc/install)。
guldan proxy 使用glide进行依赖包的管理，所以还请安装[glide](https://github.com/Masterminds/glide)。

```
    git clone this repo to your GOPATH/src
    cd guldan_proxy_root
    glide install
    make
```

在guldan_proxy顶层目录下，你就得到了`guldan-proxy`的二进制文件


## guldan proxy的启动

`./guldan_proxy --help`会列出所有可以使用命令

```
    -debug
        open debug
    -help
        show help
    -listen string
        listen address (default "0.0.0.0:7888")
    -logConfig string
        the path config for logging (default "log.xml")
    -process int
        max process (default 8)
    -proxy string
        proxy address (default "http://127.0.0.1:8080")
    -version
        print current version
```

以下对比较重要的几个参数进行说明：

1. listen

guldan_proxy要监听的本地地址，也就是它为本机进程提供服务的接口，其它的进程可以认为guldan的服务就在本机的这个端口，对它进行相关的guldan http操作。

1. logConfig

根据你自己的需要，可以对`configs/log.xml`进行配置，让后放到你认为合理的地方，它默认会从当前目录寻找log.xml。

1. proxy

这个是guldan的服务地址，guldan_proxy最终会从这里拉取配置


guldan_proxy使用的一个例子是：

```
./guldan_proxy -logConfig configs/log.xml -listen 0.0.0.0:7888 -proxy http://your_guldan_domain:port
```

上面的这个命令是说，guldan被部署在了`http://your_guldan_domain:port`这个地址，而guldan_proxy要监听本机的7888端口，guldan_proxy的日志配置在`configs/log.xml`。

当服务启动后，该操作系统上的进程只需要向本机的7888端口发送请求就可以了，guldan_proxy会自动做配置更新。
