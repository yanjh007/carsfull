<div class="container">
    <div class="page-header"> <h1>面试测试 <small>成都抓米信息技术有限公司</small></h1> </div>
    <div class="row">
        <div class="col-md-8">
		<?php
			if(isset($status)) {
				if($status==0) echo "<div class='alert alert-info' role='alert'>已成功注销，请使用前面设定的联系方式和密码登录</div>";
				if($status==1) echo "<div class='alert alert-info' role='alert'>联系方式和前期设置的密码不匹配，请重试或联系管理员</div>";
				if($status==2) echo "<div class='alert alert-info' role='alert'>会话已过期，请重新登录</div>";
			}
		?>

		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >
				说明
			<br>-联系方式请填写手机号，作为后续联系和查询用户标识
			<br>-使用系统不需要密码，此处设置密码是在测试完成后，用于查询测试结果和反馈的。
			<br>-测试时间为60分钟
			<br>-测试题目均为简答题，请抓住重点，简要回答
			</div>
			<div class="panel-body">				
				<?php
					zm_form_open(1,'');
					zm_form_hidden("passwd","");
					zm_form_select(1,"测试类别","itype",$itvlist);
					zm_form_input(1,"姓 名","uname");
					zm_form_input(1,"联系方式","contact");
					zm_form_input(1,"密 码","password","","password");
					zm_btn_click("开 始","do_submit()");
				?></form>
			</div>	      

		</div>

	</div>
</div>
	
<script  type="text/javascript">
  function do_submit(){
	   var uname  =  $("input[name='uname']").val();
	   var passwd =  $("input[name='password']").val();
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


