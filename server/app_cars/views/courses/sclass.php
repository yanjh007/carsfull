<?php
    $MODULE_PATH="courses/";
    $url_link= base_url($MODULE_PATH)."/".$course_id."/link?";
?>
<div class="container">
    <div class="page-header">
      <h1>课程班级管理 <small><?php echo $course_name; ?></small></h1>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">单品分类</div>
        <div class="panel-body">
        <div class="row">
            <div class="col-md-4">已关联班级<br>
                <ul><?php
                    if ($links1) foreach ($links1 as $item1) {
                        echo "<li>".anchor($url_link."action=1&lid=".$item1["id"],$item1["name"])."</li>";
                    }                    
                ?></ul>
            </div>
            <div class="col-md-4">可选班级<br>
                <ul><?php
                    if ($links2) foreach ($links2 as $item2) {
                        echo "<li>".anchor($url_link."action=0&lid=".$item2["id"]."&lname=".$item2["name"]."&rname=".$course_name,$item2["name"])."</li>";
                    }                    
                ?></ul>                
            </div>
        </div></div>
    </div>

    <?php
        zm_btn_back($MODULE_PATH);
    ?>
</div>
