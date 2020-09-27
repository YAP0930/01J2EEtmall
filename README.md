# J2EEtmall
## 项目简介
这是一个使用J2EE技术实现的模仿天猫整站，包括后台和前端完整功能。<br>
## 运行方式
直接下载到本地Eclipse开发环境中，启动Eclipse中内置的tomcat服务器，即可运行该项目。<br>
在浏览器中打开http://localhost:8080/J2EEtmall/forehome，可浏览前台。<br>
在浏览器中打开http://localhost:8080/J2EEtmall/admin，可浏览后台
## 设计模式
### 1、MVC
MVC设计模式贯穿于整个后台与前台功能开发始末
### 2、Filter+Servlet+反射
采用Filter+Servlet+反射的设计模式，<br>
把原本后台需要20多个Servlet的经典Servlet设计方式，精简到了7个。<br>
把原本前台需要20多个Servlet的经典Servlet设计方式，精简到了2个。<br>
web.xml的配置文件也大大减少，降低了开发和维护的工作量，减少了出错的几率。
### 3、模块化JSP设计
从大的JSP文件中，通过JSP包含关系抽象出多个公共文件，并把业务JSP按照功能，设计为多个小的JSP文件，便于维护和理解
## 项目结构
### java源代码包结构
bean  实体类<br>
dao  DAO类<br>
filter  过滤器<br>
servlet  Servlet类<br>
util  工具类<br>
comparator  比较器<br>
### WebContent目录
css  css文件<br>
img  图片资源<br>
js  js文件<br>
include  被包含的jsp文件<br>
index  前台管理用到的jsp文件<br>
admin  后台管理用到的jsp文件<br>
## 典型场景
在这个项目中，完成了如下的一系列典型场景功能
### 1、购物车
立即购买、 加入购物车 、查看购物车页面 、购物车页面操作
### 2、订单状态流转
生成订单、 确认支付、 后台发货、 确认收货、 评价
### 3、CRUD
后台各种功能
### 4、分页
后台各种功能
### 5、一类产品多属性配置
后台的属性管理
### 6、一款产品多图片维护
后台的产品图片管理
### 7、产品展示
前台首页、 前台产品页
### 8、搜索查询
前台搜索
### 9、登录、注册
注册 登录 退出
<br>
##### 源码仅供学习使用哦 ，有任何问题欢迎前来交流。
