<div class="container">
    <div class="page-header">
      <h1>型号管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading" > 最近型号列表</div>
		      
				<!-- Table -->
				<table class="table">
				  <thead>
					<tr><th>#</th><th>厂商－品牌</th><th>型号</th><th>名称</th><th>类别</th>	
					  <th><div class="pull-right"> 操作</div></th></tr>
				  </thead>
  
				  <tbody>
  
				  <?php foreach ($carmodels as $item): ?>
					<tr>
					  <td><?= $item["id"]; ?></td>
					  <td><?= $item['manufacturer']."-".$item['brand']; ?></td>
					  <td><?= anchor("carmodels/".$item["id"],$item["mcode"],""); ?></td>
					  <td><?= $item['mname']; ?></td>
					  <td><?= $item['ctype']; ?></td>
					  <td align=right>
						  <?= anchor("carmodels/".$item["id"]."/edit","编辑"); ?> |
						  <a href="#" onclick="confirm_del(<?= $item["id"].",'".$item["mcode"]."'" ?>);">删除</a>
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
				<div class="panel-heading">增加型号</div>				
				<div class="panel-body">				
					<?= form_open('carmodels/save',array("role"=>"form")); ?>					
					<?php
						zm_form_input(1,"型 号","mcode","");
						zm_form_input(1,"名 称","mname","");
						zm_form_input(1,"厂商","manufacturer","");
						zm_form_input(1,"品牌","brand","");
						zm_form_input(1,"类型","ctype","");
						zm_btn_submit("增 加");
					?>
					</form>
				</div>
		    </div>
		</div>
    </div>
	
	<?php zm_dlg_delete(array("path"    => base_url("carmodels"),
							  "title1"  => "确认删除型号信息",
							  "title2"  => "型号: ")); ?>

</div>


