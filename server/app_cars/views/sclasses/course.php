<?php
    $MODULE_PATH="sclasses/";
    $url_link= base_url($MODULE_PATH)."/".$class_id."/link?";
?>
<div class="container">
    <div class="page-header">
      <h1>班级课程 <small><?php echo $class_name; ?></small></h1>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">课程关联</div>
        <div class="panel-body">
        <div class="row">
            <div class="col-md-4">已关联课程<br>
                <ul><?php
                    if ($links1) foreach ($links1 as $item1) {
                        echo "<li>".anchor($url_link."action=1&rid=".$item1["id"],$item1["name"])."</li>";
                    }                    
                ?></ul>
            </div>
            <div class="col-md-4">可选课程<br>
                <ul><?php
                    if ($links2) foreach ($links2 as $item2) {
                        echo "<li>".anchor($url_link."action=0&rid=".$item2["id"]."&rname=".$item2["name"]."&lname=".$class_name,$item2["name"])."</li>";
                    }                    
                ?></ul>                
            </div>
        </div></div>
    </div>
    
    <div class="panel panel-default">
    <div class="panel-heading">课堂计划</div>
    <div class="panel-body">
    <table class="table">
	<?php echo zm_table_header("#,课程,状态,开始时间,结束时间","操作") ?>
	<tbody>
	<?php foreach ($lesson_list as $item): ?>
		<tr>
		      <td><?php echo  $item["lesson_id"]; ?></td>
		      <td><?php echo  $item['name']; ?></td>
		      <td><?php echo  $status_list[$item["status"]] ?></a></td>
		      <td><?php echo  $item['stime']; ?></td>
		      <td><?php echo  $item['etime']; ?></td>
		      <td align=right>
		      <?php echo anchor($MODULE_PATH."/".$item["lesson_id"]."/lesson_detail","详情"); ?>
		      </td>
		</tr>
	<?php endforeach ?>
	</tbody>
    </table>
    </div></div>

    <?php
        zm_btn_back($MODULE_PATH);
    ?>
</div>