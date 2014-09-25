<div class="container">
    <div class="page-header">
      <h1>班级成员管理  <small><?php echo $class_name ?></small></h1>
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
				      <td><?php echo  $item['stype']; ?></td>
				      <td align=right>
				      <?php link_to_edit("sclasses/".$item["id"]."/edit_member"); ?> |
				      <?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")"); ?>
				      </td>
				</tr>
			<?php endforeach ?>
		    </tbody>
		  </table>
		</div>
		
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
				  <?php echo anchor("sclasses/".$item["id"]."/edit_member","编辑"); ?> |
				  <?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")"); ?>
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
		<div class="panel-heading">增加成员</div>				
		<div class="panel-body">
			<?php
			    zm_form_open("sclasses/".$class_id."/save_member");
			    zm_form_hidden("item_id",0);
			    zm_form_hidden("sclass",$class_id);
			    zm_form_radio(1,"成员类型","stype",array(array("id"=>0,"value"=>"教师"),array("id"=>1,"value"=>"管理员"),array("id"=>2,"value"=>"学生")),2);
			    zm_form_input(1,"编 号","snumber");
			    zm_form_input(1,"姓 名","name");
			    zm_btn_submit("增加成员");
			?>
			</form>
		</div>
	    </div>

	</div>
    </div>
    <?php zm_dlg_delete(array("path" => base_url("sclasses"),  "title1"  => "确认删除",  "title2"  => "删除内容: ")); ?>

</div>


