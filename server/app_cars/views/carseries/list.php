<div class="container">
    <div class="page-header">
      <h1>车型系列管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading" > 车系列表</div>
		      
				<!-- Table -->
				<table class="table">
					<?php echo zm_table_header("#,厂商,车系,类型,标签","操作") ?>
	
				  <tbody>  
				  <?php foreach ($itemlist as $item): ?>
					<tr>
					  <td><?php echo $item["id"]; ?></td>
					  <td><?php echo $item['manufacturer']; ?></td>
					  <td><?php echo $item['brand']; ?></td>
					  <td><?php echo $item['ctype']; ?></td>
					  <td><?php echo $item['tags']; ?></td>
					  <td align=right>
					    <?php link_to_edit("carseries/".$item["id"]."/edit"); ?> |
					    <?php link_to_jdelete("confirm_del(\"".$item["id"]."/delete\",\"".$item["brand"]."\")"); ?>
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
				<div class="panel-heading">搜索筛选</div>				
				<div class="panel-body">
					<?php
					    $list = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
						for ($i=1;$i<=strlen($list);$i++) {
							$a=substr($list,$i-1,1);
							echo anchor("carseries?tag=".$a,$a."&nbsp");
							if ($i%15==0) echo "<br>";
						}
					?>
				</div>
		    </div>
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">增加车系</div>				
				<div class="panel-body">				
					<?php
					    zm_form_open('carseries/0/save');
					    zm_form_input(1,"厂 商","manufacturer");
					    zm_form_input(1,"品 牌","brand");
					    //zm_form_input(1,"型 号","mcode");
					    zm_form_input(1,"类 型","ctype");
					    zm_form_input(1,"标 签","tags");
					    zm_btn_submit("增 加");
					?>
					</form>
				</div>
		    </div>
		</div>
    </div>
	
	<?php zm_dlg_delete(array("path"    => base_url("carseries"),
							  "title1"  => "确认删除车系信息",
							  "title2"  => "车系: ")); ?>

</div>


