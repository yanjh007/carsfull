<div class="container">
    <div class="page-header">
      <h1>预约管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading" >					
					预约信息列表
					<div class="input-group pull-right col-md-6">						
						<input type="text" class="form-control" id="keyword">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="do_search()">搜索</button>
						</span>
					</div><!-- /input-group -->
					<div style="clear: both"></div>
				</div>
		      
				<!-- Table -->
			  <table class="table">
				<?php echo zm_table_header("#,客户,车辆,店铺,预约时间,状态","操作") ?>

		        <tbody>
				<?php foreach ($itemlist as $item): ?>
		          <tr>
		            <td><?php echo $item["id"]; ?></td>
		            <td><?php echo $item['userid']; ?></td>
		            <td><?php echo $item["car"]; ?></td>
		            <td><?php echo $item['shop_code']."-".$item["shop_name"]; ?></td>
		            <td><?php echo substr($item['ptime'],5,11); ?></td>
		            <td><?php echo $sdesc[$item['status']]; ?></td>
		            <td align=right>
		            	<?php echo anchor("appointments/".$item["id"],"查看"); ?> |
						<?php link_to_jinput("confirm_input(\"".$item["id"]."/jconfirm\",\"确认预约-".$item["acode"]."\")","确认"); ?> |
						<?php link_to_jinput("confirm_input(\"".$item["id"]."/jcancel\",\"取消预约-".$item["acode"]."\")","取消"); ?> 						
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
				<div class="panel-heading">预约筛选</div>				
				<div class="panel-body">				
				<ul>
				<li><?php echo anchor("appointments?filter=0","全部状态"); ?></li>	
				<li><?php echo anchor("appointments?filter=1","待确认"); ?></li>	
				<li><?php echo anchor("appointments?filter=2","最近确认"); ?></li>	
				<li><?php echo anchor("appointments?filter=3","已取消"); ?></li>	
				<ul>
				</div>
		    </div>
		</div>
    </div>
    <?php zm_dlg_input(array("path"    => base_url("appointments"),
			     "title1"  => "输入备注信息并继续操作",
			     "title2"  => "操作: ")); ?>
</div>


