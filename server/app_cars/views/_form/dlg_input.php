<script type="text/javascript">
	function confirm_input(dmethod,dnote){
		$("#dlg_input_note").text(dnote);
		$("#dlg_input_id_method").text(dmethod);
		$('#dlg_input_panel').modal('show').on('shown',function() { })
	}
	
	function dlg_ajax_input(){
		$('#dlg_del_panel').modal('hide');
		
		var dmethod = $("#dlg_input_id_method").text();
		var note1   = $("#dlg_input_text").val();
		$.ajax({
			type: "POST",
			url: "<?php echo $path ?>/"+dmethod,
			data:{ note:note1},
		})
		.done(function( msg ) {
			if (msg == "OK"){
				document.location.href = "<?php echo $path ?>";
			} else {
				alert( "处理错误:" + msg );
			}
		});
	}
</script>
<div id="dlg_input_id_method" class="hide"></div>
<div class="modal fade" id="dlg_input_panel">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title"><?php echo $title1 ?></h4>
      </div>
      <div class="modal-body">
        <p><?php echo $title2 ?></p>
	<p id="dlg_input_note"></p>
	<textarea id="dlg_input_text" cols="40" rows="2" id="address" class="form-control"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-dange" onclick="dlg_ajax_input()">确定</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

