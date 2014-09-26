<?php
    $MODULE_PATH="sclasses/";
    $url_link= base_url($MODULE_PATH)."/".$class_id."/link?";
?>
<div class="container">
    <div class="page-header">
      <h1>班级课程管理 <small><?php echo $class_name; ?></small></h1>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">班级课程</div>
        <div class="panel-body">
        <div class="row">
            <div class="col-md-4">已关联课程<br>
                <ul><?php
                    if ($links1) foreach ($links1 as $item1) {
                        echo "<li>".anchor($url_link."action=1&rid=".$item1["id"],$item1["name"])."</li>";
                    }                    
                ?></ul>
            </div>
            <div class="col-md-4">可选课程<br>
                <ul><?php
                    if ($links2) foreach ($links2 as $item2) {
                        echo "<li>".anchor($url_link."action=0&rid=".$item2["id"]."&rname=".$item2["name"]."&lname=".$class_name,$item2["name"])."</li>";
                    }                    
                ?></ul>                
            </div>
        </div></div>
    </div>

    <?php
        zm_btn_back($MODULE_PATH);
    ?>
</div>