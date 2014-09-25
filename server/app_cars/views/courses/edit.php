<?php
    $MODULE_PATH="courses/";
?>
<div class="container">
    <div class="page-header">
      <h1>课程管理 <small><?php echo $item["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑课程</div>
        <div class="panel-body">
            <?php
                echo form_open($MODULE_PATH.$item["id"]."/save",array('class' => 'form-horizontal', 'role' => 'form'));
                zm_form_input(0,"编 码","ccode",  $item["ccode"]);
                zm_form_input(0,"名 称","name",   $item["name"]);
                zm_form_input(0,"科 目","ccata",$item["ccode"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
                <button class="btn btn-danger">删 除</button>&nbsp&nbsp&nbsp
                <?php zm_btn_back($MODULE_PATH) ?>
              </div>
            </div>
          </form>
        </div>
    </div>
</div>