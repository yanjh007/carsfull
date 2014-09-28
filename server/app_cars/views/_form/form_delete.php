<?php if($ftype==0): ?>
<div class="form-group">
	<div class="checkbox">
	  <label>
		<input type="checkbox" id="delete_check" name="delete_check">确认删除
	  </label>
	</div>
	
	<button class="btn btn-danger" onclick="check_delete()">删 除</button>	  
</div>
<script type="text/javascript">
	function check_delete() {
		if ($('#delete_check').is(':checked')) {
			$.ajax({
				type: "DELETE",
				url: "<?php echo $path_delete ?>",
				data:{},
			})
			.done(function( msg ) {
				if (msg == "OK"){
					document.location.href = "<?php echo $path ?>";
				} else {
					alert( "处理错误:" + msg );
				}
			});
		} else {
			alert("请检查确认删除.");
		}		
	}
</script>

<?php elseif ($ftype==1): ?>
<div id="delete_tag" class="hide">0</div>
<button type="button" class="btn btn-danger" id="btn_delete" onclick="delete_again()">删 除</button>&nbsp&nbsp
<script type="text/javascript">
	function delete_again() {
		var tag = $("#delete_tag").text();
		if (tag==0) {
			$("#delete_tag").text("1");
			$("#btn_delete").text("确认删除");			
		} else if (tag==1){
			$.ajax({
				type: "DELETE",
				url: "<?php echo $path_delete ?>",
				data:{},
			})
			.done(function( msg ) {
				if (msg == "OK"){
					document.location.href = "<?php echo $path ?>";
				} else {
					alert( "处理错误:" + msg );
				}
			});
		}	
	
	}
</script>

<?php endif ?>