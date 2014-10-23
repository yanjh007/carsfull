<?php
    $MODULE_PATH="courses/";
    $url_link= base_url($MODULE_PATH.$module_id)."/save_lesson?";
    //var_dump($class_list);
    $scode ="20140928-001";
    $status ="定时开启";
    $stime="2014-09-28 14:30";
    $etime="2014-09-28 15:30";
?>
<div class="container">
    <div class="page-header">
      <h1>课堂管理 <small><?php echo $module_name; ?></small></h1>
    </div>

    <?php if(!empty($class_list)): ?>
    <?php foreach ($class_list as $item):
        $class_id=$item["lid"];
        if (isset($lesson_list[$class_id])) {
            $lesson=$lesson_list[$class_id];
        } else {
            $lesson=$new_lesson;
        }
    ?>
    
    <div class="panel panel-default">
        <div class="panel-heading"><?php echo $item["lname"] ?> (<?php echo $lesson["id"]==0?"新建":"编辑"?>)</div>
        <div class="panel-body">
            <?php            
            zm_form_open (0,$url_link."");
            
            zm_form_hidden("lesson_id",$lesson["id"]); //课堂，编辑或新建
            zm_form_hidden("course_id",$course_id); //课程
            zm_form_hidden("class_id",$class_id); //班级
            
            zm_form_input(0,"代 码","lcode",$lesson["lcode"]);
            zm_form_select(0,"状 态","status",$status_list,$lesson["status"]);
            
            $stime=date("Y-m-d H:i",$lesson["stime"]*60);
            zm_form_input(0,"开始时间","stime",$stime);
            
            $etime=date("Y-m-d H:i",$lesson["etime"]*60);
            zm_form_input(0,"结束时间","etime",$etime);
            
            zm_form_input(0,"主持老师","teachers");
            ?>
        </div>
        <div class="panel-footer">
        <?php
            zm_btn_submit("设 置");
            zm_btn_submit("归 档");
        ?></form>
        </div>
    </div>
    <?php endforeach ?>
    <?php else: ?>
    <p>本课程当前没有关联班级，请在班级或课程模块中进行设置。</p>
    <?php endif ?>

    <?php
        zm_btn_back($MODULE_PATH.$course_id."/plan");
    ?>
</div>
