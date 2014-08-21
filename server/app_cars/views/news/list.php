<h2>新闻列表</h2>
<ul>
<?php foreach ($news as $news_item): ?>
  <li><a href="news/<?php echo $news_item['slug'] ?>"><?php echo $news_item['title'] ?></a></li>
<?php endforeach ?>
<p>
<a href="news/create" class="btn btn-large btn-primary disabled">新 建</a>
</ul>