<?php
    $MODULE_PATH="courses/";
    $course_id=$item["course"];
    $course_name = "";
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
                zm_form_select(0,"类 型","mtype",$mtype_list,$item["mtype"]);
                zm_form_input(0,"次 序","morder", $item["morder"]);
                zm_form_input(0,"标 题","name",   $item["name"]);
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
        <div class="panel-heading">模块内容(未发布)</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-8">
                <table class="table">
				<?php echo zm_table_header("次 序,类 型,代码-内容,分值","操 作") ?>

		        <tbody>

			    <?php $i=1; $count=0; $score=0;
					foreach ($contentlist as $item1): ?>
					<tr>
					  <td><?php echo $item1["qorder"]; ?></td>
					  <td><?php echo $item1["qtype"]; ?></td>
					  <td><?php
						if ($item1["qtype"]!=10 && $item1["qtype"]!=0 ) { //题目条目
							echo "[".$item1["qcode"]."]-".$item1['content']."...";
							$count++;
							$score+=$item1["score"];							
						} else { //内容条目
							echo $item1['content'];
						}
						
						?>
						</td>
					  <td><?php echo $item1["score"]; ?></td>
					  <td align=right>
						<?php echo anchor($MODULE_PATH.$item["id"]."/remove_content?order=".$item1["qorder"],"移除"); ?>
					  </td>
					</tr>
			    <?php
					$i++;
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
					<div class="panel-heading">添加分隔</div>				
					<div class="panel-body">
						<?php
						zm_form_open(1,$MODULE_PATH.$item["id"]."/add_section");
						zm_form_hidden("qtype",10);
						zm_form_input(1,"次 序","qorder");
						zm_form_input(1,"标 题","title");
						zm_btn_submit("增 加");
						?>
						</form>
					</div></div>
					<div class="panel panel-default">
					<!-- Default panel contents -->
					<div class="panel-heading">添加试题</div>				
					<div class="panel-body">
						<?php
						zm_form_open(1,$MODULE_PATH.$item["id"]."/add_content");
						zm_form_input(1,"次 序","qorder");
						zm_form_input(1,"分 值","score");
						zm_form_input(1,"题库代码","qcode");
						zm_btn_submit("增 加");
						zm_btn_click("更 新","#");
						?>
						</form>
					</div></div>
				</div>
                
            </div>
                
        </div>
        </div>
    </div>

</div>