<div class="container">
    <div class="page-header"> <h1>菜品管理 <small><?php if(isset($subtitle)) echo $subtitle ?></small></h1> </div>
    <div class="row">
        <div class="col-md-8">
		<?php if ($showmode!=2 && $itemlist1 && count($itemlist1)) : ?>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >菜品列表</div>
	      
			<!-- Table -->
			<table class="table">
				<?php echo zm_table_header("#,编 号,菜 品,价 格,描 述,类 别","操作") ?>

				<tbody>  
				<?php foreach ($itemlist1 as $item): ?>
				  <tr>
					<td><?php echo $item["id"]; ?></td>
					<td><?php echo $item["dcode"]; ?></td>
					<td><?php echo $item['name']; ?></td>
					<td><?php echo $item['price']; ?></td>
					<td><?php echo $item['descp'];  ?></td>
					<td></td>
					<td align=right>
					  <?php link_to_edit("dishes/".$item["id"]."/edit"); ?> |
					  <?php link_to_jdelete("confirm_del(\"".$item["id"]."/jdelete\",\"".$item["name"]."\")"); ?>
					</td>
				  </tr>
				<?php endforeach ?>
				</tbody>
			</table>
		</div>
		<?php endif ?>
		<?php if ($showmode!=1 && $itemlist2 && count($itemlist2)) : ?>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >套餐列表</div>
	      
			<!-- Table -->
			<table class="table">
				<?php echo zm_table_header("#,编 号,套 餐,菜 品,价 格","操作") ?>

				<tbody>  
				<?php foreach ($itemlist2 as $item): ?>
				  <tr>
					<td><?php echo $item["id"]; ?></td>
					<td><?php echo $item['dcode']; ?></td>
					<td><?php echo $item['name']; ?></td>
					<td><?php echo $item['name']; ?></td>
					<td><?php echo $item['price']; ?></td>
					<td align=right>
					  <?php link_to_edit("dishes/".$item["id"]."/edit"); ?> |
					  <?php link_to_jdelete("confirm_del(\"".$item["id"]."/jdelete\",\"".$item["name"]."\")"); ?>
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
		    <?php
			echo anchor(base_url("dishes"),"##")."&nbsp";
			echo anchor(base_url("dishes?filter=-1"),"单品")."&nbsp";
			echo anchor(base_url("dishes?filter=-2"),"套餐")."&nbsp";
		    ?><br>
			<?php
			    if($catas) foreach ($catas as $citem) {
				echo anchor(base_url("dishes?filter=".$citem["id"]),$citem["name"])."&nbsp";
			    }
			?>
			
			<hr>
			<?php
			    zm_form_open('dishes/0/addcata');
			    zm_form_input(1,"增加分类","name");
			    zm_btn_submit("增 加");
			?>
			</form>
		</div>
	    </div>
	    <div class="panel panel-default">
		<div class="panel-heading">增加菜品/套餐</div>				
		<div class="panel-body">				
			<?php
			    zm_form_open('dishes/0/save');
			    zm_form_radio(1,"","dtype",array("0:菜品","1:套餐"),0);
			    zm_form_input(1,"编 码","dcode");
			    zm_form_input(1,"名 称","name");
			    zm_form_input(1,"价 格","price");
			    zm_form_textarea(1,"描述信息","descp");
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


