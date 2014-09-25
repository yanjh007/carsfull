<?php
    $module="sclasses";
    $mtype=$item["stype"];
?>
<div class="container">
    <div class="page-header">
      <h1>班级成员管理  <small><?php echo $item["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑成员</div>
        <div class="panel-body">
            <?php
                echo form_open($module."/".$item["sclass"]."/save_member",array('class' => 'form-horizontal', 'role' => 'form'));
                zm_form_hidden("item_id",$item["id"]);
                zm_form_input(0,"编 码","snumber",  $item["snumber"]);
                zm_form_input(0,"名 称","name",   $item["name"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <button type="submit" class="btn btn-primary">保 存</button>&nbsp&nbsp&nbsp
                <button class="btn btn-danger">删 除</button>&nbsp&nbsp&nbsp
                <?php zm_btn_back($module."/".$item["sclass"]."/member") ?>
              </div>
            </div>
          </form>
        </div>
    </div>
</div>