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
        <div class="panel-heading">模块内容</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-8">
                <table class="table">
		        <thead>
		          <tr><th>次序</th><th>类型</th><th>题库代码</th><th>内容</th><th><div class="pull-right"> 操作</div></th></tr>
		        </thead>

		        <tbody>

			    <?php $i=1;
					foreach ($list as $item1): ?>
					<tr>
					  <td><?php echo $i; ?></td>
					  <td><?php echo $item1["type"]; ?></td>
					  <td><?php if (isset($item1["qcode"])) echo $item1["qcode"]; ?></td>
					  <td><?php
						if ($item1["type"]==10) {
							echo $item1['title'];
						} else {
							echo $item1['content'];
						}
						
					   ?></td>
					  <td align=right>
						<?php echo anchor($MODULE_PATH.$item["id"]."/remove_content?order=".$i,"移除"); ?>
					  </td>
					</tr>
			    <?php
					$i++;
					endforeach
				?>
		        </tbody>
                </table>
                </div>
                
                <div class="col-md-4"><div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">选择试题</div>				
				<div class="panel-body">
				    <?php
					zm_form_open(1,$MODULE_PATH.$item["id"]."/save_content");
					zm_form_hidden("contentlist",count($list)>0?json_encode($list):"");
					zm_form_input(1,"次 序","qorder");
					zm_form_input(1,"分 值","score");
					zm_form_input(1,"题库代码","qcode");
					zm_btn_submit("增 加");
				    ?>
				    </form>
				</div></div></div>
                
            </div>
                
        </div>
        </div>
    </div>

</div>