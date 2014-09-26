<?php
    $MODULE_NAME ="sclasses";
?>
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
				      <td><a href="<?php echo "#sclass_".$item["id"] ?>"><?php echo $item["name"] ?></a></td>
				      <td><?php echo  $item['address']; ?></td>
				      <td><?php echo  $item['gyear']; ?></td>
				      <td align=right>
				      <?php link_to_edit($MODULE_NAME."/".$item["id"]."/edit"); ?> |
				      <?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")"); ?>
				      </td>
				</tr>
			<?php endforeach ?>
		    </tbody>
		  </table>
		</div>
		
		<?php $i=0; foreach ($itemlist2 as $item): ?>
		    <?php if ($i!=$item["pid"]): ?>		    
			<?php if ($i>0): ?>
			    </tbody></table></div>
			<?php endif ?>
		    
		    <a id="<?php echo "sclass_".$item["pid"]; ?>"></a>		    
		    <div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >学校: <?php echo $item["sname"] ?></div>
			<!-- Table -->
			<table class="table"></tbody>
			    <?php echo zm_table_header("#,编号,名称,毕业年份,位置","操作") ?>
			
		    <?php $i=$item["pid"]; endif ?>
		    <tr>
			  <td><?php echo  $item["id"]; ?></td>
			  <td><?php echo  $item['scode']; ?></td>
			  <td><?php echo  $item["name"]; ?></td>
			  <td><?php echo  $item['gyear']; ?></td>
			  <td><?php echo  $item['address']; ?></td>
			  <td align=right>
			  <?php echo anchor($MODULE_NAME."/".$item["id"]."/course","课程"); ?> |
			  <?php echo anchor($MODULE_NAME."/".$item["id"]."/member","人员"); ?> |
			  <?php echo anchor($MODULE_NAME."/".$item["id"]."/edit","编辑"); ?> |
			  <?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")"); ?>
			  </td>
		    </tr>
		<?php endforeach ?>

		<?php if ($i>0): ?>
		    </tbody></table></div>
		<?php endif ?>
		
		
        </div>
        
        <div class="col-md-4">
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">增加学校</div>				
		<div class="panel-body">
			<?php
			    zm_form_open(1,$MODULE_NAME."/0/save_school");
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
			    zm_form_open(1,$MODULE_NAME."/0/save");
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
    <?php zm_dlg_delete(array("path" => base_url($MODULE_NAME),  "title1"  => "确认删除",  "title2"  => "删除内容: ")); ?>

</div>


