<?php
    $MODULE_PATH="courses/";
	$course_id=$item["course"];
	
	$str_list1="";
	$str_list2="";
	$icount=0;
	$path=$MODULE_PATH.$module_id."/review?sclass=".$sclass_id."&module=".$module_id;
	foreach ($contentlist as $citem) {
		$str_list1.=",".anchor($path."&uid=0&order=".$citem["qorder"],"[".$citem["qorder"]."]");
		$str_list2.="<li>".$citem["qorder"]."-".$citem['content']."</li>";
		$list_order[$icount]= $citem["qorder"];
		$icount++;
	}
	
	$score_style_list=array(0=>"danger",1=>"warning",2=>"success",3=>"primary",4=>"success");
	
?>
<div class="container">
    <div class="page-header">
      <h1>课程报告 <small><?php echo $sclass_id."-".$module_id ?></small></h1>
    </div>

	<div class="panel panel-default">
	<!-- Default panel contents -->
	<div class="panel-heading">题目列表</div>				
	<div class="panel-body">
		<?php if (count($str_list2)>0) echo "<ul>".$str_list2."</ul>"; ?>
	</div>
    </div>

	
	<div class="panel panel-default">
	<!-- Default panel contents -->
	<div class="panel-heading" >学生课堂报表</div>
	  
	<!-- Table -->
	<table class="table">
	<?php echo zm_table_header("学号-姓名".$str_list1,"总计") ?>
	<tbody>
		<?php
		
		foreach ($studentlist as $item) { //学生列表
			$uid= $item["id"];
			$tscore=0;
			echo "<tr><td>".$item["snumber"]."-".$item["name"]."</td>";
			for ($i=0;$i<$icount;$i++) { // 学生答题列表
				$order=$list_order[$i];
				$score =isset( $score_ary[$uid][$order])?$score_ary[$uid][$order] :0;
				$status=isset($status_ary[$uid][$order])?$status_ary[$uid][$order]:0;
				
				echo "<td><span class='label label-".$score_style_list[$status]."'>";
				echo anchor($path."&order=".$order."&uid=".$uid,$score);
				echo "</span></td>";
				$tscore+=$score;
			}
			echo "<td align=right>".$tscore."</td></tr>";
		} ?>
	</tbody>
	</table>
	</div>
	<?php zm_btn_back($MODULE_PATH.$course_id."/plan") ?>
	

</div>


