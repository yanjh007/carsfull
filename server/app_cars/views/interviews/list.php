<div class="container">
    <div class="page-header"> <h1>测试题目列表 <small><?php if(isset($subtitle)) echo $subtitle ?></small></h1> </div>
    <div class="row">
        <div class="col-md-8">
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >题目列表</div>
	      
			<!-- Table -->
			<table class="table">
				<?php echo zm_table_header("#,内 容/答 案","操作") ?>

				<tbody>  
				<?php
				$i=1; $n=0; $count=count($answerlist);

				foreach ($list as $item) { ?>
				  <tr>
					<td><?php echo $i; ?></td>
					<td><?php
						echo $item["content"];
						for($j=$n;$j<$count;$j++) {
							$row=$answerlist[$j];
							if ($row["eorder"]==$item["eorder"]) {
								echo "<br>答:<br><div class='alert alert-info' role='alert'>".$row["answer"]."</div>";
								$n=$j;
								break;
							}
						}
					
					?></td>
					<td align=right width=50>
					  <?php echo anchor("interviews/answer/".$item["eorder"],"答题"); ?>
					</td>
				  </tr>
				<?php $i++; } ?>
				</tbody>
			</table>
		</div>
	</div>
	</div>
	
	<?php
		zm_btn_click("提交","do_submit()");
	?>


</div>


