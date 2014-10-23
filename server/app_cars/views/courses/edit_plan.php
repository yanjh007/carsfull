<?php
    $MODULE_PATH="courses/";
    $course_id=$item["course"];
    $course_name = "";
	$mtype=$item["mtype"]; //13-测试和考试 14-作业 10-课程说明 11-互动课堂
	$type_list=$ctype_list+$qtype_list;
	$type_list[10]="分隔";
?>
<div class="container">
    <div class="page-header">
      <h1>课程内容模块 <small><?php echo $course_name."-".$item["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">基本信息</div>
        <div class="panel-body">
            <?php
                zm_form_open (0,$MODULE_PATH.$course_id."/save_module");
                zm_form_hidden("item_id",$item["id"]);
                zm_form_hidden("mtype",$mtype);
                //zm_form_select(0,"类 型","mtype",$mtype_list,$item["mtype"]);
                zm_form_input(0,"标 题","name",   $item["name"]);
                zm_form_input(0,"次 序","morder", $item["morder"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保存");
                    zm_form_delete(1,$MODULE_PATH.$item["id"]."/delete",$MODULE_PATH);
                    zm_btn_back($MODULE_PATH.$course_id."/plan");
                ?>
              </div>
            </div>
          </form>
        </div>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">模块内容 (<?php echo $item["status"]==0?"未发布":"已发布"; ?> )</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-8">
                <table class="table">
				<?php
					echo zm_table_header(($mtype==13)?"次 序,类 型,代码-内容,分值":"次 序,类 型,内 容","操 作") ?>
		        <tbody>

			    <?php $i=1; $count=0; $score=0; $qorder=1;
					foreach ($contentlist as $item1): ?>
					<tr>
						<td><?php echo $item1["qorder"]; ?></td>
						<td><?php echo $type_list[$item1["qtype"]]; ?></td>
						<td><?php
						if ($item1["qcode"]>0) {
							echo "[".$item1["qcode"]."]-".$item1['content']."...";
						} else { //内容条目
							echo $item1['content'];
						}
						
						if ($item1["qtype"]>10) $count++;
							
						if (isset($item1["score"]) && ($item1["score"]>0)) $score+=$item1["score"];
						
						?>
						</td>
						<?php if($mtype==13) echo "<td>".$item1["score"]."</td>"; ?>
						<td align=right>
							<?php echo anchor($MODULE_PATH.$item["id"]."/remove_content?order=".$item1["qorder"],"移除"); ?>
						</td>
					</tr>
			    <?php
					$i++;
					$qorder=$item1["qorder"];
					endforeach
				?>
		        </tbody>
                </table>
				
				<?php echo "有效题目: ".$count." ,  总分值: ".$score."<br><br>"; ?>
				<?php zm_btn_click("导 出","#"); ?>
				<?php zm_btn_link("发 布",$MODULE_PATH.$item["id"]."/pub_content"); ?>
                </div>
                
                <div class="col-md-4">
					<div class="panel panel-default">
					<!-- Default panel contents -->
					<div class="panel-heading">添加项目</div>
					<div class="panel-body">
						<?php
							$qorder++;
							if ($mtype==13) {
								zm_tabs(0,"#citem_add","分隔,题库,试题");
							} elseif ($mtype==14) {
								zm_tabs(0,"#citem_add","内容,,题目");
							}
						?>

						<br>
						<div id="myTabContent" class="tab-content">							
							<?php if ($mtype==13) { ?>
							<div class="tab-pane active in" id="citem_add_0">
								<?php
								zm_form_open(1,$MODULE_PATH.$item["id"]."/add_section");
								zm_form_hidden("qtype",10);
								zm_form_input(1,"次 序","qorder",$qorder);
								zm_form_input(1,"标 题","title");
								zm_btn_submit("增 加");
								?></form>
							</div>
							
							<div class="tab-pane fade" id="citem_add_1">
								<?php
								zm_form_open(1,$MODULE_PATH.$item["id"]."/add_lib");
								zm_form_input(1,"次 序","qorder",$qorder);
								zm_form_input(1,"分 值","score",5);
								zm_form_input(1,"题库代码","qcode");
								zm_btn_submit("增 加");
								?></form>
							</div>
							
							<?php } else if($mtype==14) { ?>
							<div class="tab-pane active in" id="citem_add_0">
								<?php
								zm_form_open(1,$MODULE_PATH.$item["id"]."/add_content");
								zm_form_input(1,"次 序","qorder",$qorder);
								zm_form_select(1,"类 型","qtype",$ctype_list);
								zm_form_textarea(1,"内 容","content");
								zm_btn_submit("增 加");
								zm_btn_click("更 新","#");
								?></form>
							</div>		
							<?php } ?>
							
							<div class="tab-pane fade" id="citem_add_2">
								<?php
								zm_form_open(1,$MODULE_PATH.$item["id"]."/add_question");
								zm_form_input(1,"次 序","qorder",$qorder);

								if ($mtype==13) zm_form_input(1,"分 值","score",5); //考试
																
								zm_form_input(1,"编 码 (填写将加入题库)","qcode");
								
								zm_form_select(1,"科 目","subject",$subject_list);
								zm_form_select(1,"题 型","qtype",$qtype_list);
								zm_form_input(1,"级 别","grade",5);
								zm_form_input(1,"难 度","difficulty",5);
								
								zm_form_textarea(1,"内 容","content");
								zm_form_textarea(1,"选 项 ✓ ✗","qoption");
								
								zm_btn_submit("增 加");
								zm_btn_click("更 新","#");
								?></form>
							</div>
						</div>
					</div></div>
				</div>                
            </div>                
        </div>
        </div>
    </div>

</div>