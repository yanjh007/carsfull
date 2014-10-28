<?php
    $MODULE_PATH="courses/";    
?>
<div class="container">
    <div class="page-header">
      <h1>答题批覆 <small><?php echo $module["name"]; ?></small></h1>
    </div>
    
    <div class="panel panel-default">
        <?php
            $content=$module["content"];
            $json=json_decode($content,true);
            
            $content=$json["content"];
            $qtype=0;

            foreach ($content as $citem) {
                if ($qorder== $citem["qorder"]) {
                    $qtype=$citem["qtype"];
                    $str=$citem["content"];
                    break;
                }
            }
            $clist=explode("\n\n\n",$str);
        ?>
        <!-- Default panel contents -->
        <div class="panel-heading">题目信息 (<?php echo $qtype ?>)</div>
        <div class="panel-body">
            <?php
            echo $clist[0]."<br>";
            
            if (isset($clist[1]) && strlen($clist[1])>0) {
                $olist=explode("\n",$clist[1]);
                //echo "选项: <br>";
                $alist=array("A","B","C","D","E","F","G","H","I");
                $i=0;
                $astr="";
                foreach ($olist as $oitem) {
                    $postion1 = strpos($oitem, "✓");
                    if ($postion1!==FALSE) {
                        $oitem = substr($oitem, $postion1+strlen("✓"));
                        $astr.=$alist[$i];
                    }
                    echo $alist[$i].". ".$oitem."<br>";
                    $i++;
                }
                
                echo "参考答案: ".$astr;
            }                       
            ?>
        </div>
        
    </div>
    <?php  ?>
    <div class="panel panel-default">
        <div class="panel-heading">答题批复</div>
        <div class="panel-body">
    
        <?php  zm_form_open (0,$MODULE_PATH.$module_id."/save_review"); ?>
        <?php $i=0;
            zm_form_hidden("sclass",$sclass_id);
            zm_form_hidden("uid",$uid);
            zm_form_hidden("qorder",$qorder);
            zm_form_hidden("mid",$module_id);
                
            foreach($list as $item) {
            if ($i>0) echo "<hr>";  ?>
            
            <div class="row">
            <div class="col-md-4">
                <?php 
                echo "学员代码: ".$item["snumber"]."<br>";
                echo "学员姓名: ".$item["name"]."<br>";
                echo "学员答案: ".$item["answer"]."<br>";
                echo "结果状态: ".$item["status"]."<br>";
                echo "得分: ".$item["score"]."<br>";
                ?>
            </div>
            <div class="col-md-6">
                <?php
                    zm_form_input(1,"修正得分","score_".$item["uid"],   $item["score"]);                
                    $rnote=explode("\n",$item["rnote"]);
                    zm_form_textarea(1,"批复说明","descp_".$item["uid"], $rnote[0]);
                ?>
            </div>        
            </div>
        
        <?php $i++; } ?>        
        </div>        
    </div>
    <?php
        zm_btn_submit("保存");
        echo zm_btn_back($MODULE_PATH.$module_id."/report?sclass=".$sclass_id);        
    ?>
        
</div>