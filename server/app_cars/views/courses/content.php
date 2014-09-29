<?php
    $MODULE_PATH="courses/";
?>
<div class="container">
    <div class="page-header">
      <h1>课程内容管理 <small><?php echo $course_name ?></small></h1>
    </div>

    <div class="row">
        <div class="col-md-8">
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading" >教学模块列表</div>
	      
		<!-- Table -->
		<table class="table">
		    <?php echo zm_table_header("次序,类型,名称,开启班级","操作") ?>
		    <tbody>
		    <?php foreach ($itemlist as $item): ?>
                        <tr>
                        <td><?php echo  $item["morder"]; ?></td>
                        <td><?php if (isset($mtype_list[$item["mtype"]])) echo $mtype_list[$item["mtype"]]; ?></td>
                        <td><?php echo  $item["name"]; ?></td>
                        <td><?php if (isset($sclass_list[$item["id"]])) echo $sclass_list[$item["id"]]; ?></td>

                        <td align=right>
                        <?php echo anchor($MODULE_PATH.$item["id"]."/lesson","状态"); ?> |
                        <?php echo anchor($MODULE_PATH.$item["id"]."/edit_module","编辑"); ?>
                        </td>
                        </tr>
		    <?php endforeach ?>
		</tbody>
	      </table>
	    </div>
            <?php zm_btn_back($MODULE_PATH) ?>
        </div>
        
        <div class="col-md-4">
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">增加教学模块</div>				
		<div class="panel-body">
			<?php
			    zm_form_open(1,$MODULE_PATH.$course_id."/save_module");
                            zm_form_hidden("item_id",0);
			    zm_form_select(1,"类 型","mtype",$mtype_list);
			    zm_form_input(1,"名 称","name");
			    zm_form_input(1,"位 置","morder");
			    zm_form_textarea(1,"内 容","content");
			    zm_btn_submit("增加模块");
			?>
			</form>
		</div>
	    </div>
	</div>
    </div>

</div>


