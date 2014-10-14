<?php
    $MODULE_PATH="courses/";
    $url_link= base_url($MODULE_PATH)."/".$class_id."/link?";
?>
<div class="container">
    <div class="page-header">
      <h1>课堂日志 <small><?php echo $lesson_name."(".$class_name.")"; ?></small></h1>
    </div>

    <div class="panel panel-default">
    <div class="panel-heading">课堂计划</div>
    <div class="panel-body">
    <table class="table">
	<?php echo zm_table_header("时间,来源,到达,内容,状态","操作") ?>
	<tbody>
	<?php foreach ($list as $item): ?>
		<tr>
		      <td><?php echo  $item["ltime"]; ?></td>
		      <td><?php echo  $item['rname']; ?></td>
		      <td><?php echo  $item['tname']; ?></td>
		      <td><?php echo  $item['content']; ?></td>
		      <td></td>
		      <td align=right>
		      <?php echo anchor($MODULE_PATH."/".$item["id"]."/log_detail","详情"); ?>
		      </td>
		</tr>
	<?php endforeach ?>
	</tbody>
    </table>
    </div></div>

    <?php
        zm_btn_back($MODULE_PATH.$course_id."/content");
    ?>
</div>