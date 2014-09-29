<?php
    $MODULE_PATH ="sclasses/";
    $is_school=($item["utype"]==0);
?>
<div class="container">
    <div class="page-header">
      <h1>
        <?php 
            echo $is_school?"学校管理":"班级管理";
        ?>   
      <small><?php echo $item["name"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑信息</div>
        <div class="panel-body">
            <?php
                zm_form_open(0,$MODULE_PATH.$item["id"].($is_school?"/save_school":"/save"));
                zm_form_input(0,"编 码","scode",  $item["scode"]);
                zm_form_input(0,"名 称","name",   $item["name"]);
                if (!$is_school) {
                    zm_form_select(0,"学 校","school",$school_list,$item["pid"]);
                    zm_form_input (0,"毕业年份","gyear",$item["gyear"]);
                }

                zm_form_input(0,"联系方式","contact",  $item["contact"]);
                zm_form_textarea(0,"地 址","address",  $item["address"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保存");
                    zm_form_delete(1,$MODULE_PATH.$item["id"]."/delete",$MODULE_PATH);
                    zm_btn_back($MODULE_PATH);
                ?>
              </div>
            </div>
          </form>
        </div>
    </div>
</div>