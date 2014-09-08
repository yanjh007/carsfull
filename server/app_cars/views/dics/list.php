<div class="container">
    <div class="page-header">
      <h1>字典管理 </h1>
    </div>

    <div class="row">
        <div class="col-md-8">
			<?php foreach ($dic_list as $item): ?>
				<?php if ($item["did"]==0): ?>
					<div class="panel panel-default">
					<div class="panel-heading" ><?php echo $item["name"]; ?></div>
					<div class="row show-grid">
				<?php elseif ($item["did"]==100): ?>
					</div></div>
				<?php else:  ?>
					<div class="col-xs-4">
					<button type="button" class="btn btn-primary"><?php echo $item["name"] ?></button>
					</div>
				<?php endif ?>
			<?php endforeach ?>
        </div>

        <div class="col-md-4">
		    <div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">增加项目</div>				
				<div class="panel-body">				
					<?php					    
					    zm_form_open('dics/0/save');
					    zm_form_input(1,"类 型","dtype");
					    zm_form_input(1,"次 序","did");
					    zm_form_input(1,"简 称","sname");
					    zm_form_input(1,"简单描述","sdesc");
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
		$("#clientid").text(cid);
		$('#dlg_remove').modal('show').on('shown',function() {
			 
		})
	}

	function do_del(){
		//this will redirect us in same window
		document.location.href = "clients/"+$("#clientid").text()+"?method=delete";
	}
	
	function do_search() {
		var keyword=$("#keyword").val();
		
		//this will redirect us in same window
		if (keyword.length>0){
			document.location.href = "clients?search="+keyword;
		} else {
			alert( "搜索关键字无效");
		}
		
	}
	
	function ajax_del(){
		$('#dlg_remove').modal('hide');
		var clientid=$("#clientid").text();
		$.ajax({
			type: "DELETE",
			url: "clients/"+clientid,
		})
		.done(function( msg ) {
			if (msg == "OK"){
				document.location.href = "clients/";
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
        <h4 class="modal-title">确认删除客户信息</h4>
      </div>
      <div class="modal-body">
        <p>您确认要删除相关客户信息吗:</p>
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


