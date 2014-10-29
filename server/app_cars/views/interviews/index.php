<div class="container">
    <div class="page-header"> <h1>面试测试 <small>成都抓米信息技术有限公司</small></h1> </div>
    <div class="row">
        <div class="col-md-8">
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >说明<br>联系方式请填写手机号。<br>登录系统不需要密码，此处设置的密码是作为测试完成后，以联系方式作为用户标识，用于查询测试结果和反馈的。</div>
			<div class="panel-body">				
				<?php
					zm_form_open(1,'interviews/0/view');
					zm_form_select(1,"测试类别","itype",$itvlist);
					zm_form_input(1,"姓 名","uname");
					zm_form_input(1,"联系方式","contact");
					zm_form_input(1,"密 码","passwd");
					zm_btn_click("开 始","do_submit()");
				?></form>
			</div>	      

		</div>

	</div>
</div>
	
<script  type="text/javascript">
  function do_submit(){
	   var uname  =  $("input[name='uname']").val();
	   var passwd =  $("input[name='passwd']").val();
	   var contact = $("input[name='contact']").val();

	   //checking for blank fields
	   if( uname =='' || passwd ==''|| passwd =='') {
		  alert("请输入用户名、联系方式和查询密码!!");
	   }  else {
		  var hash = $.sha1(passwd); 
		  $("input[name='passwd']").val(hash);
		  $("form").submit();
	   }
  }
</script>


