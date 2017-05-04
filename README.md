## Intr
* 为了方便在浏览器中测试项目下的html文件
* 如果没有安装node会退出
* 如果没有安装 npm包 会提示安装
## Use
* 执行脚本：sh testhtml.sh
* 执行脚本后会 提示输入html文件 格式：*.html
* 如果找到多个相同文件名会提示选择
* 会循环等待 *.html 输入
* Ctrl+c 会退出脚本
## Eg
*     >Desktop sh ./shell/testhtml/testhtml.sh 
*     >tips:Input:*.html will open this html in browser if exist
*     >Ctrl+c will exit this shell script
*     >Input new html file:c.html
*     >0:) ./kefu/chat/dist/partials/cschatroom/c.html
*     >1:) ./kefu/chat/src/partials/cschatroom/c.html
*     >Select number:1
*     >Open:http://localhost:8080/kefu/chat/src/partials/cschatroom/c.html
*     >Input new html file:c.html
*     >0:) ./kefu/chat/dist/partials/cschatroom/c.html
*     >1:) ./kefu/chat/src/partials/cschatroom/c.html
*     >Select number:0
*     >Open:http://localhost:8080/kefu/chat/dist/partials/cschatroom/c.html
*     >Input new html file:^C
