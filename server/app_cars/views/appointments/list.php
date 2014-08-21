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
		        <thead>
		          <tr><th>#</th><th>客户</th><th>车牌</th><th>型号</th><th>预约时间</th><th><div class="pull-right"> 操作</div></th></tr>
		        </thead>

		        <tbody>

				<?php foreach ($appointments as $item): ?>
		          <tr>
		            <td><?= $item["id"]; ?></td>
		            <td><?= $item['client']; ?></td>
		            <td><?= $item["car"]; ?></td>
		            <td><?= $item['car']; ?></td>
		            <td><?= $item['atime']; ?></td>
		            <td align=right>
		            	<?= anchor("appointments/".$item["id"]."/edit","编辑"); ?> |
						<?= anchor("appointments/".$item["id"]."/edit","反馈"); ?> |
						<a href="#" onclick="confirm_del(<?= $item["id"].",'".$item["client"]."'" ?>);">删除</a>
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

				</div>
		    </div>
		</div>
		<?php zm_dlg_delete(array("path"  => base_url("appointments/"),
								"title1"  => "确认删除预约信息",
								"title2"  => "预约: ")); ?>
    </div>
	
</div>


