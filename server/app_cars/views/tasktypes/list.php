<div class="container">
    <div class="page-header">
      <h1>任务管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading" > 任务列表	 </div>
		      
				<!-- Table -->
				<table class="table">
				  <thead>
					<tr><th>#</th><th>代码</th><th>名称</th><th>间隔时间(天)</th><th>间隔里程(公里)</th>
					  <th>任务时间(分钟)</th><th>任务工费(元)</th>	
					  <th><div class="pull-right"> 操作</div></th></tr>
				  </thead>
  
				  <tbody>
  
				  <?php foreach ($tasktypes as $item): ?>
					<tr>
					  <td><?php echo $item["id"]; ?></td>
					  <td><?php echo $item['tcode']; ?></td>
					  <td><?php echo anchor("tasktypes/".$item["id"],$item["name"],""); ?></td>
					  <td><?php echo $item['duration1']; ?></td>
					  <td><?php echo $item['duration2']; ?></td>
					  <td><?php echo $item['tasktime']; ?></td>
					  <td><?php echo $item['taskprice']; ?></td>
					  <td align=right>
					    <?php link_to_edit("tasktypes/".$item["id"]."/edit"); ?> |
					    <?php link_to_jdelete("confirm_del(".$item["id"].",\"".$item["name"]."\")"); ?>
					  </td>
					</tr>
				  <?php endforeach ?>
				  </tbody>
				</table>
		    </div>    
        </div>
        
        <div class="col-md-4">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">增加任务类型</div>				
				<div class="panel-body">				
					<?php
					    zm_form_open("tasktypes/save");
					    zm_form_input(1,"编 码","tcode","");
					    zm_form_input(1,"名 称","name","");
					    zm_form_input(1,"时间间隔(天)","duration1","30");
					    zm_form_input(1,"里程间隔(公里)","duration2","5000");
					    zm_form_input(1,"基准工时(分钟)","tasktime","45");
					    zm_form_input(1,"基准费用(元)","taskprice","100");
					    zm_btn_submit("增 加");
					?>
					</form>
				</div>
		    </div>
		</div>
    </div>
	
	<?php zm_dlg_delete(array("path"    => base_url("tasktypes"),
							  "title1"  => "确认删除任务信息",
							  "title2"  => "任务: ")); ?>

</div>


