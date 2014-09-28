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
                zm_form_select(0,"类 型","mtype",$list1,$item["mtype"]);
                zm_form_input(0,"次 序","morder", $item["morder"]);
                zm_form_input(0,"标 题","name",   $item["name"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
              </div>
            </div>
          </form>
        </div>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">模块内容</div>
        <div class="panel-body">
            <?php
                zm_form_open (0,$MODULE_PATH.$course_id."/save_module_content");
                zm_form_hidden("item_id",$item["id"]);
                zm_form_textarea(0,"内 容","content",$item["content"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
              </div>
            </div>
          </form>
        </div>
    </div>
    
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">删除课程模块 (请输入"Y"确认删除课程模块: <?php echo $item["name"] ?>)</div>
        <div class="panel-body">
            <?php
                zm_form_open (0,"");
                zm_form_input(0,"删除确认","ccode");
            ?>
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button class="btn btn-danger">删 除</button>&nbsp&nbsp&nbsp
              </div>
            </div>
          </form>
        </div>
    </div>
    
    <?php zm_btn_back($MODULE_PATH."/".$course_id."/content") ?>

</div>