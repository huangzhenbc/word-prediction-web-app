# word-prediction-web-app
A shiny web app implementing n-gram algorithm for word prediction problems

我们的工作内容包括：

(1) 收集数据集

(2) 处理数据集（生成n gram字典）

(3) 编写前端（根据n gram字典和概率估计算法）

(4) 上传所有材料（文档、数据、程序），开源

目前我们的进度：

(1) 初步整理了中文、英文数据集；仍在继续整理

(2) 完成了初版的处理数据集代码，生成了样例字典（结构正确但数据不对），并上传至github（就在这个目录下）

(3) 前端解决方案已确定，将在下周上线初版及公开源码（同会上传至github这个目录下）

有关算法参见：

https://en.wikipedia.org/wiki/N-gram

我们的英文训练数据集见：

链接: https://pan.baidu.com/s/1c1Kyuu0 密码: n3fq

我们的中文训练数据集见：

http://www.sogou.com/labs/resource/list_news.php

http://www.corpus4u.org/threads/8830/

正在整理的数据集见：（此部分数据集暂未用于训练模型，但整理完毕后可加入训练模型中）

链接: http://pan.baidu.com/s/1gfNqGuv 密码: 3hvg

我们的英文文本处理解决方案是：

R语言，tm, RWeka, openNLP包

我们的中文文本处理解决方案是：

python，jieba包

我们的网页前端解决方案是：

R shiny web app 官方介绍 http://docs.rstudio.com/shinyapps.io/ （这个是做网页端应用的一个非常简便的方法，只需要最少的html知识也可做出很多有趣的应用）

我们的代码均在github的这个目录下。（中文文本处理代码和网页前端代码稍后上传）

其他参考资料有：

https://en.wikipedia.org/wiki/Reproducibility

https://englianhu.files.wordpress.com/2016/01/reproducible-research-with-r-and-studio-2nd-edition.pdf

http://kbroman.org/Tools4RR/assets/lectures/13_python.pdf

http://www.predictiveanalyticstoday.com/top-free-software-for-text-analysis-text-mining-text-analytics/

实用软件：

[txt分割应用](http://www.textfilesplitter.com/)

