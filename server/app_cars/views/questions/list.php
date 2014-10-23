<?php
    $MODULE_PATH ="questions/";
?>

<div class="container">
    <div class="page-header"> <h1>题库管理 <small><?php if(isset($subtitle)) echo $subtitle ?></small></h1> </div>
    <div class="row">
        <div class="col-md-8">
		<?php if ($list && count($list)) : ?>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >最新编辑题目</div>
	      
			<!-- Table -->
			<table class="table">
				<?php echo zm_table_header("#,代 码,科 目,内 容,级 别,难 度,暂 存","操 作") ?>

				<tbody>  
				<?php foreach ($list as $item): ?>
				  <tr>
					<td><?php echo $item["id"]; ?></td>
					<td><?php echo $item["qcode"]; ?></td>
					<td><?php echo $item['subject']; ?></td>
					<td><?php echo $item['scontent']; ?>...</td>
					<td><?php echo $item['grade']; ?></td>
					<td><?php echo $item['difficulty'];  ?></td>
					<td><?php echo $item['favflag'];  ?></td>
					<td align=right>
					  <?php echo anchor($MODULE_PATH.$item["id"]."/fav?flag=".(($item["favflag"]>0)?0:1),($item["favflag"]>0)?"取消暂存":"暂存"); ?> |
					  <?php echo anchor($MODULE_PATH.$item["id"]."/edit","编辑"); ?>
					</td>
				  </tr>
				<?php endforeach ?>
				</tbody>
			</table>
		</div>
		<?php endif ?>
	</div>
        
        <div class="col-md-4">
	    <div class="panel panel-default">
		<div class="panel-heading">分类筛选</div>				
		<div class="panel-body">
			<?php echo anchor($MODULE_PATH,"全部"); ?> | 
			<?php echo anchor($MODULE_PATH."?filter=1","暂存"); ?>
	    </div></div>
	    <div class="panel panel-default">
		<div class="panel-heading">增加题目</div>				
		<div class="panel-body">				
			<?php
			    zm_form_open(1,$MODULE_PATH.'0/save');
			    //zm_form_radio(1,"","dtype",array("0:菜品","1:套餐"),0);
			    zm_form_input(1,"编 码","qcode");
			    zm_form_select(1,"科 目","subject",$subject_list);
			    zm_form_input(1,"级 别","grade",1);
			    zm_form_input(1,"难 度","difficulty",5);

			    zm_form_select(1,"类 型","qtype",$qtype_list);
			    zm_form_textarea(1,"内 容","content");
			    zm_form_textarea(1,"选 项  ✓ ✗","qoption");
			    zm_btn_submit("增 加");
			?></form>
		</div>
	    </div>
	</div>
    </div>
	
    <?php zm_dlg_delete(array("path"    => base_url("dishes"),
				"title1"  => "确认删除菜品/套餐",
				"title2"  => "菜品/套餐: ")); ?>

</div>


