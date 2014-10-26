<?php
    $MODULE_PATH="courses/";
	$str_list1="";
	$str_list2="";
	$icount=0;
	foreach ($contentlist as $item1) {
		$str_list1.=",".$item1["qorder"];
		$str_list2.=anchor($MODULE_PATH.$lesson_id."/report?order=".$item1["qorder"],"<li>".$item1["qorder"]."-".$item1['content']."</li>");
		$list_order[$icount]= $item1["qorder"];
		$icount++;
	} 
	
?>
<div class="container">
    <div class="page-header">
      <h1>课程报告 <small><?php echo $sclass_id."-".$lesson_id ?></small></h1>
    </div>

    <div class="row">
        <div class="col-md-8">
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading" >学生课堂报表</div>
	      
		<!-- Table -->
		<table class="table">
		    <?php echo zm_table_header("学号-姓名".$str_list1,"总计") ?>
		    <tbody>
		    <?php foreach ($studentlist as $item) {
				
				$uid= $item["id"];
				$tscore=0;
				echo "<tr><td>".$item["snumber"]."-".$item["name"]."</td>";
				for ($i=0;$i<$icount;$i++) {
					$order=$list_order[$i];
					$score =isset($score_ary[$uid][$order]) ?$score_ary[$uid][$order] :0;
					$status=isset($status_ary[$uid][$order])?$status_ary[$uid][$order]:0;
					echo "<td>".$score."</td>";
					$tscore+=$score;
				}
				echo "<td align=right>".$tscore."</td></tr>";
		    } ?>
		</tbody>
	      </table>
	    </div>
            <?php zm_btn_back($MODULE_PATH) ?>
        </div>
        
        <div class="col-md-4">
	    <div class="panel panel-default">
		<!-- Default panel contents -->
		<div class="panel-heading">题目列表</div>				
		<div class="panel-body">
			<?php if (count($str_list2)>0) echo "<ul>".$str_list2."</ul>"; ?>
		</div>
	    </div>
	</div>
    </div>

</div>

