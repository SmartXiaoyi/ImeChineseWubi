# 使用Delphi编写的中文五笔输入法
> 中文输入法主要包括“拼音输入法”及“五笔字型输入法”（简称“五笔输入法”）。



# 开发环境

- Delphi 12
- Windows 11



# 运行环境

- Windows 10/11

  

# 项目说明

- 本项目移植自“落寞惊梦”所开发的基础项目（详见“项目历史”）
- 本项目将原项目由Delphi7移植至Delphi12，经测试可在Delphi12编译通过，并可在Windows 10/11正常运行
- 本项目的源代码中保留了原作者的信息，向原作者“落寞惊梦”致以崇高的敬意！



# 相对于原项目的修改，及未来的工作

- [x] 将开发环境由Delphi7移植至Delphi12
- [x] 将字库文件（wubiziku.txt，zdfh.txt）由ANSI改为UTF16 LE编码
- [x] 去除Song函数中计算汉字位宽的代码（Unicode不再需要）
- [x] 新增“退出”菜单，方便关闭本输入法
- [ ] 将字库文件改由Sqlite数据库保存
- [ ] 改为IME框架实现
- [ ] 界面优化
- [ ] 支持安装
- [ ] 支持拼音输入法



# 项目历史

- 项目的原作者为：落寞惊梦

- 项目的原开发环境：Delphi 7

- 项目最初发布于：https://bbs.2ccc.com/topic.asp?topicid=691885

  
