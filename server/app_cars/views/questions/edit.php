<?php
    $MODULE_PATH="questions/";
?>
<div class="container">
    <div class="page-header">
      <h1>题目编辑 <small><?php echo $item["qcode"] ?></small></h1>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">编辑题目</div>
        <div class="panel-body">
            <?php
                zm_form_open (0,$MODULE_PATH.$item["id"]."/save");
                //zm_form_select(0,"科 目","ccata",$ccata_list,$item["ccata"]);
                zm_form_input(0,"编 码","qcode",  $item["qcode"]);
                zm_form_input(0,"科 目","subject",  $item["subject"]);
                zm_form_input(0,"类 型","qtype",  $item["qtype"]);
                zm_form_input(0,"级 别","grade",  $item["grade"]);
                zm_form_input(0,"难 度","difficulty",  $item["difficulty"]);
                zm_form_textarea(0,"内 容","content", $item["content"]);
                zm_form_textarea(0,"选 项","qoption", $item["qoption"]);
            ?>
            
            <div class="form-group">
              <div class="col-sm-offset-1 col-sm-6">
                <?php
                    zm_btn_submit("保存");
                    zm_form_delete(1,$MODULE_PATH.$item["id"]."/delete",$MODULE_PATH);
                    zm_btn_back($MODULE_PATH)
                ?>
              </div>
            </div>
          </form>
        </div>
    </div>

</div>