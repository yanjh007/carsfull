<div class="container">
    <div class="page-header">
      <h1>任务组管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading" >					
					任务组列表
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
		          <tr><th>#</th><th>名称</th><th>相关任务</th><th><div class="pull-right"> 操作</div></th></tr>
		        </thead>

		        <tbody>

				<?php foreach ($taskgroups as $item): ?>
		          <tr>
		            <td><?= $item["id"]; ?></td>
		            <td>
					<?= anchor("taskgroups/".$item["id"],$item["name"]); ?>
					</td>
		            <td><ul>
						<?php
						foreach ($tasks as $item2) {
							if ($item2["lid"]==$item["id"]) {
								echo "<li>".$item2["rname"]."</li>";
							}
						}
						?>
					</ul></td>
		            <td align=right>
		            	<?= anchor("taskgroups/".$item["id"]."/edit","编辑"); ?> |
						<a href="#" onclick="confirm_del(<?= $item["id"].",'".$item["name"]."'" ?>);">删除</a>
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
				<div class="panel-heading">增加任务组</div>				
				<div class="panel-body">				
					<?php
						echo form_open('taskgroups/save',array("role"=>"form"));
						zm_form_input(1,"名 称","name","");
						zm_form_textarea(1,"描述信息","descp","");
						zm_btn_submit("增 加");
					?>
					</form>
				</div>
		    </div>
		</div>
    </div>

	<?php zm_dlg_delete(array("path"    => base_url("taskgroups/"),
							  "title1"  => "确认删除任务组信息",
							  "title2"  => "任务组: ")); ?>
							  
</div>



