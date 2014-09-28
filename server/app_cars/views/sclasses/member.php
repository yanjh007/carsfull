<?php
    $MODULE_PATH ="sclasses/";
?>
<div class="container">
    <div class="page-header">
      <h1><?php echo $is_school?"学校教员管理":"班级成员管理"; ?>
	  <small><?php echo $class_name ?></small></h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		<div class="panel panel-default">
		    <!-- Default panel contents -->
		    <div class="panel-heading" >教员列表</div>
		  
		    <!-- Table -->
		    <table class="table">
			<?php echo zm_table_header("#,编号,姓名,角色","操作") ?>
			<tbody>
			<?php foreach ($itemlist as $item): ?>
				<tr>
				      <td><?php echo  $item["id"]; ?></td>
				      <td><?php echo  $item['snumber']; ?></td>
				      <td><?php echo  $item["name"]; ?></td>
				      <td><?php echo  $mtype_list[$item['stype']]; ?></td>
				      <td align=right>
				      <?php
					if ($is_school) {
					    echo anchor($MODULE_PATH.$item["id"]."/edit_member","编辑");
					} else {
					    echo anchor($MODULE_PATH.$item["id"]."/remove_member","移除");
					}
					
				      ?>
				      </td>
				</tr>
			<?php endforeach ?>
		    </tbody>
		  </table>
		</div>
		
		<?php if (!$is_school): ?> 
		<div class="panel panel-default">
		    <!-- Default panel contents -->
		    <div class="panel-heading" >学员列表</div>
		  
		    <!-- Table -->
		    <table class="table">
			<?php echo zm_table_header("#,编号,姓名,角色","操作") ?>
			<tbody>
			<?php foreach ($itemlist2 as $item): ?>
			    <tr>
				  <td><?php echo  $item["id"]; ?></td>
				  <td><?php echo  $item['snumber']; ?></td>
				  <td><?php echo  $item['name']; ?></td>
				  <td><?php echo  $item['stype']; ?></td>
				  <td align=right>
				  <?php echo anchor($MODULE_PATH.$item["id"]."/edit_member","编辑"); ?> |
				  <?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")"); ?>
				  </td>
			    </tr>
			<?php endforeach ?>
		    </tbody>
		  </table>
		</div>
		<?php endif ?>
        </div>
	
        <div class="col-md-4">
	    <?php if ($is_school): ?>

	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">增加教员</div>				
		<div class="panel-body">
			<?php
			    zm_form_open(1,$MODULE_PATH.$class_id."/save_member");
			    zm_form_hidden("item_id",0);
			    zm_form_hidden("sclass",$class_id);
			    zm_form_radio(1,"成员类型","stype",$mtype_list,0);
			    zm_form_input(1,"编 号","snumber");
			    zm_form_input(1,"姓 名","name");
			    zm_btn_submit("增加成员");
			?></form>
		</div>
	    </div>
	    <?php else: ?>
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">增加教员</div>				
		<div class="panel-body">
			<?php
			    zm_form_open(1,$MODULE_PATH.$class_id."/add_member");
			    zm_form_hidden("school_id",$school_id);
			    
			    zm_form_input(1,"编 号","snumber");
			    zm_btn_submit("增加教员");
			?></form>
		</div>
	    </div>

	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">增加学员</div>			
		<div class="panel-body">
			<?php
			    zm_form_open(1,$MODULE_PATH.$class_id."/save_member");
			    zm_form_hidden("item_id",0);
			    zm_form_hidden("sclass",$class_id);
			    zm_form_hidden("stype",2);
			    zm_form_input(1,"编 号","snumber");
			    zm_form_input(1,"姓 名","name");
			    zm_btn_submit("增加成员");
			?></form>
		</div>
	    </div>
	    <?php endif ?>
	</div>
    </div>
    <?php zm_btn_back($MODULE_PATH) ?>
    <?php zm_dlg_delete(array("path" => base_url($MODULE_PATH),  "title1"  => "确认删除",  "title2"  => "删除内容: ")); ?>

</div>


