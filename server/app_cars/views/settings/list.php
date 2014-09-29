<?php
    $MODULE_PATH ="settings/";
?>
<div class="container">
    <div class="page-header">
      <h1>系统设置 </h1>
    </div>


    <div class="panel panel-default">
	<!-- Default panel contents -->
	<div class="panel-heading" >共享密码</div>
	<div class="panel-body">
	    <?php
		zm_form_open(0,$MODULE_PATH."1/save");
		zm_form_input(0,"共享密码","mvalue",$share_pwd);
		
	    ?>
	    <div class="form-group"><div class="col-sm-offset-1 col-sm-6">
		<?php zm_btn_submit("修改"); ?>
	    </div></div>
	    </form>
	</div>
    </div>
    <div class="panel panel-default">
	<!-- Default panel contents -->
	<div class="panel-heading" >资源服务地址</div>
	<div class="panel-body">
	    <?php
		zm_form_open(0,$MODULE_PATH."2/save");
		zm_form_input(0,"地址","mvalue",$resource_path);
	    ?>
	    <div class="form-group"><div class="col-sm-offset-1 col-sm-6">
		<?php zm_btn_submit("修改"); ?>
	    </div></div>
	    </form>
	</div>
    </div>
    
    <div class="panel panel-default">
	<!-- Default panel contents -->
	<div class="panel-heading" >选项测试</div>
	<div class="panel-body">
	    <?php
		zm_form_open(1,$MODULE_PATH."3/save");
		zm_form_check(1,"选项","mvalue[]",$checked_list,$checked_value);
	    ?>
	    <div class="form-group">
		<?php zm_btn_submit("修 改"); ?>
	    </div>
	    </form>
	</div>
    </div>

</div>


