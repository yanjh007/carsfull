<div class="container">
	<?php if ($showmode==0) { ?>
    <div class="page-header"> <h1>测试用户列表 <small></small></h1> </div>
    <div class="row">
        <div class="col-md-8">
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >题目列表</div>
	      
			<!-- Table -->
			<table class="table">
				<?php
					echo zm_table_header("用 户,姓 名,测 试,时 间,状 态,评 分","操作");
					foreach ($list as $item) { ?>
					<tr>
					  <td><?php echo $item["contact"]; ?></td>
					  <td><?php echo $item["name"]; ?></td>
					  <td><?php echo $item["itype"]; ?></td>
					  <td><?php echo $item["itime"]; ?></td>
					  <td><?php echo $item["flag"]; ?></td>
					  <td><?php echo $item["score"]; ?></td>
					  <td align=right><?php echo anchor("interviews/".$item["itype"]."/review?contact=".$item["contact"],"批复"); ?></td>
					</tr>
				<?php } ?>
					
				<tbody></table>  
	</div></div></div>
	
	<?php } elseif ($showmode==1) { ?>

    <div class="page-header"> <h1>测试题目列表 <small><?php if(isset($contact)) echo $contact ?></small></h1> </div>
    <div class="row">
        <div class="col-md-8">
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading" >题目列表</div>
	      
			<!-- Table -->
			<table class="table">
				<?php echo zm_table_header("#,分数,内 容/答 案","评分") ?>

				<tbody>  
				<?php
				$i=1; $n=0; $sum1=0;$sum2=0;
				$count=count($answerlist);
				zm_form_open(1,"interviews/".$itype."/review_commit");
				zm_form_hidden("contact",$contact);
				foreach ($list as $item) { ?>
				  <tr>
					<td><?php echo $i; ?></td>
					<td><?php echo $item["score"];  $sum1+=$item["score"]?></td>
					<td><?php
						echo $item["content"];
						$score=0;
						for($j=$n;$j<$count;$j++) {
							$row=$answerlist[$j];
							if ($row["eorder"]==$item["eorder"]) {
								echo "<div class='alert alert-info' role='alert'>".$row["answer"]."</div>";
								$n=$j;
								$score=$row["score"];
								$sum2+=$score;
								break;
							}
						}
						
					?></td>
					<td align=right width=80><?php zm_form_input(1,"","score_".$item["eorder"],$score); ?></td>

				  </tr>
				<?php $i++;} ?>
				</tbody>
			</table>
			<hr><?php echo "&nbsp&nbsp 共".$i."题,".$sum1."分，已得".$sum2."分"?>
		</div>
	</div>
	</div>
	
	<?php
		zm_btn_submit("提交");
		zm_btn_back("interviews/0/review");
	?>
	</form>
	
	<script>
		function submit() {
			$.ajax({
				type: "POST",
				url:  "<?php echo base_url("interviews/0/commit"); ?>",
				data:{},
			})
			.done(function( msg ) {
				if (msg == "OK"){
					document.location.href = "<?php echo base_url("interviews/") ?>";
				} else {
					alert( "处理错误:" + msg );
				}
			});
		}
		
	</script>
	
	<?php } ?>

</div>


