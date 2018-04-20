# XKMusic
高仿网易云音乐
# 如何让项目跑起来
项目的所有数据都是来自[网易云音乐Api](https://github.com/Binaryify/NeteaseCloudMusicApi.git) 您首先需要做的是将这个node.js项目先目先跑起来  具体的做法  可以去看上面这个项目的介绍 而且有配套的Api文档 当服务跑起来之后 您需要将接口地址在`didFinishLaunchingWithOptions`中配置一下 像这样`[YTKNetworkConfig sharedConfig].baseUrl = @"http://192.168.3.5:3000"` http://本地ip:端口 因为有一些接口是需要登录才可以访问的 所以您还需要配置一下您的网易云账号和密码 也在`didFinishLaunchingWithOptions`中 做完这些 项目基本就可以跑起来了 现在主要实现的功能是播放界面的逻辑 每日推荐以及歌单界面 最近工作忙了 暂时没时间继续写 等闲下来了还是会继续的