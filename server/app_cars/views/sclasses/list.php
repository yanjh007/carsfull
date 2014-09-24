<div class="container">
    <div class="page-header">
      <h1>学校管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		<div class="panel panel-default">
		    <!-- Default panel contents -->
		    <div class="panel-heading" >学校列表</div>
		  
		    <!-- Table -->
		    <table class="table">
			<?php echo zm_table_header("#,编号,名称,地址,班级数量","操作") ?>
			<tbody>
			<?php foreach ($itemlist as $item): ?>
				<tr>
				      <td><?php echo  $item["id"]; ?></td>
				      <td><?php echo  $item['scode']; ?></td>
				      <td><?php echo  anchor("sclasses/".$item["id"],$item["name"],""); ?></td>
				      <td><?php echo  $item['address']; ?></td>
				      <td><?php echo  $item['gyear']; ?></td>
				      <td align=right>
				      <?php link_to_edit("sclasses/".$item["id"]."/edit"); ?> |
				      <?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")"); ?>
				      </td>
				</tr>
			<?php endforeach ?>
		    </tbody>
		  </table>
		</div>
		
		<div class="panel panel-default">
		    <!-- Default panel contents -->
		    <div class="panel-heading" >班级列表</div>
		  
		    <!-- Table -->
		    <table class="table">
			<?php echo zm_table_header("#,编号,名称,毕业年份,位置","操作") ?>
			<tbody>
			<?php foreach ($itemlist2 as $item): ?>
				<tr>
				      <td><?php echo  $item["id"]; ?></td>
				      <td><?php echo  $item['scode']; ?></td>
				      <td><?php echo  anchor("sclasses/".$item["id"],$item["name"],""); ?></td>
				      <td><?php echo  $item['gyear']; ?></td>
				      <td><?php echo  $item['address']; ?></td>
				      <td align=right>
				      <?php link_to_edit("sclasses/".$item["id"]."/edit"); ?> |
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
		<div class="panel-heading">增加学校</div>				
		<div class="panel-body">
			<?php
			    zm_form_open("sclasses/0/save_school");
			    zm_form_input(1,"代 码","scode");
			    zm_form_input(1,"名 称","name");
			    zm_form_input(1,"联系方式","contact");
			    zm_form_textarea(1,"地 址","address");
			    zm_btn_submit("增加学校");
			?>
			</form>
		</div>
	    </div>
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">增加班级</div>				
		<div class="panel-body">
			<?php
			    zm_form_open("sclasses/0/save");
			    zm_form_select(1,"学 校","school",$schools,$school);
			    zm_form_input(1,"代 码","scode");
			    zm_form_input(1,"名 称","name");
			    zm_form_input(1,"毕业年份","gyear");
			    zm_form_input(1,"联系方式","contact");
			    zm_form_textarea(1,"地 址","address");
			    zm_btn_submit("增加班级");
			?>
			</form>
		</div>
	    </div>
	</div>
    </div>
    <?php zm_dlg_delete(array("path" => base_url("sclasses"),  "title1"  => "确认删除",  "title2"  => "删除内容: ")); ?>

</div>


