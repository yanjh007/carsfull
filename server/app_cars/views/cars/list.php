<div class="container">
    <div class="page-header">
      <h1>车辆管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				
				<div class="panel-heading" >					
					车辆列表（最近20位）
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
		          <tr><th>#</th><th>牌号</th><th>车系</th><th>款型</th><th><div class="pull-right"> 操作</div></th></tr>
		        </thead>

		        <tbody>

				<?php foreach ($cars as $item): ?>
		          <tr>
		            <td><?php echo $item["id"]; ?></td>
		            <td><?php echo anchor("cars/".$item["id"],$item["carnumber"],""); ?></td>
		            <td><?php echo $item['manufacturer']."-".$item['brand']; ?></td>
		            <td><?php echo $item['brand']; ?></td>
		            <td align=right>
				<?php link_to_edit("cars/".$item["id"]."/edit"); ?> |
				<?php link_to_jdelete("confirm_del(".$item["id"].",\"".$item["carnumber"]."\")"); ?>
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
				<div class="panel-heading">增加车辆</div>				
				<div class="panel-body">
				    <?php
					zm_form_open('cars/save');
					zm_form_input(1,"牌照号码","carnumber");
					zm_form_textarea(1,"制造厂商","manufacturer");
					zm_form_textarea(1,"品牌系列","brand");
					zm_btn_submit("增 加");
				    ?>
				    </form>
				</div>
		    </div>
		</div>
    </div>


<script type="text/javascript">
	function confirm_del(cid,cname){
		$("#cname").text(cname);
		$("#carid").text(cid);
		$('#dlg_remove').modal('show').on('shown',function() {
			 
		})
	}

	function do_del(){
		//this will redirect us in same window
		document.location.href = "cars/"+$("#carid").text()+"?method=delete";
	}
	
	function do_search() {
		var keyword=$("#keyword").val();
		
		//this will redirect us in same window
		if (keyword.length>0){
			document.location.href = "cars?search="+keyword;
		} else {
			alert( "搜索关键字无效");
		}
		
	}
	
	function ajax_del(){
		$('#dlg_remove').modal('hide');
		var clientid=$("#clientid").text();
		$.ajax({
			type: "DELETE",
			url: "cars/"+clientid,
		})
		.done(function( msg ) {
			if (msg == "OK"){
				document.location.href = "cars/";
			} else {
				alert( "处理错误:" + msg );
			}
		});
	}

</script>  

<div id="clientid" class="hide"></div>
<div class="modal fade" id="dlg_remove">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">确认删除车辆信息</h4>
      </div>
      <div class="modal-body">
        <p>您确认要删除相关车辆信息吗:</p>
		<p id="cname"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="ajax_del()">确定</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</div>


