<div class="container">
    <div class="page-header"> <h1>菜品管理</h1> </div>
    <div class="row">
        <div class="col-md-8">
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >菜品列表</div>
	      
			<!-- Table -->
			<table class="table">
				<?php echo zm_table_header("#,菜 品,价 格,描 述,类 别","操作") ?>

				<tbody>  
				<?php foreach ($itemlist1 as $item): ?>
				  <tr>
					<td><?php echo $item["id"]; ?></td>
					<td><?php echo $item['name']; ?></td>
					<td><?php echo $item['price']; ?></td>
					<td><?php echo $item['descp'];  ?></td>
					<td></td>
					<td align=right>
					  <?php link_to_edit("dishes/".$item["id"]."/edit"); ?> |
					  <?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["name"]."\")"); ?>
					</td>
				  </tr>
				<?php endforeach ?>
				</tbody>
			</table>
		</div>    
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >套餐列表</div>
	      
			<!-- Table -->
			<table class="table">
				<?php echo zm_table_header("#,套 餐,菜 品,价 格","操作") ?>

				<tbody>  
				<?php foreach ($itemlist2 as $item): ?>
				  <tr>
					<td><?php echo $item["id"]; ?></td>
					<td><?php echo $item['name']; ?></td>
					<td><?php echo $item['name']; ?></td>
					<td><?php echo $item['price']; ?></td>
					<td align=right>
					  <?php link_to_edit("dishes/".$item["id"]."/edit"); ?> |
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
		<div class="panel-heading">分类筛选</div>				
		<div class="panel-body">
			<?php
			    foreach ($catas as $citem) {
				echo $citem["name"];
			    }
			?>
			
			<hr>
			<?php
			    zm_form_open('carseries/0/save');
			    zm_form_input(1,"分 类","manufacturer");
			    zm_btn_submit("增 加");
			?>
			</form>
		</div>
	    </div>
	    <div class="panel panel-default">
		<div class="panel-heading">增加菜品</div>				
		<div class="panel-body">				
			<?php
			    zm_form_open('dishes/0/save1');
			    zm_form_input(1,"菜 品","dname");
			    zm_form_input(1,"价 格","price");
			    zm_form_input(1,"描述信息","descp");
			    zm_btn_submit("增 加");
			?>
			</form>
		</div>
	    </div>
	    <div class="panel panel-default">
		<div class="panel-heading">增加套餐</div>				
		<div class="panel-body">				
			<?php
			    zm_form_open('dishes/0/save2');
			    zm_form_input(1,"套餐名称","sname");
			    zm_form_input(1,"套餐价格","sname");
			    zm_btn_submit("增 加");
			?>
			</form>
		</div>
	    </div>
	</div>
    </div>
	
    <?php zm_dlg_delete(array("path"    => base_url("dishes"),
						      "title1"  => "确认菜品信息",
						      "title2"  => "菜品: ")); ?>

</div>


