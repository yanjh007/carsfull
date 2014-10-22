<?php
    $MODULE_PATH ="sclasses/";
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
			<?php echo zm_table_header("#,编号,名称,地址,联系方式","操作") ?>
			<tbody>
			<?php foreach ($itemlist as $item): ?>
			    <tr>
			    <td><?php echo  $item["id"]; ?></td>
			    <td><?php echo  $item['scode']; ?></td>
			    <td><a href="<?php echo "#sclass_".$item["id"] ?>"><?php echo $item["name"] ?></a></td>
			    <td><?php echo  $item['address']; ?></td>
			    <td><?php echo  $item['contact']; ?></td>
			    <td align=right>
			    <?php echo anchor($MODULE_PATH.$item["id"]."/member","人员"); ?> |
			    <?php echo anchor($MODULE_PATH.$item["id"]."/edit","编辑"); ?>
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
			  <td class="col-md-1"><?php echo  $item["id"]; ?></td>
			  <td class="col-md-2"><?php echo  $item['scode']; ?></td>
			  <td class="col-md-2"><?php echo  $item["name"]; ?></td>
			  <td class="col-md-2"><?php echo  $item['gyear']; ?></td>
			  <td class="col-md-3"><?php echo  $item['address']; ?></td>
			  <td align=right>
			  <?php
				$url_link=$MODULE_PATH.$item["id"];
				$menu=array(array("mtype"=>0,"mtitle"=>"编 辑","mlink"=>$url_link."/edit"),
					    array("mtype"=>0,"mtitle"=>"人 员","mlink"=>$url_link."/member"),
					    array("mtype"=>0,"mtitle"=>"课 程","mlink"=>$url_link."/course"),
					    );  
				zm_btn_menu(0,"编辑",$menu);
			    ?>
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
		<div class="panel-heading">增加项目</div>				
		<div class="panel-body">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#content1" data-toggle="tab">班级</a></li>
				<li><a href="#content2" data-toggle="tab">学校</a></li>
			</ul>
			<br>
			<div id="myTabContent" class="tab-content">
				<div class="tab-pane active in" id="content1">
					<?php
						zm_form_open(1,$MODULE_PATH."0/save");
						zm_form_select(1,"学 校","school",$school_list,0);
						zm_form_input(1,"代 码","scode");
						zm_form_input(1,"名 称","name");
						zm_form_input(1,"毕业年份","gyear");
						zm_form_input(1,"联系方式","contact");
						zm_form_textarea(1,"地 址","address");
						zm_btn_submit("增加班级");
					?>
					</form>
				</div>
				<div class="tab-pane fade" id="content2">
					<?php
						zm_form_open(1,$MODULE_PATH."0/save_school");
						zm_form_input(1,"代 码","scode");
						zm_form_input(1,"名 称","name");
						zm_form_input(1,"联系方式","contact");
						zm_form_textarea(1,"地 址","address");
						zm_btn_submit("增加学校");
					?>
					</form>
				</div>
			</div>
			
		</div>
	    </div>
	</div>
    </div>
    <?php zm_dlg_delete(array("path" => base_url($MODULE_PATH),  "title1"  => "确认删除",  "title2"  => "删除内容: ")); ?>

</div>


