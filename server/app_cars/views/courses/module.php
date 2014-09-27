<?php
    $MODULE_PATH="courses/";
    $url_link= base_url($MODULE_PATH)."/".$course_id."/link?";
    //var_dump($class_list);
    $scode ="20140928-001";
    $status ="定时开启";
    $stime="2014-09-28 14:30";
    $etime="2014-09-28 15:30";
?>
<div class="container">
    <div class="page-header">
      <h1>课程模块班级管理 <small><?php echo $module_name; ?></small></h1>
    </div>

    <?php if(!empty($class_list)): ?>
    <?php foreach ($class_list as $item): ?>
    <div class="panel panel-default">
        <div class="panel-heading"><?php echo $item["lname"] ?></div>
        <div class="panel-body">
            <?php
            zm_form_open (0,$url_link);
            zm_form_input(0,"代 码","scode",  $scode);
            zm_form_input(0,"状 态","status", $status);
            zm_form_input(0,"开始时间","stime",$stime);
            zm_form_input(0,"结束时间","etime",$etime);
            ?>
        </div>
        <div class="panel-footer">
        <?php zm_btn_submit("确认设置"); ?></form>
        </div>
    </div>
    <?php endforeach ?>
    <?php else: ?>
    <p>本课程当前没有关联班级，请在班级或课程模块中进行设置。</p>
    <?php endif ?>

    <?php
        zm_btn_back($MODULE_PATH);
    ?>
</div>
