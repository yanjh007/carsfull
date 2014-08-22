<div class="container">
    <div class="page-header">
      <h1>店铺管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading" >					
					店铺列表
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
		          <tr><th>#</th><th>编号</th><th>名称</th><th>地址</th><th>联系方式</th><th><div class="pull-right"> 操作</div></th></tr>
		        </thead>

		        <tbody>

			<?php foreach ($shops as $item): ?>
		          <tr>
		            <td><?php echo  $item["id"]; ?></td>
		            <td><?php echo  $item['scode']; ?></td>
		            <td><?php echo  anchor("shops/".$item["id"],$item["name"],""); ?></td>
		            <td><?php echo  $item['address']; ?></td>
		            <td><?php echo  $item['contact']; ?></td>
		            <td align=right>
				<?php link_to_edit("shops/".$item["id"]."/edit"); ?> |
				<?php link_to_jdelete("confirm_del(".$item["id"].",\"".$item["name"]."\")"); ?>
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
				<div class="panel-heading">增加店铺</div>				
				<div class="panel-body">
				    	<?php
					    zm_form_open("shops/save");
					    zm_form_input(1,"代 码","scode");
					    zm_form_input(1,"名 称","name");
					    zm_form_input(1,"联系方式","contact");
					    zm_form_input(1,"地理位置","geoaddress");
					    zm_form_textarea(1,"地 址","address");
					    zm_btn_submit("增 加");
					?>
					</form>
				</div>
		    </div>
		</div>
    </div>

<script type="text/javascript">
	function confirm_del(sid,sname){
		$("#sname").text(sname);
		$("#shopid").text(sid);
		$('#dlg_remove').modal('show').on('shown',function() {
			 
		})
	}

	function do_del(){
		//this will redirect us in same window
		document.location.href = "shops/"+$("#shopid").text()+"?method=delete";
	}
	
	function do_search() {
		var keyword=$("#keyword").val();
		
		//this will redirect us in same window
		if (keyword.length>0){
			document.location.href = "shops?search="+keyword;
		} else {
			alert( "搜索关键字无效");
		}
		
	}
	
	function ajax_del(){
		$('#dlg_remove').modal('hide');
		var shopid=$("#shopid").text();
		$.ajax({
			type: "DELETE",
			url: "shops/"+shopid,
		})
		.done(function( msg ) {
			if (msg == "OK"){
				document.location.href = "shops/";
			} else {
				alert( "处理错误:" + msg );
			}
		});
	}

</script>  

<div id="shopid" class="hide"></div>
<div class="modal fade" id="dlg_remove">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">确认删除店铺信息</h4>
      </div>
      <div class="modal-body">
        <p>您确认要删除相关店铺信息吗:</p>
		<p id="sname"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="ajax_del()">确定</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</div>


