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
		    <?php echo zm_table_header("次序,类型,名称,班级和状态","操作") ?>
		    <tbody>
		    <?php foreach ($itemlist as $item): ?>
                        <tr>
                        <td><?php echo  $item["morder"]; ?></td>
                        <td><?php if (isset($mtype_list[$item["mtype"]])) echo $mtype_list[$item["mtype"]]; ?></td>
                        <td><?php echo  $item["name"]; ?></td>
                        <td><?php
                            $lesson_id=$item["id"];
                            if (isset($sclass_list[$lesson_id])) {
                                    $list=$sclass_list[$lesson_id];
                                    $i=0;
                                    foreach ($list as $row) {
                                        $stime=date("m-d H:i",$row["stime"]*60);
                                        $etime=date("m-d H:i",$row["etime"]*60);
                                         
                                        if ($row["status"]==1) {
                                         $status="(关闭)";
                                        } else if ($row["status"]==2) {
                                         $status="(开启)";
                                        } else if ($row["status"]==3) {
                                         $status="(定时开启 ".$stime.")";
                                        } else if ($row["status"]==4) {
                                         $status="(定时关闭 ".$etime.")";
                                        } else if ($row["status"]==5) {
                                         $status="(".$stime."~".$etime.")";
                                        } else {
                                         $status="";
                                        }

                                        if ($i>0) echo "<br>";
                                        echo anchor ($MODULE_PATH.$row["lid"]."/report?sclass=".$row["sclass"]."&course=".$course_id,$row["class_name"]);
                                        echo $status."&nbsp";
                                        echo anchor($MODULE_PATH.$row["lid"]."/log?sclass=".$row["sclass"]."&course=".$course_id."&class_name=".$row["class_name"]."&lesson_name=".$item["name"],"(日志)");
                                        $i++;
                                    }
                                  }
                        ?></td>

                        <td align=right>
                        <?php echo anchor($MODULE_PATH.$item["id"]."/lesson","状态"); ?> |
                        <?php echo anchor($MODULE_PATH.$item["id"]."/edit_plan","编辑"); ?>
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


