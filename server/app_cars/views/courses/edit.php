<?php
    $MODULE_PATH="courses/";
?>
<div class="container">
    <div class="page-header">
      <h1>课程编辑 <small><?php echo $item["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑课程</div>
        <div class="panel-body">
            <?php
                zm_form_open (0,$MODULE_PATH.$item["id"]."/save");
                zm_form_input(0,"编 码","ccode",  $item["ccode"]);
                zm_form_input(0,"名 称","name",   $item["name"]);
                zm_form_input(0,"科 目","ccata",$item["ccata"]);
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
        <div class="panel-heading">删除课程 (请输入"Y"确认删除课程<?php echo $item["name"] ?>)</div>
        <div class="panel-body">
            <?php
                zm_form_open (0,"");
                zm_form_input(0,"确 认","ccode");
            ?>
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button class="btn btn-danger">删 除</button>&nbsp&nbsp&nbsp
              </div>
            </div>
          </form>
        </div>
    </div>
    <?php zm_btn_back($MODULE_PATH) ?>

</div>