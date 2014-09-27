<script type="text/javascript">
	function confirm_del(dmethod,dnote){
		$("#dlg_del_note").text(dnote);
		$("#dlg_del_method").text(dmethod);
		$('#dlg_del_panel').modal('show').on('shown',function() {
			 
		})
	}
	
	function dlg_ajax_del(){
		$('#dlg_del_panel').modal('hide');
		var dmethod=$("#dlg_del_method").text();
		$.ajax({
			type: "DELETE",
			url: "<?php echo $path ?>/"+dmethod,
		})
		.done(function( msg ) {
			if (msg == "OK"){
				document.location.href = "<?php echo isset($path_back)?$path_back:$path ?>";
			} else {
				alert( "处理错误:" + msg );
			}
		});
	}

</script>
<div id="dlg_del_method" class="hide"></div>
<div class="modal fade" id="dlg_del_panel">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title"><?php echo $title1 ?></h4>
      </div>
      <div class="modal-body">
        <p><?php echo $title2 ?></p>
	<p id="dlg_del_note"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-dange" onclick="dlg_ajax_del()">确定</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

